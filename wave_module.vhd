----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:35:01 08/25/2017 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity wave_module is
	port(
		--FT600_1
		reset 		:	in 		std_logic						;
		ft_clk 		:	in 		std_logic						;
		ft_txe_n 	:	in 		std_logic						;
		ft_wr_n 	:	out 	std_logic						;
		ft_data 	:	out 	std_logic_vector(15 downto 0)	;
		
		--SN65LV1224	
		sn0_lock	:	in		std_logic						;--low active
		sn0_rclk	:	in		std_logic						;
		sn0_data	:	in		std_logic_vector(9 downto 0)	;
		sn1_lock	:	in		std_logic						;--low active
		sn1_rclk	:	in		std_logic						;
		sn1_data	:	in		std_logic_vector(9 downto 0)	;
		sn2_lock	:	in		std_logic						;--low active
		sn2_rclk	:	in		std_logic						;
		sn2_data	:	in		std_logic_vector(9 downto 0)	;
		sn3_lock	:	in		std_logic						;--low active
		sn3_rclk	:	in		std_logic						;
		sn3_data	:	in		std_logic_vector(9 downto 0)	;
		sn4_lock	:	in		std_logic						;--low active
		sn4_rclk	:	in		std_logic						;
		sn4_data	:	in		std_logic_vector(9 downto 0)	;
		sn5_lock	:	in		std_logic						;--low active
		sn5_rclk	:	in		std_logic						;
		sn5_data	:	in		std_logic_vector(9 downto 0)	;
		sn6_lock	:	in		std_logic						;--low active
		sn6_rclk	:	in		std_logic						;
		sn6_data	:	in		std_logic_vector(9 downto 0)	;
		sn7_lock	:	in		std_logic						;--low active
		sn7_rclk	:	in		std_logic						;
		sn7_data	:	in		std_logic_vector(9 downto 0)
	);
end wave_module;

