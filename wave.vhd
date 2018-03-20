----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:10:02 06/27/2017 
-- Design Name: 
-- Module Name:    wave_0 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: "--new":增加纵向波形
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

entity wave is
	port(
		ft_clk 			: 		in		std_logic						;
		reset 			: 		in		std_logic						;
		--		
		sn_lock_n 		: 		in 		std_logic						;--low active
		sn_rclk 		: 		in 		std_logic						;
		sn_data 		: 		in 		std_logic_vector( 9 downto 0)	;
				
		wave_cur_trig 	: 		in 		std_Logic						;--pulse base on ft_clk
		wave_nxt_trig 	: 		out		std_Logic						;--pulse base on ft_clk
		zwave_dval		: 		out 	std_logic						;
		zwave_data 		: 		out 	std_logic_vector(15 downto 0)
		);
end wave;

architecture Behavioral of wave is
	--BRAM_A		
	signal		wea_0 			: 		std_logic_vector( 0 downto 0)		;
	signal		addra_0 		: 		std_logic_vector(10 downto 0)		;
	signal		dina_0 			: 		std_logic_vector(15 downto 0)		;
	signal		addrb_0 		: 		std_logic_vector(10 downto 0)		;
	signal		doutb_0 		: 		std_logic_vector(15 downto 0)		;
	--BRAM_B					
	signal		wea_1 			: 		std_logic_vector( 0 downto 0)		;
	signal		addra_1 		: 		std_logic_vector(10 downto 0)		;
	signal		dina_1 			: 		std_logic_vector(15 downto 0)		;
	signal		addrb_1 		: 		std_logic_vector(10 downto 0)		;
	signal		doutb_1 		: 		std_logic_vector(15 downto 0)		;
	
	signal		addra_cnt		:		std_logic_vector(12 downto 0)		;
	signal		addrb_cnt		:		std_logic_vector(10 downto 0)		;
	
	--wave
	signal		wave_fval		:		std_logic							;--0:valid
	signal		wave_dval		:		std_logic							;
	signal		wave_data		:		std_logic_vector( 7 downto 0)		;
	
	signal		splise_data 	: 		std_logic_vector(15 downto 0)		;--用于拼接
	signal		wave_dval_cnt 	: 		std_logic_vector(12 downto 0)		;
	signal		wave_dval0		 :		std_logic							;
	
	
	COMPONENT BRAM_WAVE
	  PORT (
		 clka 	:	IN		STD_LOGIC						;
		 wea 	:	IN		STD_LOGIC_VECTOR( 0 DOWNTO 0)	;
		 addra 	:	IN		STD_LOGIC_VECTOR(10 DOWNTO 0)	;
		 dina 	:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0)	;
		 clkb 	:	IN		STD_LOGIC						;
		 addrb 	:	IN		STD_LOGIC_VECTOR(10 DOWNTO 0)	;
		 doutb 	:	OUT 	STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;

