library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
    Port ( clk : in STD_LOGIC;
           div : out STD_LOGIC);
end clock_div;

architecture Behavioral of clock_div is
    signal counter : STD_LOGIC_VECTOR(2 downto 0):=(others =>'0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if(unsigned(counter)=4)then
                div<='1';
                counter<=(others=>'0');
            else
                counter <= STD_LOGIC_VECTOR(unsigned(counter)+1);
                div<='0';
           end if;
        end if;
    end process;
end Behavioral;