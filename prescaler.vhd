----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2022 08:44:42 PM
-- Design Name: 
-- Module Name: prescaler - Behavioral
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

entity prescaler is
Generic (
    fpga_clk : integer;
    light_clk : integer
    );
Port (
      clk_in : in std_logic;
      rst : in std_logic;
      clock_out : out std_logic
         );
end prescaler;

architecture Behavioral of prescaler is

begin
    process (clk_in, rst) is
        constant clk_context : integer := fpga_clk / light_clk;
        variable clk_counter : integer;
        variable temp_clk : std_logic;
    begin 
        if rst = '1' then
            clock_out <= '0';
            clk_counter := 0;
            temp_clk := '0';
        elsif (rising_edge(clk_in)) then
            if clk_counter = (clk_context / 2) - 1 then
                clk_counter := 0;
                temp_clk := not temp_clk;
                clock_out <= temp_clk;
            else 
                clk_counter := clk_counter + 1;
            end if;
        end if;
    end process;

end Behavioral;