begin

	A_wave : BRAM_WAVE
	  PORT MAP (
		 clka 		=>		sn_rclk		,	
		 wea 		=>		wea_0		,
		 addra 		=>		addra_0		,
		 dina 		=>		dina_0		,
		 clkb 		=>		ft_clk		,
		 addrb 		=>		addrb_0		,
		 doutb 		=>		doutb_0
	  );

	B_wave : BRAM_WAVE
	  PORT MAP (
		 clka 		=>		sn_rclk		,
		 wea 		=>		wea_1		,
		 addra 		=>		addra_1		,
		 dina 		=>		dina_1		,
		 clkb 		=>		ft_clk		,
		 addrb 		=>		addrb_1		,
		 doutb 		=>		doutb_1
	  );

	--===================================
	--		Receive	Wave Data
	--===================================
	process(reset,sn_lock_n,sn_rclk)
	begin
		if reset = '1' or sn_lock_n = '1' then
			wave_fval <= '0';
			wave_dval <= '0';
			wave_data <= (others => '0');
		elsif falling_edge(sn_rclk) then
			wave_fval <= not sn_data(9);
			wave_dval <= sn_data(8) and (not sn_data(9));
			wave_data <= sn_data(7 downto 0);
			
		end if;
	end process;
	
	--wave_dval_cnt
	process(reset,sn_rclk)
	begin
		if reset = '1' then
			wave_dval_cnt <= (others => '0');
		elsif falling_edge(sn_rclk) then
			if wave_dval = '1' then
				if wave_dval_cnt = 3815 then--new	3095
					wave_dval_cnt <= (others => '0');
				else
					wave_dval_cnt <= wave_dval_cnt + 1;
				end if;
			end if;
		
		end if;
	end process;
	--addra_cnt
	process(reset,sn_rclk)
	begin
		if reset = '1' then
			addra_cnt <= (others => '0');
			wave_dval0 <= '0';
		elsif falling_edge(sn_rclk) then
			
			wave_dval0 <= wave_dval;
			
			if wave_dval0 = '1' then
				if addra_cnt(11 downto 0) = 3815 then--new	3095
					addra_cnt(11 downto 0) <= (others => '0');
					addra_cnt(12) <= not addra_cnt(12);
				else
					addra_cnt(11 downto 0) <= addra_cnt(11 downto 0) + 1;
				end if;
			else
				addra_cnt(11 downto 0) <= (others => '0');
			end if;
		end if;
	end process;
	--splise_data
	process(reset,sn_rclk)
	begin
		if reset = '1' then
			splise_data <= (others => '0');
		elsif falling_edge(sn_rclk) then
			if wave_dval = '1' then
				if wave_dval_cnt(0) = '0' then
					splise_data( 7 downto 0) <= wave_data;
				else
					splise_data(15 downto 8) <= wave_data;
				end if;
			end if;
		end if;
	end process;
	--============================
	--		Bram	Input
	--============================
	process(reset,sn_rclk)
	begin
		if reset = '1' then
			addra_0	<= (others => '0')	;
			addra_1	<= (others => '0')	;
			dina_0	<= (others => '0')	;
			dina_1	<= (others => '0')	;
			wea_0	<= "0"				;
			wea_1	<= "0"				;
		elsif falling_edge(sn_rclk) then
			if wave_fval = '1' then
				if addra_cnt(12) = '0' then
					if wave_dval0 = '1' and addra_cnt(0) = '1' then
						addra_0 <= addra_cnt(11 downto 1);
						dina_0	<= splise_data;
						wea_0	<= "1";
						wea_1	<= "0";
					else
						addra_0 <= (others => '0');
						dina_0	<= (others => '0');
						wea_0	<= "0";
						wea_1	<= "0";
					end if;
				else
					if wave_dval0 = '1' and addra_cnt(0) = '1' then
						addra_1 <= addra_cnt(11 downto 1);
						dina_1	<= splise_data;
						wea_1	<= "1";
						wea_0	<= "0";
					else
						addra_1 <= (others => '0');
						dina_1	<= (others => '0');
						wea_1	<= "0";
						wea_0	<= "0";
					end if;
				end if;
			else
				addra_0	<= (others => '0')	;
				addra_1	<= (others => '0')	;
				dina_0	<= (others => '0')	;
				dina_1	<= (others => '0')	;
				wea_0	<= "0"				;
				wea_1	<= "0"				;
			end if;
		end if;
	end process;
	--===============================
	--		Bram	Output
	--===============================
	process(reset,ft_clk)
	begin
		if reset = '1' then
			addrb_cnt <= (others => '0');
		elsif rising_edge(ft_clk) then
			if wave_cur_trig = '1' or addrb_cnt /= 0 then
				if addrb_cnt = 1909 then--new	1549
					addrb_cnt <= (others => '0');
				else
					addrb_cnt <= addrb_cnt + 1;
				end if;
			end if;
		end if;
	end process;
	--addrb_0 addrb_1
	process(reset,ft_clk)
	begin
		if reset = '1' then
			addrb_0 <= (others => '0');
			addrb_1 <= (others => '0');
			zwave_data <= (others => '0');
			zwave_dval <= '0';
			wave_nxt_trig <= '0';
		elsif rising_edge(ft_clk) then
		
			addrb_0 <= addrb_cnt;
			addrb_1 <= addrb_cnt;
			--zwave_dval	
			if addrb_cnt = 2 then
				zwave_dval <= '1';
			elsif addrb_cnt = 0 then
				zwave_dval <= '0';
			end if;
			--zwave_data
			if addra_cnt(12) = '1' then
				zwave_data <= doutb_0;
			else
				zwave_data <= doutb_1;
			end if;
			--wave_nxt_trig
			if addrb_cnt = 1907 then--new	1547
				wave_nxt_trig <= '1';
			else
				wave_nxt_trig <= '0';
			end if;
			
		end if;
	end process;
	
end Behavioral;

