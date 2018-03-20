----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:13 02/28/2018 
-- Design Name: 
-- Module Name:    sn_module - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: first transfer Image Only
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

entity sn_module is
	port(
		clk66			:		in		std_logic						;
		snLOCK_N 		: 		in		std_logic						;--low active
		snRCLK 			: 		in		std_logic						;
		snREFCLK 		: 		out 	std_logic						;
		snDATA 			: 		in 		std_logic_vector(9 downto 0)	;
				
		EN			:		in 		std_logic						;
		reset			:		in 		std_logic						;
		ft_clk			:		in 		std_logic						;
		ft_txe_n		:		in		std_logic						;
		--usb_module						
		usb_busy		:		in		std_logic						;
		usb_wr_en		:		in		std_logic						;
		usb_wr_req		:		out		std_logic						;
		bram_fval		:		out		std_logic						;
		bram_dval		:		out		std_logic						;
		bram_data		:		out		std_logic_vector(15 downto 0)	
		
	);
end sn_module;

architecture Behavioral of sn_module is


	
	signal		img_fval00			:		std_logic							;
	signal		img_fval0			:		std_logic							;
	signal		img_dval0			:		std_logic							;
	signal		img_fval0_delay		:		std_logic_vector( 2 downto 0)		;
	signal		img_dval0_delay		:		std_logic_vector( 2 downto 0)		;
	signal		img_fval_delay		:		std_logic_vector( 1 downto 0)		;
	signal		img_row_cnt			:		std_logic_vector( 9 downto 0)		;--base on ft_clk
	signal		final_trig			:		std_logic							;
	
	signal		ft_txe_delay		:		std_logic_vector( 2 downto 0)		;
	--bram				
	signal		wea_0				:		std_logic_vector( 0 downto 0)		;
	signal		addra_0				:		std_logic_vector(11 downto 0)		;
	signal		dina_0 				:		std_logic_vector(15 downto 0)		;
	signal		addrb_0 			:		std_logic_vector(11 downto 0)		;
	signal		doutb_0 			:		std_logic_vector(15 downto 0)		;
	signal		wea_1				:		std_logic_vector( 0 downto 0)		;
	signal		addra_1				:		std_logic_vector(11 downto 0)		;
	signal		dina_1 				:		std_logic_vector(15 downto 0)		;
	signal		addrb_1 			:		std_logic_vector(11 downto 0)		;
	signal		doutb_1 			:		std_logic_vector(15 downto 0)		;
	
	signal		splice_data			:		std_logic_vector(15 downto 0)		;
		
	signal		addra_cnt			:		std_logic_vector(13 downto 0)		;--MSB:full flag	LSB:splice pixel
	signal		addrb_cnt			:		std_logic_vector(11 downto 0)		;
	signal		img_dval_cnt		:		std_logic_vector(13 downto 0)		;
	signal		img_dval_delay		:		std_logic_vector( 3 downto 0)		;
		
	signal		bram_dval0			:		std_logic							;
	signal		bram_rd_switch		:		std_logic							;--'0':read bram0; '1':read bram1
	signal		usb_wr_req_delay	:		std_logic_vector( 2 downto 0)		;
	signal		usb_wr_req0			:		std_logic							;
	signal		usb_wr_req1			:		std_logic							;
	signal		img_trans_en		:		std_logic							;
	signal		bram_finish_num		:		std_logic							;
	signal		bram_dval_cnt		:		std_logic_vector( 7 downto 0)		;
	
	signal 		img_fval			:		std_logic							;
	signal 		img_fval_cnt		:		std_logic_vector( 7 downto 0)		;
    signal 		img_dval			:		std_logic							;
    signal 		img_data			:		std_logic_vector( 7 downto 0)		;

	--test
	signal		usb_req_cnt			:		std_logic_vector( 9 downto 0)		;
	signal		tmp_flag0			:		std_logic							;
	signal		tmp_flag1			:		std_logic							;
	
	COMPONENT BRAM_16x4096
	  PORT (
		clka 	: IN 	STD_LOGIC							;
		wea 	: IN 	STD_LOGIC_VECTOR(0 DOWNTO 0)		;
		addra 	: IN 	STD_LOGIC_VECTOR(11 DOWNTO 0)		;
		dina 	: IN 	STD_LOGIC_VECTOR(15 DOWNTO 0)		;
		clkb 	: IN 	STD_LOGIC							;
		addrb 	: IN 	STD_LOGIC_VECTOR(11 DOWNTO 0)		;
		doutb 	: OUT 	STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;
	

begin

	Inst_BRAM_A : BRAM_16x4096
	  PORT MAP (
		clka 		=> 		snRCLK			,
		wea 		=> 		wea_0			,
		addra 		=> 		addra_0			,
		dina 		=> 		dina_0			,
		clkb 		=> 		ft_clk			,
		addrb 		=> 		addrb_0			,
		doutb 		=> 		doutb_0
	  );
	Inst_BRAM_B : BRAM_16x4096
	  PORT MAP (
		clka 		=> 		snRCLK			,
		wea 		=> 		wea_1			,
		addra 		=> 		addra_1			,
		dina 		=> 		dina_1			,
		clkb 		=> 		ft_clk			,
		addrb 		=> 		addrb_1			,
		doutb 		=> 		doutb_1
	  );
	--=============================
	--		SN Clock Output
	--=============================
	-- snREFCLK <= clk66;
	A0 : ODDR2
	generic map(
		DDR_ALIGNMENT => "NONE",
		INIT => '0',
		SRTYPE => "SYNC")
	port map (
		Q => snREFCLK,		--1-bit output data
		C0 => clk66,		--1-bit clock input
		C1 => not clk66,	--1-bit clock input
		CE => '1',		--1-bit clock enable input
		D0 => '1',		--1-bit data input(associated with c0)
		D1 => '0',		--1-bit data input(associated with c1)
		R => '0',		--1-bit reset input
		S => '0'			--1-bit set input
		);

	--*************************************************************
	process(reset,EN,snLOCK_N,snRCLK)
	begin
		if reset = '1' or snLOCK_N = '1' or EN = '0' then
			img_fval <= '0';
			img_dval <= '0';
			img_data <= (others => '0');
		elsif falling_edge(snRCLK) then
				-- img_fval <= snDATA(9);
				-- img_dval <= snDATA(8) and snDATA(9);
				-- img_data <= snDATA(7 downto 0);
				
				if snDATA(9) = '1' then
					img_fval <= '1';
					img_dval <= snDATA(8);
					img_data <= snDATA(7 downto 0);
				else
					img_fval <= '0';
					img_dval <= '0';
					img_data <= (others => '0');
				end if;
				
		end if;
	end process;
	
	
	--img_trans_en:img start
	process(reset,EN,snRCLK)
	begin
		if reset = '1' or EN = '0' then
			img_trans_en <= '0';
			img_fval_delay <= "00";
		elsif falling_edge(snRCLK) then
			img_fval_delay <= img_fval_delay(0) & img_fval;
			ft_txe_delay <= ft_txe_delay(1 downto 0) & ft_txe_n;
			if img_fval_delay = "01" then
			-- if img_fval_cnt = x"fe" then
				if ft_txe_delay = "000" then--across clock
					img_trans_en <= '1';
				else
					img_trans_en <= '0';
				end if;
			elsif img_fval = '0' then--img_fval = '0'
				img_trans_en <= '0';
			end if;
			
			--img_fval_cnt
			if img_fval = '1' then
				if img_fval_cnt < x"FF" then
					img_fval_cnt <= img_fval_cnt + 1;
				end if;
			else
				img_fval_cnt <= (others => '0');
			end if;
			
		end if;
	end process;
	img_fval0 <= img_fval and img_trans_en;
	img_dval0 <= img_dval and img_trans_en;
	--img_dval_cnt		
	process(reset,EN,snRCLK)
	begin
		if reset = '1' or EN = '0' then
			img_dval_cnt <= (others => '0');
		elsif falling_edge(snRCLK) then
			if img_fval0 = '1' then
				if img_dval0 = '1' then
					img_dval_cnt <= img_dval_cnt + 1;
				else
					img_dval_cnt <= (others => '0');
				end if;
			else
				img_dval_cnt <= (others => '0');				
			end if;
			
			
		end if;
	end process;
	--splice_data
	process(reset,EN,snRCLK)
	begin
		if reset = '1' or EN = '0' then
			splice_data <= (others => '0');
		elsif falling_edge(snRCLK) then
			if img_dval0 = '1' then
				if img_dval_cnt(0) = '0' then
					splice_data( 7 downto 0) <= img_data;
				else
					splice_data(15 downto 8) <= img_data;
				end if;
			end if;
		end if;
	end process;
	--img_dval_delay 
	process(reset,EN,snRCLK)
	begin
		if reset = '1' or EN = '0' then 
			img_dval_delay <= (others => '0');
			addra_cnt <= (others => '0');
		elsif falling_edge(snRCLK) then
			img_dval_delay(0) <= img_dval0;
			img_dval_delay(3 downto 1) <= img_dval_delay(2 downto 0);
			
			if img_fval0 = '0' then
				addra_cnt <= (others => '0');
			elsif img_dval_delay(0) = '1' then
				addra_cnt <= addra_cnt + 1;
			end if;
			
		end if;
	end process;
	--dina_0 addra_0 wea_0 dina_1 addra_1 wea_1 
	process(reset,EN,snRCLK)
	begin
		if reset = '1' or EN = '0' then
			dina_0	<= 	(others => '0')	;
			dina_1	<= 	(others => '0')	;
			addra_0	<= 	(others => '0')	;
			addra_1 <= 	(others => '0')	;
			wea_0	<= 	"0"				;
			wea_1	<= 	"0"				;
		elsif falling_edge(snRCLK) then
			-- if img_fval0 = '1' then
				-- if img_dval = '1' then
					if addra_cnt(13) = '0' then
						if (addra_cnt(0) = '1' and img_dval_delay(0) = '1')  then--
							addra_0 <= addra_cnt(12 downto 1)	;
							dina_0 	<= splice_data				;
							wea_0 	<= "1"						;
							wea_1 	<= "0"						;
						else
							addra_0 <= (others => '0')	;
							dina_0 	<= (others => '0')	;
							wea_0 	<= "0"				;
							wea_1 	<= "0"				;
						end if;
					else
						if (addra_cnt(0) = '1' and img_dval_delay(0) = '1')  then-- 
							addra_1 <= addra_cnt(12 downto 1)	;
							dina_1 	<= splice_data				;
							wea_1 	<= "1"						;
							wea_0 	<= "0"						;
						else
							addra_1 <= (others => '0')	;
							dina_1 	<= (others => '0')	;
							wea_1 	<= "0"				;
							wea_0 	<= "0"				;
						end if;
					end if;
				-- else
					-- wea_0 <= "0";
					-- wea_1 <= "0";
				-- end if;
			-- else
				-- addra_0 <= (others => '0')	;
				-- addra_1 <= (others => '0')	;
				-- dina_0 	<= (others => '0')	;
				-- dina_1 	<= (others => '0')	;
				-- wea_0 	<= "0"				;
				-- wea_1 	<= "0"				;
			-- end if;
		end if;
	end process;
	
	--*********out to usb******************
	--usb_wr_req0 usb_wr_req1(no think of case that req0 and req1 = 1 are exist at same time)
	process(reset,EN,ft_clk)
	begin
		if reset = '1' or EN = '0' then
			usb_req_cnt		<= (others => '0')	;
			img_fval0_delay		<= (others => '0')	;
			usb_wr_req_delay	<= (others => '0')	;
			usb_wr_req0			<= '0'				;
			usb_wr_req1			<= '0'				;
			tmp_flag0			<= '0'				;
			tmp_flag1			<= '0'				;
			
		elsif rising_edge(ft_clk) then
			
			usb_wr_req_delay	<=	usb_wr_req_delay(1 downto 0)	&	addra_cnt(13)	;	--Across the clock(snRCLK->ft_clk)
			img_fval0_delay		<=	img_fval0_delay(1 downto 0) 	&	img_fval0		;	--Across the clock(snRCLK->ft_clk)
			img_dval0_delay		<=	img_dval0_delay(1 downto 0) 	&	img_dval0		;	--Across the clock(snRCLK->ft_clk)
			
			if ft_txe_n = '1' then
				if usb_req_cnt < 1023 then
					usb_req_cnt <= usb_req_cnt + 1;
				end if;
			else
				usb_req_cnt <= (others => '0');
			end if;
			
			if usb_wr_req_delay = "011" or (final_trig = '1' and bram_finish_num = '0' and usb_wr_req0 = '0') then--(wave_dval0_acrclk_delay = "100" and bram_finish_num = '0') then--
				usb_wr_req0 <= '1';
			elsif (usb_wr_en = '1' and usb_wr_req0 = '1') or usb_req_cnt = 1023 then
				usb_wr_req0 <= '0';
			end if;
			if usb_wr_req_delay = "100" or (final_trig = '1' and bram_finish_num = '1') then--(wave_dval0_acrclk_delay = "100" and bram_finish_num = '1') then--
				usb_wr_req1 <= '1';
			elsif (usb_wr_en = '1' and usb_wr_req1 = '1') or usb_req_cnt = 1023 then
				usb_wr_req1 <= '0';
			end if;

		end if;
	end process;
	usb_wr_req <= usb_wr_req0 or usb_wr_req1 when reset = '0' else '0';
	
	
	process(reset,EN,ft_clk)
	begin
		if reset = '1' or EN = '0' then
			img_row_cnt <= (others => '0');
			bram_finish_num <= '0';
			final_trig <= '0';
		elsif rising_edge(ft_clk) then
			if img_fval0_delay = "111" then
				if img_dval0_delay = "100" then
					if img_row_cnt = 719 then
						img_row_cnt <= (others => '0');
					else
						img_row_cnt <= img_row_cnt + 1;
					end if;				
				end if;
			elsif img_fval0_delay = "000" then
				img_row_cnt <= (others => '0');
			end if;
			--final_trig
			if img_dval0_delay = "100" and img_row_cnt = 719 then
				final_trig <= '1';
			elsif usb_wr_req0 = '0' or usb_req_cnt = 1023 then
				final_trig <= '0';
			end if;
			--usb_wr_req_delay
			
		end if;
	end process;
	
	--bram out data
	--addrb_cnt
	process(reset,EN,ft_clk)
	begin
		if reset = '1' or EN = '0' then
			addrb_cnt 	<= (others => '0')	;
			addrb_0 	<= (others => '0')	;
			addrb_1 	<= (others => '0')	;
		elsif rising_edge(ft_clk) then
			addrb_0 <= addrb_cnt;
			addrb_1 <= addrb_cnt;
			
			if usb_wr_en = '1' or usb_busy = '1' then
				if usb_wr_en = '1' or addrb_cnt /= 0 then
					addrb_cnt <= addrb_cnt + 1;
				end if;
			else
				addrb_cnt <= (others => '0');
			end if;
			
		end if;
	end process;
	--bram_rd_switch
	process(reset,EN,ft_clk)
	begin
		if reset = '1' or EN = '0' then
			bram_rd_switch <= '0';
		elsif rising_edge(ft_clk) then
			if usb_wr_en = '1' then
				if usb_wr_req0 = '1' then
					bram_rd_switch <= '0';
				elsif usb_wr_req1 = '1' then
					bram_rd_switch <= '1';
				end if;
			end if;
		end if;
	end process;
	--bram_data
	bram_data <= doutb_0 when bram_rd_switch = '0' else doutb_1;
	--bram_dval 
	process(reset,EN,ft_clk)
	begin
		if reset = '1' or EN = '0' then
			bram_dval <= '0';
			bram_dval0 <= '0';
		elsif rising_edge(ft_clk) then
			bram_dval <= bram_dval0 and usb_busy;
			if usb_wr_en = '1' then
				bram_dval0 <= '1';
			elsif addrb_cnt = 0 then
				bram_dval0 <= '0';				
			end if;
		end if;
	end process;
	--bram_fval   !!!!!!!!
	process(reset,EN,ft_clk)
	begin
		if reset = '1' or EN = '0' then
			bram_dval_cnt <= (others => '0');
			bram_fval <= '0';
		elsif rising_edge(ft_clk) then
			if img_fval = '0' and bram_dval0 = '0' then
				if bram_dval_cnt < x"FF" then
					bram_dval_cnt <= bram_dval_cnt + 1;
				end if;
			elsif img_fval = '1' then
				bram_dval_cnt <= (others => '0');
			end if;
			
			if usb_wr_en = '1' then
				bram_fval <= '1';
			elsif bram_dval_cnt = x"FF" then
				bram_fval <= '0';
			end if;
		
		end if;
	end process;

end Behavioral;

