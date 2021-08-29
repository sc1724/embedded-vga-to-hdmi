
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
    Port ( clk : in STD_LOGIC;
           vga_hs : out STD_LOGIC;
           vga_vs : out STD_LOGIC;
           vga_r : out STD_LOGIC_VECTOR (4 downto 0);
           vga_b : out STD_LOGIC_VECTOR (4 downto 0);
           vga_g : out STD_LOGIC_VECTOR (5 downto 0);
           vga_vid:out STD_LOGIC);
end image_top;

architecture Behavioral of image_top is
component clock_div port
(
clk: in std_logic;
div: out std_logic
);
end component;
component picture port
(
clka : IN STD_LOGIC;
addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
end component;
component pixel_pusher port
(
clk : in STD_LOGIC;
en : in STD_LOGIC;
VS : in STD_LOGIC;
pixel : in STD_LOGIC_VECTOR (7 downto 0);
hcount : in STD_LOGIC_VECTOR (9 downto 0);
vid : in STD_LOGIC;
R : out STD_LOGIC_VECTOR (4 downto 0);
B : out STD_LOGIC_VECTOR (4 downto 0);
G : out STD_LOGIC_VECTOR (5 downto 0);
addr : out STD_LOGIC_VECTOR (17 downto 0)
);
end component;
component vga_ctrl port
(
clk : in STD_LOGIC;
en : in STD_LOGIC;
hcount : out STD_LOGIC_VECTOR (9 downto 0);
vcount : out STD_LOGIC_VECTOR (9 downto 0);
vid : out STD_LOGIC;
hs : out STD_LOGIC;
vs : out STD_LOGIC
);
end component;

signal div, vidd, vss:std_logic;
signal addrr:std_logic_vector(17 downto 0);
signal pixell:std_logic_vector(7 downto 0);
signal hcountt,vcountt:std_logic_vector(9 downto 0);
begin
u1: clock_div port map(
clk=>clk,
div=>div
);
u2: picture port map(
clka=>div,
addra=>addrr,
douta=>pixell
);
u3: pixel_pusher port map(
clk=>clk,
en=>div,
VS=>vss,
pixel=>pixell,
hcount=>hcountt,
vid=>vidd,
R=>vga_r,
B=>vga_b,
G=>vga_g,
addr=>addrr
);
u4: vga_ctrl port map(
clk=>clk,
en=>div,
hcount=>hcountt,
vcount=>vcountt,
vid=>vidd,
hs=>vga_hs,
vs=>vss
);
vga_vs<=vss;
vga_vid<=vidd;
end Behavioral;
