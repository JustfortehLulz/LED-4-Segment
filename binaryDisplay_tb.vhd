----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2022 07:17:39 PM
-- Design Name: 
-- Module Name: binaryDisplay_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binaryDisplay_tb is
--  Port ( );
end binaryDisplay_tb;

architecture Behavioral of binaryDisplay_tb is
    -- Clock settings 
    constant clk_hz : integer := 100e6; -- 1 kHz clock
    constant clk_period : time := 1 sec/ clk_hz;
    
    -- DUT signals
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal SW : std_logic_vector(12 downto 0);
    signal segmentDisplay : std_logic_vector(6 downto 0);
    signal an : std_logic_vector(3 downto 0);
    signal dp : std_logic;
    
    -- TB signals
    
begin
    clk <= not clk after clk_period/2;
    
    DUT : entity work.binaryDisplay (Behavioral)
    port map (
        clk => clk,
        reset => reset,
        SW => SW,
        segmentDisplay => segmentDisplay,
        an => an,
        dp => dp);
        
    SEQUENCER_PROC: process
        variable test_segment : std_logic_vector(6 downto 0) := (others => '0');
    begin
        -- change reset to 0
        reset <= '1';
        
        wait for 10*clk_period;
        
        reset <= '0';

        SW <= (others => '0');
        
        -- test different SW positions starting with all 0 
        -- test for each of the 4 cycles
        wait for 100000*clk_period;
        
        test_segment := "1000000";
        -- assert the segmentDisplay, an, and dp values
        if segmentDisplay /= test_segment then
            report "segmentDisplay is not 1000000";
        end if;
        
        wait for 100000*clk_period;
        
        test_segment := "1000000";
        -- assert the segmentDisplay, an, and dp values
        if segmentDisplay /= test_segment then
            report "segmentDisplay is not 1000000";
        end if;
        
        wait for 100000*clk_period;
        
        test_segment := "1000000";
        -- assert the segmentDisplay, an, and dp values
        if segmentDisplay /= test_segment then
            report "segmentDisplay is not 1000000";
        end if;
        
        wait for 100000*clk_period;
        
        test_segment := "1000000";
        -- assert the segmentDisplay, an, and dp values
        if segmentDisplay /= test_segment then
            report "segmentDisplay is not 1000000";
        end if;
        
        
--        assert segmentDisplay = "1000000" 
--            report "Unexpected Value. SEGMENT DISPLAY is " & to_string(segmentDisplay) & " when it supposed to be 1111001";
--        assert an = "1110"
--            report "Unexpected Value. AN is " & to_string(an) & " when it supposed to be 1110";
--        assert dp = '1'
--            report "Unexpected Value. DP is " & to_string(dp) & " when it supposed to be 1
        
        wait for 100000*clk_period;
        
        -- test with SW = 1
        SW(12 downto 1) <= (others => '0');
        SW(0) <= '1';
        
        test_segment := "1111001";
        if segmentDisplay /= test_segment then
            report "Unexpected Value. SEGMENT DISPLAY is not 1111001";
        end if;
        
        wait for 100000*clk_period;
        
        test_segment := "1000000";
        -- assert the segmentDisplay, an, and dp values
        if segmentDisplay /= test_segment then
            report "segmentDisplay is not 1000000";
        end if;
        
        wait for 100000*clk_period;
        
        test_segment := "1000000";
        -- assert the segmentDisplay, an, and dp values
        if segmentDisplay /= test_segment then
            report "segmentDisplay is not 1000000";
        end if;
        
        wait for 100000*clk_period;
        
        test_segment := "1000000";
        -- assert the segmentDisplay, an, and dp values
        if segmentDisplay /= test_segment then
            report "segmentDisplay is not 1000000";
        end if;
        
        
        
        
--        if an /= "1110" then
--            report "Unexpected Value. AN is not 1110";
--        end if;  
        
--        if dp /= '1' then
--            report "Unexpected Value. DP is not 1";
--        end if;
        
--        assert segmentDisplay = "1111001" 
--            report "Unexpected Value. SEGMENT DISPLAY is " & to_string(segmentDisplay) & " when it supposed to be 1111001";
--        assert an = "1110"
--            report "Unexpected Value. AN is " & to_string(an) & " when it supposed to be 1110";
--        assert dp = '1'
--            report "Unexpected Value. DP is " & to_string(dp) & " when it supposed to be 1";
        
        wait for 100000*clk_period;
        
        -- test reset
        reset <= '1';
        report "SUCCESS";
        wait;
    end process;

end Behavioral;

