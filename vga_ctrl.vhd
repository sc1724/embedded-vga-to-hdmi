----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2021 11:46:29 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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

entity vga_ctrl is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           hcount : out STD_LOGIC_VECTOR (9 downto 0);
           vcount : out STD_LOGIC_VECTOR (9 downto 0);
           vid : out STD_LOGIC;
           hs : out STD_LOGIC;
           vs : out STD_LOGIC);
end vga_ctrl;

architecture Behavioral of vga_ctrl is
signal hcounti:std_logic_vector(9 downto 0):=(others=>'0');
signal vcounti:std_logic_vector(9 downto 0):=(others=>'0');
begin
hcount<=hcounti;
vcount<=vcounti;
process(clk, hcounti, vcounti)
begin

if rising_edge(clk) then
    if en = '1' then
    if unsigned(hcounti)>=798 then
    hcounti<=(others=>'0');
        if (unsigned(vcounti)>524)then
        vcounti<=(others=>'0');
        else
        vcounti<=std_logic_vector(unsigned(vcounti)+1);
        end if;  
    else
    hcounti<=std_logic_vector(unsigned(hcounti)+1);
    end if;
    end if;
end if;
    if unsigned(hcounti) < 640 and unsigned(vcounti)<480 then
    vid<='1';
    else
    vid<='0';
    end if;
    if unsigned(hcounti)>655 and unsigned(hcounti)<752 then
    hs<='0';
    else
    hs<='1';
    end if;
    if unsigned(vcounti)>489 and unsigned(vcounti)<492 then
    vs<='0';
    else
    vs<='1';
    end if;
end process;       

end Behavioral;