architecture Behavioral of wave_module is
	
	signal		ft_txe_n0			:			std_logic						;
	--BRAM
	signal		wea 				:			STD_LOGIC_VECTOR( 0 DOWNTO 0)	;
    signal		addra 				:			STD_LOGIC_VECTOR(14 DOWNTO 0)	;
	signal		dina 				:			STD_LOGIC_VECTOR(15 DOWNTO 0)	;
	signal		addrb 				:			STD_LOGIC_VECTOR(14 DOWNTO 0)	;
	signal		doutb 				:			STD_LOGIC_VECTOR(15 DOWNTO 0)	;
		
	signal		addra_cnt 			:			STD_LOGIC_VECTOR(14 DOWNTO 0)	;
	signal		addrb_cnt 			:			STD_LOGIC_VECTOR(14 DOWNTO 0)	;
	
	signal		wave_dval 			:			std_logic						;
	signal		wave_data 			:			std_logic_vector(15 downto 0)	;
	signal		wave_dval_delay		:			std_logic_vector( 1 downto 0)	;
	
	signal		wave_trig 			:			std_logic						; 
	signal		sn0_fval_delay 		:			std_logic_vector( 2 downto 0)	; 
	
	signal		 wave0_cur_trig 	:			std_logic						; 
	signal		 wave0_nxt_trig 	:			std_logic						; 
	signal		zwave0_dval 		:			std_logic						;
	signal		zwave0_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		 wave1_cur_trig 	:			std_logic						; 
	signal		 wave1_nxt_trig 	:			std_logic						; 
	signal		zwave1_dval 		:			std_logic						;
	signal		zwave1_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		 wave2_cur_trig 	:			std_logic						; 
	signal		 wave2_nxt_trig 	:			std_logic						; 
	signal		zwave2_dval 		:			std_logic						;
	signal		zwave2_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		 wave3_cur_trig 	:			std_logic						; 
	signal		 wave3_nxt_trig 	:			std_logic						; 
	signal		zwave3_dval 		:			std_logic						;
	signal		zwave3_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		 wave4_cur_trig 	:			std_logic						; 
	signal		 wave4_nxt_trig 	:			std_logic						; 
	signal		zwave4_dval 		:			std_logic						;
	signal		zwave4_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		 wave5_cur_trig 	:			std_logic						; 
	signal		 wave5_nxt_trig 	:			std_logic						; 
	signal		zwave5_dval 		:			std_logic						;
	signal		zwave5_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		 wave6_cur_trig 	:			std_logic						; 
	signal		 wave6_nxt_trig 	:			std_logic						; 
	signal		zwave6_dval 		:			std_logic						;
	signal		zwave6_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		 wave7_cur_trig 	:			std_logic						; 
	signal		 wave7_nxt_trig 	:			std_logic						; 
	signal		zwave7_dval 		:			std_logic						;
	signal		zwave7_data 		:			std_logic_vector(15 downto 0)	;
	
	
	
	COMPONENT wave
	PORT(
		ft_clk 			:		IN		std_logic						;
		reset 			:		IN		std_logic						;
		sn_lock_n 		:		IN		std_logic						;
		sn_rclk 		:		IN		std_logic						;
		sn_data 		:		IN		std_logic_vector(9 downto 0)	;
		wave_cur_trig 	:		IN		std_logic						;          
		wave_nxt_trig 	:		OUT 	std_logic						;
		zwave_dval 		:		OUT 	std_logic						;
		zwave_data 		:		OUT 	std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT BRAM_8x16x1548
	  PORT (
		clka 		:		IN			STD_LOGIC						;
		wea 		:		IN			STD_LOGIC_VECTOR(0 DOWNTO 0)	;
		addra 		:		IN			STD_LOGIC_VECTOR(14 DOWNTO 0)	;
		dina 		:		IN			STD_LOGIC_VECTOR(15 DOWNTO 0)	;
		clkb 		:		IN			STD_LOGIC						;
		addrb 		:		IN			STD_LOGIC_VECTOR(14 DOWNTO 0)	;
		doutb 		:		OUT 		STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;



begin

	your_instance_name : BRAM_8x16x1548
	  PORT MAP (
		clka 	=> 		ft_clk		,
		wea 	=> 		wea			,
		addra 	=> 		addra		,
		dina 	=> 		dina		,	
		clkb 	=> 		ft_clk		,
		addrb 	=> 		addrb		,
		doutb 	=> 		doutb
	  );


	Inst0_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn0_lock		,--Z
		sn_rclk 		=> 		sn0_rclk		,--Z
		sn_data 		=> 		sn0_data		,--Z
		wave_cur_trig 	=> 		wave0_cur_trig	,	
		wave_nxt_trig 	=> 		wave0_nxt_trig	,	
		zwave_dval 		=> 		zwave0_dval 	,		
		zwave_data 		=>      zwave0_data 	
	);

	Inst1_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn1_lock		,--Z
		sn_rclk 		=> 		sn1_rclk		,--Z
		sn_data 		=> 		sn1_data		,--Z
		wave_cur_trig 	=> 		wave0_nxt_trig	,	
		wave_nxt_trig 	=> 		wave1_nxt_trig	,	
		zwave_dval 		=> 		zwave1_dval 	,		
		zwave_data 		=>      zwave1_data 	
	);

	Inst2_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn2_lock		,--Z
		sn_rclk 		=> 		sn2_rclk		,--Z
		sn_data 		=> 		sn2_data		,--Z
		wave_cur_trig 	=> 		wave1_nxt_trig	,	
		wave_nxt_trig 	=> 		wave2_nxt_trig	,	
		zwave_dval 		=> 		zwave2_dval 	,		
		zwave_data 		=>      zwave2_data 	
	);

	Inst3_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn3_lock		,--Z
		sn_rclk 		=> 		sn3_rclk		,--Z
		sn_data 		=> 		sn3_data		,--Z
		wave_cur_trig 	=> 		wave2_nxt_trig 	,	
		wave_nxt_trig 	=> 		wave3_nxt_trig 	,	
		zwave_dval 		=> 		zwave3_dval 	,		
		zwave_data 		=>      zwave3_data 	
	);

	Inst4_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn4_lock		,--Z
		sn_rclk 		=> 		sn4_rclk		,--Z
		sn_data 		=> 		sn4_data		,--Z
		wave_cur_trig 	=> 		wave3_nxt_trig	,	
		wave_nxt_trig 	=> 		wave4_nxt_trig	,	
		zwave_dval 		=> 		zwave4_dval 	,		
		zwave_data 		=>      zwave4_data 	
	);

	Inst5_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn5_lock		,--Z
		sn_rclk 		=> 		sn5_rclk		,--Z
		sn_data 		=> 		sn5_data		,--Z
		wave_cur_trig 	=> 		wave4_nxt_trig	,	
		wave_nxt_trig 	=> 		wave5_nxt_trig	,	
		zwave_dval 		=> 		zwave5_dval 	,		
		zwave_data 		=>      zwave5_data 	
	);

	Inst6_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn6_lock		,--Z
		sn_rclk 		=> 		sn6_rclk		,--Z
		sn_data 		=> 		sn6_data		,--Z
		wave_cur_trig 	=> 		wave5_nxt_trig	,	
		wave_nxt_trig 	=> 		wave6_nxt_trig	,	
		zwave_dval 		=> 		zwave6_dval 	,		
		zwave_data 		=>      zwave6_data 	
	);

	Inst7_wave: wave PORT MAP(
		ft_clk 			=> 		ft_clk		    ,--Z
		reset 			=> 		reset		    ,--Z
		sn_lock_n 		=> 		sn7_lock		,--Z
		sn_rclk 		=> 		sn7_rclk		,--Z
		sn_data 		=> 		sn7_data		,--Z
		wave_cur_trig 	=> 		wave6_nxt_trig	,	
		wave_nxt_trig 	=> 		wave7_nxt_trig	,	
		zwave_dval 		=> 		zwave7_dval 	,		
		zwave_data 		=>      zwave7_data 	
	);
	
	--============================
	--		wave_trig
	--============================
	--across clock
	process(reset,ft_clk)
	begin
		if reset = '1' then
			sn0_fval_delay <= "000";
		elsif rising_edge(ft_clk) then
			sn0_fval_delay <= sn0_fval_delay(1 downto 0) & sn0_data(9);
			
		end if;
	end process;
	--
	process(reset,ft_clk)
	begin
		if reset = '1' then
			wave_trig <= '0';
		elsif rising_edge(ft_clk) then
			if sn0_fval_delay = "100" then
				wave_trig <= '1';
			else
				wave_trig <= '0';
			end if;
			wave0_cur_trig <= wave_trig;
		end if;
	end process;
	
	--=========================
	--		BRAM	Input
	--=========================
	-- process(reset,ft_clk)
	-- begin
		-- if reset = '1' then
			-- addra_cnt 	<= (others => '0');
		-- elsif rising_edge(ft_clk) then
			-- if zwave0_dval = '1' or 
			   -- zwave1_dval = '1' or 
			   -- zwave2_dval = '1' or 
			   -- zwave3_dval = '1' or 
			   -- zwave4_dval = '1' or 
			   -- zwave5_dval = '1' or 
			   -- zwave6_dval = '1' or 
			   -- zwave7_dval = '1' then
				
				-- addra_cnt 	<= addra_cnt + 1;
			-- else
				-- addra_cnt 	<= (others => '0');
			-- end if;
		-- end if;
	-- end process;
	process(reset,ft_clk)
	begin
		if reset = '1' then
			addra_cnt 	<= (others => '0');
		elsif rising_edge(ft_clk) then
			if addra_cnt = 15264 then--30528
				addra_cnt 	<= (others => '0');
			elsif zwave0_dval = '1' or addra_cnt /= 0 then
				addra_cnt 	<= addra_cnt + 1;
			end if;
		end if;
	end process;
	
	
	--=========================
	--		Bram	 Input
	--=========================
	process(reset,ft_clk)
	begin
		if reset = '1' then
			addra <= (others => '0');
			dina  <= (others => '0');
			wea	  <= (others => '0');
		elsif rising_edge(ft_clk) then
			if zwave0_dval = '1' then
				dina  <= zwave0_data;
				addra <= addra_cnt;
				wea	  <= "1";
			elsif zwave1_dval = '1' then
				dina  <= zwave1_data;
				addra <= addra_cnt;
				wea	  <= "1";
			elsif zwave2_dval = '1' then
				dina  <= zwave2_data;	
				addra <= addra_cnt;				
				wea	  <= "1";
			elsif zwave3_dval = '1' then
				dina  <= zwave3_data;
				addra <= addra_cnt;
				wea	  <= "1";
			elsif zwave4_dval = '1' then
				dina  <= zwave4_data;
				addra <= addra_cnt;
				wea	  <= "1";
			elsif zwave5_dval = '1' then
				dina  <= zwave5_data;
				addra <= addra_cnt;
				wea	  <= "1";
			elsif zwave6_dval = '1' then
				dina  <= zwave6_data;
				addra <= addra_cnt;
				wea	  <= "1";
			elsif zwave7_dval = '1' then
				dina  <= zwave7_data;
				addra <= addra_cnt;
				wea	  <= "1";
			else
				addra <= (others => '0');
				dina  <= (others => '0');
				wea	  <= (others => '0');
			end if;
			
		end if;
	end process;
	
	--===========================
	--		Bram	Ouput
	--===========================
	process(reset,ft_clk)
	begin
		if reset = '1' then
			ft_txe_n0 <= '0';
			addrb_cnt <= (others => '0');
			addrb 	  <= (others => '0');
		elsif rising_edge(ft_clk) then
			ft_txe_n0 <= ft_txe_n;
			
			if (addrb_cnt /= 0      and 
				addrb_cnt /= 2048   and 
				addrb_cnt /= 4096   and 
				addrb_cnt /= 6144   and 
				addrb_cnt /= 8192   and 
				addrb_cnt /= 10240  and 
				addrb_cnt /= 12288  and 
				addrb_cnt /= 14336) or
				(addra_cnt = 15264 and ft_txe_n = '0') or--new
				(addrb_cnt /= 0 and ft_txe_n0 = '1' and ft_txe_n = '0')
				then
					if addrb_cnt = 15263 then
				    	addrb_cnt <= (others => '0');
				    else
				    	addrb_cnt <= addrb_cnt + 1;
				    end if;
			end if;
			
			addrb <= addrb_cnt;
			
		end if;
	end process;
	

	--
	process(reset,ft_clk)
	begin
		if reset = '1' then
			wave_data <= (others => '0');
			wave_dval <= '0';
		elsif rising_edge(ft_clk) then
			wave_data <= doutb;
			if addrb_cnt = 1 then
				wave_dval <= '1';
			elsif addrb_cnt = 0 and ft_txe_n = '1' then
				wave_dval <= '0';
			end if;
		end if;
	end process;
	--===========================
	--		USB	Output
	--===========================
	process(reset,ft_clk)
	begin
		if reset = '1' then
			ft_wr_n <= '1';
			ft_data <= (others => 'Z');
		elsif rising_edge(ft_clk) then
			--ft_wr_n
			if  addrb_cnt = 3		or
				addrb_cnt = 2051 	or
				addrb_cnt = 4099 	or
				addrb_cnt = 6147 	or
				addrb_cnt = 8195 	or
				addrb_cnt = 10243 	or
				addrb_cnt = 12291 	or---|--new
				addrb_cnt = 14339	
				then
				
				ft_wr_n <= '0';
			elsif ft_txe_n = '1' then
				ft_wr_n <= '1';
			end if;
			
			if wave_dval = '1' then
				ft_data <= wave_data;
			else
				ft_data <= (others => 'Z');
			end if;
			
		end if;
	end process;
	
end Behavioral;

