----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2022 09:41:09 AM
-- Design Name: 
-- Module Name: prescaler_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prescaler_tb is
--  Port ( );
end prescaler_tb;

architecture Behavioral of prescaler_tb is
    constant FPGA_CLK : integer := 100e6;
    constant LIGHT_CLK : integer := 1e3;
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal clk_out : std_logic := '0';
begin

    DUT : entity work.prescaler(Behavioral)
    generic map(
        fpga_clk => FPGA_CLK, 
        light_clk => LIGHT_CLK
    )
    port map(
        clk_in => clk,
        rst => rst,
        clock_out => clk_out
    );
    
    clk <= not clk after (1 sec / FPGA_CLK) /2;
    
    -- take DUT out of reset 
    process is
    begin
        rst <= '0';
    
        report "FINISHED";
        wait;
    
    end process;

end Behavioral;
