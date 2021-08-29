----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2021 04:13:26 PM
-- Design Name: 
-- Module Name: image_top_top - Behavioral
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

entity image_top_top is
    Port ( clk : in STD_LOGIC;
           hdmi_tx_p : out STD_LOGIC_VECTOR (2 downto 0);
           hdmi_tx_n : out STD_LOGIC_VECTOR (2 downto 0);
           hdmi_tx_clk_p : out STD_LOGIC;
           hdmi_tx_clk_n : out STD_LOGIC;
           hdmi_out_en : out STD_LOGIC);
end image_top_top;

architecture Behavioral of image_top_top is
component rgb2dvi_0 port
(
TMDS_Clk_p : OUT STD_LOGIC;
TMDS_Clk_n : OUT STD_LOGIC;
TMDS_Data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
TMDS_Data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
aRst : IN STD_LOGIC;
vid_pData : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
vid_pVDE : IN STD_LOGIC;
vid_pHSync : IN STD_LOGIC;
vid_pVSync : IN STD_LOGIC;
PixelClk : IN STD_LOGIC;
SerialClk : IN STD_LOGIC
);
end component;
component image_top port
(
clk : in STD_LOGIC;
vga_hs : out STD_LOGIC;
vga_vs : inout STD_LOGIC;
vga_r : out STD_LOGIC_VECTOR (4 downto 0);
vga_b : out STD_LOGIC_VECTOR (4 downto 0);
vga_g : out STD_LOGIC_VECTOR (5 downto 0);
vga_vid: out STD_LOGIC
);
end component;
component clock_div port
(
clk: in std_logic;
div: out std_logic
);
end component;
signal hs,vs,div,vidd:std_logic;
signal r,b:std_logic_vector(4 downto 0);
signal g:std_logic_vector(5 downto 0);
signal rgb:std_logic_vector(23 downto 0);
begin
u3: clock_div port map(
clk=>clk,
div=>div
);
u1: image_top port map(
clk=>clk,
vga_hs=>hs,
vga_vs=>vs,
vga_r=>r,
vga_b=>b,
vga_g=>g,
vga_vid=>vidd
);
rgb<=r(4 downto 0)&"000" & g(5 downto 0)&"00" & b(4 downto 0)&"000";
hdmi_out_en<='1';
u2: rgb2dvi_0 port map(
TMDS_Clk_p=>hdmi_tx_clk_p,
TMDS_Clk_n=>hdmi_tx_clk_n,
TMDS_Data_p=>hdmi_tx_p,
TMDS_Data_n=>hdmi_tx_n,
aRst=>'0',
vid_pVDE=>vidd,
vid_pData=>rgb,
vid_pHsync=>hs,
vid_pVsync=>vs,
PixelClk=>div,
SerialClk=>clk
);

end Behavioral;
