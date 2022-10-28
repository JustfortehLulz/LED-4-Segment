----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2022 06:22:29 PM
-- Design Name: 
-- Module Name: binaryDisplay - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binaryDisplay is
Port (signal SW:             in std_logic_vector(12 downto 0);
      signal clk,reset:      in std_logic;
      signal segmentDisplay: out std_logic_vector(6 downto 0);
      signal an:             out std_logic_vector(3 downto 0);
      signal dp:             out std_logic);
end binaryDisplay;

architecture Behavioral of binaryDisplay is
    -- CONSTANTS --
    constant FPGA_CLK : integer := 100e6;
    constant LIGHT_CLK : integer := 1e3;

    -- SIGNALS -- 
    signal decVal : std_logic_vector(3 downto 0);
    -- the decmial value of a given binary value
    signal totalVal : integer range 0 to 8192 := 0;

    -- output clock after prescaler
    signal clk_output : std_logic := '0';
    
    -- states of the state machine
    type t_state is (resetState,digitZero,digitOne,digitTwo,digitThree);
    signal State : t_state;

    
begin
    -- need to create a prescaler for the 'clock' of the 7 display segment 
    -- a 62.5 Hz clock cycle is needed for the display
    PRESCALER : entity work.prescaler(Behavioral)
    generic map(
        fpga_clk => FPGA_CLK,
        light_clk => LIGHT_CLK
        )
    port map(
    clk_in => clk,
    rst => reset,
    clock_out => clk_output
    );
    

    -- drives what the values of each LED segment should be
    -- converts the SW to an integer which is then translated into the segment display for each light
   Process(clk,reset,SW)

   begin
       if reset = '1' then
           totalVal <= 0;
           
       elsif rising_edge(clk) then
            totalVal <= to_integer(unsigned(SW));
       end if;
   end process;

    -- deals with the timing of 4 segment display
    Process(clk,clk_output,reset,SW)
        -- variables containing the numerical positions 
        variable onePos : integer range 0 to 9 := 0;
        variable tenPos : integer range 0 to 9 := 0;
        variable hundredPos : integer range 0 to 9 := 0;
        variable thousandPos : integer range 0 to 9 := 0;
        -- intermediate steps
        variable interTen : integer := 0;
        variable interHundred : integer := 0;
    Begin
        if reset = '1' then
            State <= resetState;
            dp <= '0';
            an <= "0000";
            -- totalVal <= 0;
        elsif rising_edge(clk_output) then
                
            case State is 
                when resetState =>
                    -- code is run below when the rising edge of clk_output is triggered
                    an <= "1010";
                    
                    if clk = '1' then
                        State <= digitZero;
                    end if;

                when digitZero => 
                    onePos := totalVal mod 10;
                    case onePos is
                        when 0 => segmentDisplay <= "1000000";
                        when 1 => segmentDisplay <= "1111001";
                        when 2 => segmentDisplay <= "0100100";
                        when 3 => segmentDisplay <= "0110000";
                        when 4 => segmentDisplay <= "0011001";
                        when 5 => segmentDisplay <= "0010010";
                        when 6 => segmentDisplay <= "0000010";
                        when 7 => segmentDisplay <= "1111000";
                        when 8 => segmentDisplay <= "0000000";
                        when 9 => segmentDisplay <= "0010000";
                        when others => segmentDisplay <= "0000000";
                    end case;
                    --segmentDisplay <= interSeg;
                    dp <= '1';
                    an <= "1110";
                    if clk = '1' then
                        State <= digitOne;
                    end if;
                    
                when digitOne => 
                    interTen := totalVal mod 100;
                    tenPos := (interTen - onePos) / 10;
                    case tenPos is
                        when 0 => segmentDisplay <= "1000000";
                        when 1 => segmentDisplay <= "1111001";
                        when 2 => segmentDisplay <= "0100100";
                        when 3 => segmentDisplay <= "0110000";
                        when 4 => segmentDisplay <= "0011001";
                        when 5 => segmentDisplay <= "0010010";
                        when 6 => segmentDisplay <= "0000010";
                        when 7 => segmentDisplay <= "1111000";
                        when 8 => segmentDisplay <= "0000000";
                        when 9 => segmentDisplay <= "0010000";
                        when others => segmentDisplay <= "0000000";
                    end case;
                        -- segmentDisplay <= interSeg;
                        dp <= '1';
                        an <= "1101";
                    
                    if clk = '1' then
                        State <= digitTwo;
                    end if;
                    
                when digitTwo => 
                    interHundred := totalVal mod 1000;
                    hundredPos := (interHundred - interTen) / 100;
                    case hundredPos is
                        when 0 => segmentDisplay <= "1000000";
                        when 1 => segmentDisplay <= "1111001";
                        when 2 => segmentDisplay <= "0100100";
                        when 3 => segmentDisplay <= "0110000";
                        when 4 => segmentDisplay <= "0011001";
                        when 5 => segmentDisplay <= "0010010";
                        when 6 => segmentDisplay <= "0000010";
                        when 7 => segmentDisplay <= "1111000";
                        when 8 => segmentDisplay <= "0000000";
                        when 9 => segmentDisplay <= "0010000";
                        when others => segmentDisplay <= "0000000";
                    end case;
                        -- segmentDisplay <= interSeg;                  
                        dp <= '1';
                        an <= "1011";
                    
                    if clk = '1' then
                        State <= digitThree;
                    end if;
                when digitThree => 
                    thousandPos := (totalVal - interHundred) / 1000;
                    case thousandPos is
                        when 0 => segmentDisplay <= "1000000";
                        when 1 => segmentDisplay <= "1111001";
                        when 2 => segmentDisplay <= "0100100";
                        when 3 => segmentDisplay <= "0110000";
                        when 4 => segmentDisplay <= "0011001";
                        when 5 => segmentDisplay <= "0010010";
                        when 6 => segmentDisplay <= "0000010";
                        when 7 => segmentDisplay <= "1111000";
                        when 8 => segmentDisplay <= "0000000";
                        when 9 => segmentDisplay <= "0010000";
                        when others => segmentDisplay <= "0000000";
                    end case;
                        -- segmentDisplay <= interSeg;
                        dp <= '1'; 
                        an <= "0111";
                    if clk = '1' then
                        State <= digitZero;
                    end if;
             end case;
        end if;
    end process;
    
    
end Behavioral;
