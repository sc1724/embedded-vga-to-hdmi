----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2021 11:53:32 PM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           VS : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           hcount : in STD_LOGIC_VECTOR (9 downto 0);
           vid : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (4 downto 0);
           B : out STD_LOGIC_VECTOR (4 downto 0);
           G : out STD_LOGIC_VECTOR (5 downto 0);
           addr : out STD_LOGIC_VECTOR (17 downto 0));
end pixel_pusher;

architecture Behavioral of pixel_pusher is
signal addri:std_logic_vector(17 downto 0) := (others => '0');
begin
addr<=addri;
process(clk)
begin
if rising_edge(clk) then
    if VS = '0' then
    addri<=(others => '0');
    end if;
    if en = '1' then
    if (vid = '1' and unsigned(hcount) < 480) then
    addri <= std_logic_vector(unsigned(addri) + 1);
    R<=pixel(7 downto 5) & "00";
    G<=pixel(4 downto 2) & "000";
    B<=pixel(1 downto 0) & "000";
    else
    R<=(others => '0');
    G<=(others => '0');
    B<=(others => '0');
    end if;
    end if;
end if;
end process;

end Behavioral;
