----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:35:18 03/09/2018 
-- Design Name: 
-- Module Name:    total_img_module - Behavioral 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity total_img_module is
	port(
		clk66			:		in		std_logic						;
		reset			:		in		std_logic						;
		
		ft_clk 			:		in		std_logic						;
		ft_txe_n 		:		in		std_logic						;
		ft_data 		:		inout	std_logic_vector(15 downto 0)	;
		ft_be 			:		inout	std_logic_vector( 1 downto 0)	;
		ft_wr_n 		:		out		std_logic						;
		ft_reset_n 		:		out		std_logic						;
		ft_siwu_n 		:		out		std_logic						;
		ft_rd_n 		:		out		std_logic						;
		ft_oe_n 		:		out		std_logic						;
		
		snLOCK_0		:		in		std_logic						;
		snRCLK_0		:		in		std_logic						;
		snDATA_0		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_0		:		out		std_logic						;
		
		snLOCK_1		:		in		std_logic						;
		snRCLK_1		:		in		std_logic						;
		snDATA_1		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_1		:		out		std_logic						;
		
		snLOCK_2		:		in		std_logic						;
		snRCLK_2		:		in		std_logic						;
		snDATA_2		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_2		:		out		std_logic						;
		
		snLOCK_3		:		in		std_logic						;
		snRCLK_3		:		in		std_logic						;
		snDATA_3		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_3		:		out		std_logic						;
		
		snLOCK_4		:		in		std_logic						;
		snRCLK_4		:		in		std_logic						;
		snDATA_4		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_4		:		out		std_logic						;
		
		snLOCK_5		:		in		std_logic						;
		snRCLK_5		:		in		std_logic						;
		snDATA_5		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_5		:		out		std_logic						;
		
		snLOCK_6		:		in		std_logic						;
		snRCLK_6		:		in		std_logic						;
		snDATA_6		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_6		:		out		std_logic						;
		
		snLOCK_7		:		in		std_logic						;
		snRCLK_7		:		in		std_logic						;
		snDATA_7		:		in		std_logic_vector( 9 downto 0)	;
		snREFCLK_7		:		out		std_logic						;
		
		led				:		out		std_logic_vector( 2 downto 0)	;	
		rcv_cmd_val		:		in		std_logic						;
		rcv_cmd			:		in		std_logic_vector( 3 downto 0)
		
		
	);
end total_img_module;

