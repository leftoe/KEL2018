----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:27 02/28/2018 
-- Design Name: 
-- Module Name:    clock_module - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity clock_module is
	port(
		clk				:	in		std_logic						;
		reset			:	out		std_logic						;
		clk66			:	out		std_logic						;
		PWRUP			:	out		std_logic_vector(7 downto 0)	;--Power Up for SPB
		led				:	out		std_logic_vector(2 downto 0)	
	);
end clock_module;

architecture Behavioral of clock_module is
	
	signal		CLK_BUF		:		std_logic						;
	signal		CK24		:		std_logic						;
	signal		CK66		:		std_logic						;
	signal		CK66_LOCKED	:		std_logic						;
	
	signal		reset_cnt	:		std_logic_vector( 7 downto 0)	;
	signal		pwrup_cnt	:		std_logic_vector(19 downto 0)	;
	signal		cnt			:		std_logic_vector(27 downto 0)	;
	signal		tmp			:		std_logic_vector( 2 downto 0)	;


	component DCM_24to66
	port
	 (
	  CLK_IN1   	 :		in     std_logic	;
	  CLK_OUT1  	 :		out    std_logic	;
	  LOCKED    	 :		out    std_logic
	 );
	end component;

	
begin

	Inst_24to66MHz : DCM_24to66
	  port map
	   (
		CLK_IN1 	=>		clk		,
		CLK_OUT1 	=>		CK66		,
		LOCKED 		=>		CK66_LOCKED	);

	clk66 <= CK66 when CK66_LOCKED = '1' else '0';	

	--================
	--		reset
	--================
	process(CK66)
	begin
		if rising_edge(CK66) then
			if reset_cnt = x"ff" then
				reset <= '0';
			else
				reset <= '1';
			end if;
			if reset_cnt < x"ff" then
				reset_cnt <= reset_cnt + 1;
			end if;
		end if;
	end process;
	--==================
	--		PWRUP 
	--==================
	process(CK66)
	begin
		if rising_edge(CK66) then
			if pwrup_cnt < x"FFFFF" then
				pwrup_cnt <= pwrup_cnt + 1;
			end if;
			
			case pwrup_cnt(19 downto 16) is
				when x"0" => PWRUP <= "00000000";
				when x"1" => PWRUP <= "00000001";
				when x"2" => PWRUP <= "00000011";
				when x"3" => PWRUP <= "00000111";
				when x"4" => PWRUP <= "00001111";
				when x"5" => PWRUP <= "00011111";
				when x"6" => PWRUP <= "00111111";
				when x"7" => PWRUP <= "01111111";
				when x"8" => PWRUP <= "11111111";
				when others => NULL;
			end case;
			
		end if;
	end process;
	--================
	--		LED
	--================
	process(CK66)
	begin
		if rising_edge(CK66) then
			if cnt = 66000000 then
				cnt <= (others => '0');
				tmp <= tmp + 1;
			else
				cnt <= cnt + 1;
			end if;
			led <= tmp;
		end if;
	end process;
	
end Behavioral;

