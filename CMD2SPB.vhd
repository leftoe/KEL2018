----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:30:03 06/26/2017 
-- Design Name: 
-- Module Name:    CMD2SPB_0 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CMD2SPB is
	port(
		clk 		: 		in 		std_logic						;--66M
		reset 		: 		in 		std_logic						;--
		--serial inter face						
		SCK 		: 		out 	std_logic						;
		SD 			: 		out 	std_logic						;
		SL 			: 		out 	std_logic						;
		idle 		: 		out 	std_Logic						;
		cmd_trig 	: 		in 		std_Logic						;
		cmd_data 	: 		in 		std_logic_vector(63 downto 0)
		);
end CMD2SPB;

architecture Behavioral of CMD2SPB is
	signal scnt : std_logic_vector(15 downto 0);
	signal data : std_logic_vector(63 downto 0);

begin
	--idle
	process(reset,clk)
	begin
		if reset = '1' then
			idle <= '1';
		elsif rising_edge(clk) then
			if scnt = "1111111111111111" then
				idle <= '1';
			else
				idle <= '0';
			end if;
		end if;
	end process;
	--serial transfer 1
	process(reset,clk)
	begin
		if reset = '1' then
			scnt <= (others => '1');
			data <= (others => '0');
			SD  <= '0';
			SL  <= '0';
			SCK <= '0';
		elsif clk'event and clk = '1' then
			
			if cmd_trig = '1' then
				data <= cmd_data;
			end if;
			
			if cmd_trig = '1' then--and cmd_data(20 downto 18) = 0 then
				scnt <= (others => '0');
			elsif scnt >= x"4A00" then
				scnt <= "1111111111111111";
			else
				scnt <= scnt + 1;
			end if;
			---------------------------------
			if scnt(7 downto 0) = 0 then
				case scnt(15 downto 8) is
					when x"0A" => SD <= data(63);--Flag
					when x"0B" => SD <= data(62);
					when x"0C" => SD <= data(61);
					when x"0D" => SD <= data(60);
					when x"0E" => SD <= data(59);
					when x"0F" => SD <= data(58);
					when x"10" => SD <= data(57);
					when x"11" => SD <= data(56);
					when x"12" => SD <= data(55);--cmos num
					when x"13" => SD <= data(54);
					when x"14" => SD <= data(53);
					when x"15" => SD <= data(52);
					when x"16" => SD <= data(51);
					when x"17" => SD <= data(50);
					when x"18" => SD <= data(49);
					when x"19" => SD <= data(48);
					when x"1A" => SD <= data(47);--Gain
					when x"1B" => SD <= data(46);
					when x"1C" => SD <= data(45);
					when x"1D" => SD <= data(44);
					when x"1E" => SD <= data(43);
					when x"1F" => SD <= data(42);
					when x"20" => SD <= data(41);
					when x"21" => SD <= data(40);
					when x"22" => SD <= data(39);
					when x"23" => SD <= data(38);
					when x"24" => SD <= data(37);
					when x"25" => SD <= data(36);
					when x"26" => SD <= data(35);
					when x"27" => SD <= data(34);
					when x"28" => SD <= data(33);
					when x"29" => SD <= data(32);
					when x"2A" => SD <= data(31);--row start
					when x"2B" => SD <= data(30);
					when x"2C" => SD <= data(29);
					when x"2D" => SD <= data(28);
					when x"2E" => SD <= data(27);
					when x"2F" => SD <= data(26);
					when x"30" => SD <= data(25);
					when x"31" => SD <= data(24);
					when x"32" => SD <= data(23);
					when x"33" => SD <= data(22);
					when x"34" => SD <= data(21);
					when x"35" => SD <= data(20);
					when x"36" => SD <= data(19);
					when x"37" => SD <= data(18);
					when x"38" => SD <= data(17);
					when x"39" => SD <= data(16);
					when x"3A" => SD <= data(15);--colunm start
					when x"3B" => SD <= data(14);
					when x"3C" => SD <= data(13);
					when x"3D" => SD <= data(12);
					when x"3E" => SD <= data(11);
					when x"3F" => SD <= data(10);
					when x"40" => SD <= data(9);
					when x"41" => SD <= data(8);
					when x"42" => SD <= data(7);
					when x"43" => SD <= data(6);
					when x"44" => SD <= data(5);
					when x"45" => SD <= data(4);
					when x"46" => SD <= data(3);
					when x"47" => SD <= data(2);
					when x"48" => SD <= data(1);
					when x"49" => SD <= data(0);
					
					when others => SD <= '0';
					
				end case;
			end if;
			
			--SL
			if scnt(7 downto 0) = 0 then
				if scnt(15 downto 8) = x"0A" then
					SL <= '1';
				elsif scnt(15 downto 8) = x"4A" then
					SL <= '0';
				end if;
			end if;
			--SCK
			if scnt < x"0A00" or scnt >= x"4A00" then
				SCK <= '0';
			else
				SCK <= scnt(7);
			end if;
		end if;
	end process;

end Behavioral;