architecture Behavioral of total_img_module is

	signal		usb_busy 		:			std_logic						;
	signal		usb_wr_en 		:			std_logic						; 
	signal		usb_wr_req 		:			std_logic						;
	-- signal		bram_fval 		:			std_logic						;
	signal		bram_dval 		:			std_logic						;
	signal		bram_data 		:			std_logic_vector(15 downto 0)	;

	
	signal		usb0_busy 		:			std_logic						;
	signal		usb0_wr_en 		:			std_logic						; 
	signal		usb0_wr_req 	:			std_logic						;
	signal		bram0_dval 		:			std_logic						;
	signal		bram0_fval 		:			std_logic						;
	signal		bram0_fval0 		:			std_logic						;
	signal		bram0_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		usb1_busy 		:			std_logic						;
	signal		usb1_wr_en 		:			std_logic						; 
	signal		usb1_wr_req 	:			std_logic						;
	signal		bram1_dval 		:			std_logic						;
	signal		bram1_fval 		:			std_logic						;
	signal		bram1_fval0 		:			std_logic						;
	signal		bram1_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		usb2_busy 		:			std_logic						;
	signal		usb2_wr_en 		:			std_logic						; 
	signal		usb2_wr_req 	:			std_logic						;
	signal		bram2_dval 		:			std_logic						;
	signal		bram2_fval 		:			std_logic						;
	signal		bram2_fval0 		:			std_logic						;
	signal		bram2_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		usb3_busy 		:			std_logic						;
	signal		usb3_wr_en 		:			std_logic						; 
	signal		usb3_wr_req 	:			std_logic						;
	signal		bram3_dval 		:			std_logic						;
	signal		bram3_fval 		:			std_logic						;
	signal		bram3_fval0 		:			std_logic						;
	signal		bram3_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		usb4_busy 		:			std_logic						;
	signal		usb4_wr_en 		:			std_logic						; 
	signal		usb4_wr_req 	:			std_logic						;
	signal		bram4_dval 		:			std_logic						;
	signal		bram4_fval 		:			std_logic						;
	signal		bram4_fval0 		:			std_logic						;
	signal		bram4_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		usb5_busy 		:			std_logic						;
	signal		usb5_wr_en 		:			std_logic						; 
	signal		usb5_wr_req 	:			std_logic						;
	signal		bram5_dval 		:			std_logic						;
	signal		bram5_fval 		:			std_logic						;
	signal		bram5_fval0 		:			std_logic						;
	signal		bram5_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		usb6_busy 		:			std_logic						;
	signal		usb6_wr_en 		:			std_logic						; 
	signal		usb6_wr_req 	:			std_logic						;
	signal		bram6_dval 		:			std_logic						;
	signal		bram6_fval 		:			std_logic						;
	signal		bram6_fval0 		:			std_logic						;
	signal		bram6_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		usb7_busy 		:			std_logic						;
	signal		usb7_wr_en 		:			std_logic						; 
	signal		usb7_wr_req 	:			std_logic						;
	signal		bram7_dval 		:			std_logic						;
	signal		bram7_fval 		:			std_logic						;
	signal		bram7_fval0 		:			std_logic						;
	signal		bram7_data 		:			std_logic_vector(15 downto 0)	;
	
	signal		last_cmd		:			std_logic_vector( 3 downto 0)	;
	signal		cur_cmd			:			std_logic_vector( 3 downto 0)	;
	signal		cmd_spb_num		:			std_logic_vector( 3 downto 0)	;
	signal		rcv_cmd_val_delay		:			std_logic_vector( 1 downto 0)	;
	-- signal		cmd_flag		:		std_logic							;
	
	signal		EN0				:			std_logic						;
	signal		EN1				:			std_logic						;
	signal		EN2				:			std_logic						;
	signal		EN3				:			std_logic						;
	signal		EN4				:			std_logic						;
	signal		EN5				:			std_logic						;
	signal		EN6				:			std_logic						;
	signal		EN7				:			std_logic						;
	
	
	COMPONENT sn_module
	PORT(
		clk66 		:		IN		std_logic						;
		snLOCK_N 	:		IN		std_logic						;
		snRCLK 		:		IN		std_logic						;
		snDATA 		:		IN		std_logic_vector(9 downto 0)	;
		reset 		:		IN		std_logic						;
		EN 		:		IN		std_logic						;
		ft_clk 		:		IN		std_logic						;
		ft_txe_n 	:		IN		std_logic						;
		usb_busy 	:		IN		std_logic						;
		usb_wr_en 	:		IN		std_logic						;          
		snREFCLK 	:		OUT		std_logic						;
		usb_wr_req 	:		OUT		std_logic						;
		bram_fval 	:		OUT		std_logic						;
		bram_dval 	:		OUT		std_logic						;
		bram_data 	:		OUT		std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT usb_module
	PORT(
		reset 		:	IN		std_logic						;
		ft_clk 		:	IN		std_logic						;
		ft_txe_n 	:	IN		std_logic						;
		bram_data 	:	IN		std_logic_vector(15 downto 0)	;
		bram_dval 	:	IN		std_logic						;
		usb_wr_req 	:	IN		std_logic						;    
		ft_data 	:	INOUT	std_logic_vector(15 downto 0)	;
		ft_be 		:	INOUT	std_logic_vector( 1 downto 0)	;      
		ft_wr_n 	:	OUT		std_logic						;
		ft_reset_n 	:	OUT		std_logic						;
		ft_siwu_n 	:	OUT		std_logic						;
		ft_rd_n 	:	OUT		std_logic						;
		ft_oe_n 	:	OUT		std_logic						;
		usb_wr_en 	:	OUT		std_logic						;
		usb_busy 	:	OUT		std_logic
		);
	END COMPONENT;

begin

	Inst_sn0_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_0	     	,--Z
		snRCLK 			=>		snRCLK_0         	,--Z
		snREFCLK 		=>		snREFCLK_0       	,--Z
		snDATA 			=>		snDATA_0         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN0            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb0_busy        	,--in from usb_module
		usb_wr_en 		=>		usb0_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb0_wr_req      	,--out to usb_module
		bram_fval 		=>		bram0_fval       	,--out to usb_module
		bram_dval 		=>		bram0_dval       	,--out to usb_module
		bram_data 		=>		bram0_data        	 --out to usb_module
	);

	Inst_sn1_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_1	     	,--Z
		snRCLK 			=>		snRCLK_1         	,--Z
		snREFCLK 		=>		snREFCLK_1       	,--Z
		snDATA 			=>		snDATA_1         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN1            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb1_busy        	,--in from usb_module
		usb_wr_en 		=>		usb1_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb1_wr_req      	,--out to usb_module
		bram_fval 		=>		bram1_fval       	,--out to usb_module
		bram_dval 		=>		bram1_dval       	,--out to usb_module
		bram_data 		=>		bram1_data        	 --out to usb_module
	);

	Inst_sn2_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_2	     	,--Z
		snRCLK 			=>		snRCLK_2         	,--Z
		snREFCLK 		=>		snREFCLK_2       	,--Z
		snDATA 			=>		snDATA_2         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN2            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb2_busy        	,--in from usb_module
		usb_wr_en 		=>		usb2_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb2_wr_req      	,--out to usb_module
		bram_fval 		=>		bram2_fval       	,--out to usb_module
		bram_dval 		=>		bram2_dval       	,--out to usb_module
		bram_data 		=>		bram2_data        	 --out to usb_module
	);

	Inst_sn3_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_3	     	,--Z
		snRCLK 			=>		snRCLK_3         	,--Z
		snREFCLK 		=>		snREFCLK_3       	,--Z
		snDATA 			=>		snDATA_3         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN3            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb3_busy        	,--in from usb_module
		usb_wr_en 		=>		usb3_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb3_wr_req      	,--out to usb_module
		bram_fval 		=>		bram3_fval       	,--out to usb_module
		bram_dval 		=>		bram3_dval       	,--out to usb_module
		bram_data 		=>		bram3_data        	 --out to usb_module
	);

	Inst_sn4_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_4	     	,--Z
		snRCLK 			=>		snRCLK_4         	,--Z
		snREFCLK 		=>		snREFCLK_4       	,--Z
		snDATA 			=>		snDATA_4         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN4            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb4_busy        	,--in from usb_module
		usb_wr_en 		=>		usb4_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb4_wr_req      	,--out to usb_module
		bram_fval 		=>		bram4_fval       	,--out to usb_module
		bram_dval 		=>		bram4_dval       	,--out to usb_module
		bram_data 		=>		bram4_data        	 --out to usb_module
	);

	Inst_sn5_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_5	     	,--Z
		snRCLK 			=>		snRCLK_5         	,--Z
		snREFCLK 		=>		snREFCLK_5       	,--Z
		snDATA 			=>		snDATA_5         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN5            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb5_busy        	,--in from usb_module
		usb_wr_en 		=>		usb5_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb5_wr_req      	,--out to usb_module
		bram_fval 		=>		bram5_fval       	,--out to usb_module
		bram_dval 		=>		bram5_dval       	,--out to usb_module
		bram_data 		=>		bram5_data        	 --out to usb_module
	);

	Inst_sn6_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_6	     	,--Z
		snRCLK 			=>		snRCLK_6         	,--Z
		snREFCLK 		=>		snREFCLK_6       	,--Z
		snDATA 			=>		snDATA_6         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN6            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb6_busy        	,--in from usb_module
		usb_wr_en 		=>		usb6_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb6_wr_req      	,--out to usb_module
		bram_fval 		=>		bram6_fval       	,--out to usb_module
		bram_dval 		=>		bram6_dval       	,--out to usb_module
		bram_data 		=>		bram6_data        	 --out to usb_module
	);

	Inst_sn7_module: sn_module PORT MAP(
		clk66 			=> 		clk66            	,--Z
		snLOCK_N 		=>		snLOCK_7	     	,--Z
		snRCLK 			=>		snRCLK_7         	,--Z
		snREFCLK 		=>		snREFCLK_7       	,--Z
		snDATA 			=>		snDATA_7         	,--Z
		reset 			=>		reset            	,--Z
		EN 			=>		EN7            	,
		ft_clk 			=>		ft_clk		     	,--Z
		ft_txe_n 		=>		ft_txe_n         	,--Z
		usb_busy 		=>		usb7_busy        	,--in from usb_module
		usb_wr_en 		=>		usb7_wr_en       	,--in from usb_module
		usb_wr_req 		=>		usb7_wr_req      	,--out to usb_module
		bram_fval 		=>		bram7_fval       	,--out to usb_module
		bram_dval 		=>		bram7_dval       	,--out to usb_module
		bram_data 		=>		bram7_data        	 --out to usb_module
	);
--=====================================================================================
	Inst_usb_module: usb_module PORT MAP(
		reset 			=> 		reset		        ,--Z
		ft_clk 			=> 		ft_clk 				,--Z					 
		ft_txe_n 		=> 		ft_txe_n 		    ,--Z                       	
		ft_wr_n 		=> 		ft_wr_n 	        ,--Z                   	
		ft_data 		=> 		ft_data 	        ,--Z                   	
		ft_reset_n 		=> 		ft_reset_n 		    ,--Z                       	
		ft_siwu_n 		=> 		ft_siwu_n 		    ,--Z                       	
		ft_rd_n 		=> 		ft_rd_n 	        ,--Z               	
		ft_oe_n 		=> 		ft_oe_n 	        ,--Z                   	
		ft_be 			=> 		ft_be 				,--Z                          	
		bram_data		=> 		bram_data		    ,--in from sn_module                       	
		bram_dval		=> 		bram_dval		    ,--in from sn_module
		usb_wr_req 		=> 		usb_wr_req		    ,--in from sn_module
		usb_wr_en 		=> 		usb_wr_en		    ,--out to sn_module
		usb_busy 		=> 		usb_busy             --out to sn_module
	);

	-- bram_data	   <=		bram0_data	   ;
	-- bram_dval	   <=		bram0_dval	   ;
	-- usb_wr_req	   <=		usb0_wr_req	   ;
	-- usb0_wr_en	   <=		usb_wr_en	   ;
	-- usb0_busy      <=		usb_busy   	   ;
 
	led <= bram0_fval & ft_txe_n & usb0_wr_req;
	--=============================
	--		CMD
	--=============================
	process(reset,ft_clk)
	begin
		if reset = '1' then
			last_cmd <= (others => '0');
			cur_cmd  <= (others => '0');
			cmd_spb_num <= (others => '0');
			rcv_cmd_val_delay <= (others => '0');
			-- cmd_flag <= '0';
			-- bram_fval <= '0';
			bram_dval <= '0';
			EN0 <= '0';bram0_fval0 <= '0';
			EN1 <= '0';bram1_fval0 <= '0';
			EN2 <= '0';bram2_fval0 <= '0';
			EN3 <= '0';bram3_fval0 <= '0';
			EN4 <= '0';bram4_fval0 <= '0';
			EN5 <= '0';bram5_fval0 <= '0';
			EN6 <= '0';bram6_fval0 <= '0';
			EN7 <= '0';bram7_fval0 <= '0';
		elsif rising_edge(ft_clk) then
			rcv_cmd_val_delay <= rcv_cmd_val_delay(0) & rcv_cmd_val;
			if rcv_cmd_val_delay = "11" then
				cmd_spb_num <= rcv_cmd;
			end if;
			
			bram0_fval0 <= bram0_fval;
			bram1_fval0 <= bram1_fval;
			bram2_fval0 <= bram2_fval;
			bram3_fval0 <= bram3_fval;
			bram4_fval0 <= bram4_fval;
			bram5_fval0 <= bram5_fval;
			bram6_fval0 <= bram6_fval;
			bram7_fval0 <= bram7_fval;
			
			case cur_cmd is
				when x"0" =>	if bram0_fval0 = '1' and bram0_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when x"1" =>	if bram1_fval0 = '1' and bram1_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when x"2" =>	if bram2_fval0 = '1' and bram2_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when x"3" =>	if bram3_fval0 = '1' and bram3_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when x"4" =>	if bram4_fval0 = '1' and bram4_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when x"5" =>	if bram5_fval0 = '1' and bram5_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when x"6" =>	if bram6_fval0 = '1' and bram6_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when x"7" =>	if bram7_fval0 = '1' and bram7_fval = '0' then
									cur_cmd <= cmd_spb_num;
								end if;
				when others => NULL;				

			end case;
			
			---
			
				case cur_cmd is
					when x"0" => bram_dval <= bram0_dval;bram_data <= bram0_data;usb_wr_req <= usb0_wr_req;usb0_wr_en <= usb_wr_en;usb0_busy <= usb_busy;EN0 <= '1';EN1 <= '0';EN2 <= '0';EN3 <= '0';EN4 <= '0';EN5 <= '0';EN6 <= '0';EN7 <= '0';--bram_fval <= bram0_fval;	
					when x"1" => bram_dval <= bram1_dval;bram_data <= bram1_data;usb_wr_req <= usb1_wr_req;usb1_wr_en <= usb_wr_en;usb1_busy <= usb_busy;EN0 <= '0';EN1 <= '1';EN2 <= '0';EN3 <= '0';EN4 <= '0';EN5 <= '0';EN6 <= '0';EN7 <= '0';--bram_fval <= bram1_fval;
					when x"2" => bram_dval <= bram2_dval;bram_data <= bram2_data;usb_wr_req <= usb2_wr_req;usb2_wr_en <= usb_wr_en;usb2_busy <= usb_busy;EN0 <= '0';EN1 <= '0';EN2 <= '1';EN3 <= '0';EN4 <= '0';EN5 <= '0';EN6 <= '0';EN7 <= '0';--bram_fval <= bram2_fval;
					when x"3" => bram_dval <= bram3_dval;bram_data <= bram3_data;usb_wr_req <= usb3_wr_req;usb3_wr_en <= usb_wr_en;usb3_busy <= usb_busy;EN0 <= '0';EN1 <= '0';EN2 <= '0';EN3 <= '1';EN4 <= '0';EN5 <= '0';EN6 <= '0';EN7 <= '0';--bram_fval <= bram3_fval;
					when x"4" => bram_dval <= bram4_dval;bram_data <= bram4_data;usb_wr_req <= usb4_wr_req;usb4_wr_en <= usb_wr_en;usb4_busy <= usb_busy;EN0 <= '0';EN1 <= '0';EN2 <= '0';EN3 <= '0';EN4 <= '1';EN5 <= '0';EN6 <= '0';EN7 <= '0';--bram_fval <= bram4_fval;
					when x"5" => bram_dval <= bram5_dval;bram_data <= bram5_data;usb_wr_req <= usb5_wr_req;usb5_wr_en <= usb_wr_en;usb5_busy <= usb_busy;EN0 <= '0';EN1 <= '0';EN2 <= '0';EN3 <= '0';EN4 <= '0';EN5 <= '1';EN6 <= '0';EN7 <= '0';--bram_fval <= bram5_fval;
					when x"6" => bram_dval <= bram6_dval;bram_data <= bram6_data;usb_wr_req <= usb6_wr_req;usb6_wr_en <= usb_wr_en;usb6_busy <= usb_busy;EN0 <= '0';EN1 <= '0';EN2 <= '0';EN3 <= '0';EN4 <= '0';EN5 <= '0';EN6 <= '1';EN7 <= '0';--bram_fval <= bram6_fval;
					when x"7" => bram_dval <= bram7_dval;bram_data <= bram7_data;usb_wr_req <= usb7_wr_req;usb7_wr_en <= usb_wr_en;usb7_busy <= usb_busy;EN0 <= '0';EN1 <= '0';EN2 <= '0';EN3 <= '0';EN4 <= '0';EN5 <= '0';EN6 <= '0';EN7 <= '1';--bram_fval <= bram7_fval;
					when others => NULL;
				end case;
			
			
		end if;
	end process;
 




	   
end Behavioral;

