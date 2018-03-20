----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:04:34 02/28/2018 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: KEL version 2.0 using IMX178 sensor
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

entity top is
	port(
		--system
		clk_sys 		: 		in 		std_logic						;
		--FT600										
		ft0clk_fifo 	: 		in 		std_logic						;
		ft0RESET 		: 		out 	std_logic						;--low active
		ft0data 		: 		inout 	std_logic_vector(15 downto 0)	;
		ft0BE	 		: 		inout 	std_logic_vector( 1 downto 0)	;
		ft0TXE_N 		: 		in 		std_logic						;
		ft0RXF_N 		: 		in 		std_logic						;--no use, be set high
		ft0SIWU_N 		: 		out 	std_logic						;
		ft0WR_N 		: 		out 	std_logic						;
		ft0RD_N 		: 		out 	std_logic						;--no use, be set high
		ft0OE_N 		: 		out 	std_logic						;
		--FT600_1								
		ft1clk_fifo 	: 		in 		std_logic						;
		ft1RESET 		: 		out 	std_logic						;--low active
		ft1data 		: 		inout 	std_logic_vector(15 downto 0)	;
		ft1BE			: 		inout 	std_logic_vector( 1 downto 0)	;
		ft1TXE_N 		: 		in 		std_logic						;
		ft1RXF_N 		: 		in 		std_logic						;--no use, be set high
		ft1SIWU_N 		: 		out 	std_logic						;
		ft1WR_N 		: 		out 	std_logic						;
		ft1RD_N 		: 		out 	std_logic						;--no use, be set high
		ft1OE_N 		: 		out 	std_logic						;
		--serial interface
		SL0 			:		inout	std_Logic						;
		SCK0 			:		inout	std_Logic						;
		SD0 			:		inout	std_Logic						;

		SL1 			:		inout	std_Logic						;
		SCK1 			:		inout	std_Logic						;
		SD1 			:		inout	std_Logic						;

		SL2 			:		inout	std_Logic						;
		SCK2 			:		inout	std_Logic						;
		SD2 			:		inout	std_Logic						;

		SL3 			:		inout	std_Logic						;
		SCK3 			:		inout	std_Logic						;
		SD3 			:		inout	std_Logic						;

		SL4 			:		inout	std_Logic						;
		SCK4 			:		inout	std_Logic						;
		SD4 			:		inout	std_Logic						;

		SL5 			:		inout	std_Logic						;
		SCK5 			:		inout	std_Logic						;
		SD5 			:		inout	std_Logic						;

		SL6 			:		inout	std_Logic						;
		SCK6 			:		inout	std_Logic						;
		SD6 			:		inout	std_Logic						;

		SL7 			:		inout	std_Logic						;
		SCK7 			:		inout	std_Logic						;
		SD7 			:		inout	std_Logic						;
		--SN65LV1224
		snLOCK_0 		: 		in		std_logic						;--low active
		snRCLK_0 		: 		in		std_logic						;
		snREFCLK_0 		: 		out 	std_logic						;
		snDATA_0 		: 		in 		std_logic_vector(9 downto 0)	;

		snLOCK_1 		: 		in 		std_logic						;--low active
		snRCLK_1 		: 		in 		std_logic						;
		snREFCLK_1 		: 		out 	std_logic						;
		snDATA_1 		: 		in 		std_logic_vector(9 downto 0)	;

		snLOCK_2 		: 		in 		std_logic						;--low active
		snRCLK_2 		: 		in 		std_logic						;
		snREFCLK_2 		: 		out 	std_logic						;
		snDATA_2 		: 		in 		std_logic_vector(9 downto 0)	;

		snLOCK_3 		:		in 		std_logic						;--low active
		snRCLK_3 		:		in 		std_logic						;
		snREFCLK_3 		:		out 	std_logic						;
		snDATA_3 		:		in 		std_logic_vector(9 downto 0)	;

		snLOCK_4 		: 		in 		std_logic						;--low active
		snRCLK_4 		: 		in 		std_logic						;
		snREFCLK_4 		: 		out 	std_logic						;
		snDATA_4 		: 		in 		std_logic_vector(9 downto 0)	;

		snLOCK_5 		:		in 		std_logic						;--low active
		snRCLK_5 		:		in 		std_logic						;
		snREFCLK_5 		:		out 	std_logic						;
		snDATA_5 		:		in 		std_logic_vector(9 downto 0)	;
		
		snLOCK_6 		:		in 		std_logic						;--low active
		snRCLK_6 		:		in 		std_logic						;
		snREFCLK_6 		:		out 	std_logic						;
		snDATA_6 		:		in 		std_logic_vector(9 downto 0)	;
		
		snLOCK_7		:		in		std_logic						;--low active
		snRCLK_7		:		in		std_logic						;
		snREFCLK_7 		:		out 	std_logic						;
		snDATA_7 		:		in 		std_logic_vector(9 downto 0)	;
		--FAN heater1 heater2
		ctrl_fan 		:		out		std_logic						;
		heater1 		:		out		std_logic						;
--		heater2 		:		out		std_logic						;
		--RS232						
		rxd 			: 		in 		std_logic						;
		--Power for SPB
		PWRUP			:		out		std_logic_vector(7 downto 0)	;
		--LED								
		led 			:		out		std_logic_vector(2 downto 0)	
		);

end top;

architecture Behavioral of top is
	
	signal		reset			:		std_logic							;
	signal		clk66			:		std_logic							;
	--usb_module
	signal 		usb_busy 		:		std_logic							;
	signal 		usb_wr_en 		:		std_logic							;
	signal 		usb_wr_req		:		std_logic							;
	signal 		bram_dval 		:		std_logic							;
	signal 		bram_data 		:		std_logic_vector(15 downto 0)		;
	
	signal		cmd_spb_num 	:		std_logic_vector( 3 downto 0)		;
	signal		cmd_spb_val 	:		std_logic							;
	
	signal 		led0	 		:		std_logic_vector( 2 downto 0)		;
	signal 		led1	 		:		std_logic_vector( 2 downto 0)		;
	
	COMPONENT total_img_module
	PORT(
		clk66 			:		IN			std_logic						;
		reset 			:		IN			std_logic						;
		ft_clk 			:		IN			std_logic						;
		ft_txe_n		:		IN			std_logic						;
		snLOCK_0		:		IN			std_logic						;
		snRCLK_0		:		IN			std_logic						;
		snDATA_0		:		IN			std_logic_vector( 9 downto 0)	;
		snLOCK_1		:		IN			std_logic						;
		snRCLK_1		:		IN			std_logic						;
		snDATA_1		:		IN			std_logic_vector( 9 downto 0)	;
		snLOCK_2		:		IN			std_logic						;
		snRCLK_2		:		IN			std_logic						;
		snDATA_2		:		IN			std_logic_vector( 9 downto 0)	;
		snLOCK_3		:		IN			std_logic						;
		snRCLK_3		:		IN			std_logic						;
		snDATA_3		:		IN			std_logic_vector( 9 downto 0)	;
		snLOCK_4		:		IN			std_logic						;
		snRCLK_4		:		IN			std_logic						;
		snDATA_4		:		IN			std_logic_vector( 9 downto 0)	;
		snLOCK_5		:		IN			std_logic						;
		snRCLK_5		:		IN			std_logic						;
		snDATA_5		:		IN			std_logic_vector( 9 downto 0)	;
		snLOCK_6		:		IN			std_logic						;
		snRCLK_6		:		IN			std_logic						;
		snDATA_6		:		IN			std_logic_vector( 9 downto 0)	;
		snLOCK_7		:		IN			std_logic						;
		snRCLK_7		:		IN			std_logic						;
		snDATA_7		:		IN			std_logic_vector( 9 downto 0)	;
		rcv_cmd_val		:		IN			std_logic						;    
		rcv_cmd 		:		IN			std_logic_vector( 3 downto 0)	;    
		ft_data 		:		INOUT		std_logic_vector(15 downto 0)	;
		ft_be 			:		INOUT		std_logic_vector( 1 downto 0)	;      
		ft_wr_n 		:		OUT			std_logic						;
		ft_reset_n 		:		OUT			std_logic						;
		ft_siwu_n 		:		OUT			std_logic						;
		ft_rd_n 		:		OUT			std_logic						;
		ft_oe_n 		:		OUT			std_logic						;
		snREFCLK_0		:		OUT			std_logic						;
		snREFCLK_1		:		OUT			std_logic						;
		snREFCLK_2		:		OUT			std_logic						;
		snREFCLK_3		:		OUT			std_logic						;
		snREFCLK_4		:		OUT			std_logic						;
		snREFCLK_5		:		OUT			std_logic						;
		snREFCLK_6		:		OUT			std_logic						;
		snREFCLK_7		:		OUT			std_logic						;
		led 			:		OUT			std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	COMPONENT cmd_module
	PORT(
		clk66 			:		IN			std_logic						;
		reset 			:		IN			std_logic						;
		ft_clk 			:		IN			std_logic						;
		ft_rxf_n 		:		IN			std_logic						;    
		ft_data 		:		INOUT 		std_logic_vector(15 downto 0)	;      
		ft_rd_n 		:		OUT			std_logic						;
		ft_oe_n 		:		OUT			std_logic						;
		ft_reset_n 		:		OUT			std_logic						;
		ft_siwu_n 		:		OUT			std_logic						;
		ft_be 			:		OUT			std_logic_vector(1 downto 0)	;
		cmd_spb_num 	:		OUT			std_logic_vector(3 downto 0)	;
		cmd_spb_val 	:		OUT			std_logic						;
		led 			:		OUT			std_logic_vector(2 downto 0)	;
		SL0 			:		OUT			std_logic						;
		SD0 			:		OUT			std_logic						;
		SCK0 			:		OUT			std_logic						;
		SL1 			:		OUT			std_logic						;
		SD1 			:		OUT			std_logic						;
		SCK1 			:		OUT			std_logic						;
		SL2 			:		OUT			std_logic						;
		SD2 			:		OUT			std_logic						;
		SCK2	 		:		OUT			std_logic						;
		SL3 			:		OUT			std_logic						;
		SD3 			:		OUT			std_logic						;
		SCK3 			:		OUT			std_logic						;
		SL4 			:		OUT			std_logic						;
		SD4 			:		OUT			std_logic						;
		SCK4 			:		OUT			std_logic						;
		SL5 			:		OUT			std_logic						;
		SD5 			:		OUT			std_logic						;
		SCK5 			:		OUT			std_logic						;
		SL6 			:		OUT			std_logic						;
		SD6 			:		OUT			std_logic						;
		SCK6 			:		OUT			std_logic						;
		SL7 			:		OUT			std_logic						;
		SD7 			:		OUT			std_logic						;
		SCK7 			:		OUT			std_logic
		);
	END COMPONENT;
	

	COMPONENT wave_module
	PORT(
		reset 			:		IN		std_logic						;
		ft_clk 			:		IN		std_logic						;
		ft_txe_n		:		IN		std_logic						;
		sn0_lock		:		IN		std_logic						;
		sn0_rclk		:		IN		std_logic						;
		sn0_data		:		IN		std_logic_vector(9 downto 0)	;
		sn1_lock		:		IN		std_logic						;
		sn1_rclk		:		IN		std_logic						;
		sn1_data		:		IN		std_logic_vector(9 downto 0)	;
		sn2_lock		:		IN		std_logic						;
		sn2_rclk		:		IN		std_logic						;
		sn2_data		:		IN		std_logic_vector(9 downto 0)	;
		sn3_lock		:		IN		std_logic						;
		sn3_rclk		:		IN		std_logic						;
		sn3_data		:		IN		std_logic_vector(9 downto 0)	;
		sn4_lock		:		IN		std_logic						;
		sn4_rclk		:		IN		std_logic						;
		sn4_data		:		IN		std_logic_vector(9 downto 0)	;
		sn5_lock		:		IN		std_logic						;
		sn5_rclk		:		IN		std_logic						;
		sn5_data		:		IN		std_logic_vector(9 downto 0)	;
		sn6_lock		:		IN		std_logic						;
		sn6_rclk		:		IN		std_logic						;
		sn6_data		:		IN		std_logic_vector(9 downto 0)	;
		sn7_lock		:		IN		std_logic						;
		sn7_rclk		:		IN		std_logic						;
		sn7_data		:		IN		std_logic_vector(9 downto 0)	;          
		ft_wr_n			:		OUT		std_logic						;
		ft_data			:		OUT		std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT clock_module
	PORT(
		clk 			:		IN 			std_logic						;          
		clk66			:		OUT			std_logic						;
		reset			:		OUT			std_logic						;
		PWRUP 			:		OUT			std_logic_vector(7 downto 0)    ;
		led 			:		OUT			std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	

begin

	Inst_total_img_module: total_img_module PORT MAP(
		clk66 			=> 			clk66               ,--in from clock_module
		reset 			=> 			reset               ,--in from clock_module
		led 			=> 			led           	    ,--Z
		ft_clk 			=> 			ft0clk_fifo         ,--Z
		ft_txe_n 		=> 			ft0TXE_N            ,--Z
		ft_data 		=> 			ft0data             ,--Z
		ft_be 			=> 			ft0BE               ,--Z
		ft_wr_n	 		=> 			ft0WR_N             ,--Z
		ft_reset_n 		=> 			ft0RESET            ,--Z
		ft_siwu_n 		=> 			ft0SIWU_N           ,--Z
		ft_rd_n 		=> 			ft0RD_N             ,--Z
		ft_oe_n 		=> 			ft0OE_N             ,--Z
		
		snLOCK_0 		=> 			snLOCK_0 	        ,--Z
		snRCLK_0 		=> 			snRCLK_0 	        ,--Z
		snDATA_0 		=> 			snDATA_0 	        ,--Z
		snREFCLK_0 		=>          snREFCLK_0 			,--Z			
		snLOCK_1 		=> 			snLOCK_1 	        ,--Z
		snRCLK_1 		=> 			snRCLK_1 	        ,--Z
		snDATA_1 		=> 			snDATA_1 	        ,--Z
		snREFCLK_1 		=>          snREFCLK_1 			,--Z			
		snLOCK_2 		=> 			snLOCK_2 	        ,--Z
		snRCLK_2 		=> 			snRCLK_2 	        ,--Z
		snDATA_2 		=> 			snDATA_2 	        ,--Z
		snREFCLK_2 		=>          snREFCLK_2 			,--Z			
		snLOCK_3 		=> 			snLOCK_3 	        ,--Z
		snRCLK_3 		=> 			snRCLK_3 	        ,--Z
		snDATA_3 		=> 			snDATA_3 	        ,--Z
		snREFCLK_3 		=>          snREFCLK_3 			,--Z			
		snLOCK_4 		=> 			snLOCK_4 	        ,--Z
		snRCLK_4 		=> 			snRCLK_4 	        ,--Z
		snDATA_4 		=> 			snDATA_4 	        ,--Z
		snREFCLK_4 		=>          snREFCLK_4 			,--Z			
		snLOCK_5 		=> 			snLOCK_5 	        ,--Z
		snRCLK_5 		=> 			snRCLK_5 	        ,--Z
		snDATA_5 		=> 			snDATA_5 	        ,--Z
		snREFCLK_5 		=>          snREFCLK_5 			,--Z			
		snLOCK_6 		=> 			snLOCK_6 	        ,--Z
		snRCLK_6 		=> 			snRCLK_6 	        ,--Z
		snDATA_6 		=> 			snDATA_6 	        ,--Z
		snREFCLK_6 		=>          snREFCLK_6 			,--Z			
		snLOCK_7 		=> 			snLOCK_7 	        ,--Z
		snRCLK_7 		=> 			snRCLK_7 	        ,--Z
		snDATA_7 		=> 			snDATA_7 	        ,--Z
		snREFCLK_7 		=>          snREFCLK_7 			,--Z
		
		rcv_cmd_val		=>          cmd_spb_val		 	,--in from cmd_module
		rcv_cmd 		=>          cmd_spb_num		 	 --in from cmd_module
	
	);
	
	
		Inst_cmd_module: cmd_module PORT MAP(
		clk66 			=> 		clk66               ,--Z
		reset 			=> 		reset               ,--Z
		ft_clk 			=> 		ft1clk_fifo			,--Z	
		ft_rxf_n 		=> 		ft1RXF_N			,--Z	
		ft_rd_n 		=> 		ft1RD_N				,--Z	
		ft_oe_n 		=> 		ft1OE_N				,--Z	
		ft_data 		=> 		ft1data				,--Z
		ft_reset_n 		=> 		ft1RESET            ,--Z
		ft_siwu_n 		=> 		ft1SIWU_N           ,--Z
		ft_be 			=> 		ft1BE				,--Z
		cmd_spb_num 	=> 		cmd_spb_num         ,--out to total_img_module
		cmd_spb_val 	=> 		cmd_spb_val         ,--out to total_img_module
		led 			=> 		led1                 ,--Z
		SL0 			=> 		SL0 	            ,--Z
		SD0 			=> 		SD0 	            ,--Z
		SCK0 			=> 		SCK0 	            ,--Z
		SL1 			=> 		SL1 	            ,--Z
		SD1 			=> 		SD1 	            ,--Z
		SCK1 			=> 		SCK1 	            ,--Z
		SL2 			=> 		SL2 	            ,--Z
		SD2 			=> 		SD2 	            ,--Z
		SCK2 			=> 		SCK2 	            ,--Z
		SL3 			=> 		SL3 	            ,--Z
		SD3 			=> 		SD3 	            ,--Z
		SCK3 			=> 		SCK3 	            ,--Z
		SL4				=> 		SL4					,--Z
		SD4				=> 		SD4					,--Z
		SCK4 			=> 		SCK4 				,--Z
		SL5				=> 		SL5					,--Z
		SD5				=> 		SD5					,--Z
		SCK5 			=> 		SCK5 				,--Z
		SL6				=> 		SL6					,--Z
		SD6				=> 		SD6					,--Z
		SCK6 			=> 		SCK6 				,--Z
		SL7 			=> 		SL7 				,--Z
		SD7 			=> 		SD7 				,--Z
		SCK7			=>      SCK7	             --Z
	);

	
	Inst_wave_module: wave_module PORT MAP(
		reset 			=>			reset               ,--in from clock_module
		ft_clk 			=>			ft1clk_fifo         ,--Z
		ft_txe_n 		=>			ft1TXE_N            ,--Z
		ft_wr_n			=>			ft1WR_N             ,--Z
		ft_data			=>			ft1data             ,--Z
		sn0_lock		=>			snLOCK_0 	        ,--Z
		sn0_rclk		=>			snRCLK_0 	        ,--Z
		sn0_data		=>			snDATA_0 	        ,--Z
		sn1_lock		=>			snLOCK_1 	        ,--Z
		sn1_rclk		=>			snRCLK_1 	        ,--Z
		sn1_data		=>			snDATA_1 	        ,--Z
		sn2_lock		=>			snLOCK_2 	        ,--Z
		sn2_rclk		=>			snRCLK_2 	        ,--Z
		sn2_data		=>			snDATA_2 	        ,--Z
		sn3_lock		=>			snLOCK_3 	        ,--Z
		sn3_rclk		=>			snRCLK_3 	        ,--Z
		sn3_data		=>			snDATA_3 	        ,--Z
		sn4_lock		=>			snLOCK_4 	        ,--Z
		sn4_rclk		=>			snRCLK_4 	        ,--Z
		sn4_data		=>			snDATA_4 	        ,--Z
		sn5_lock		=>			snLOCK_5 	        ,--Z
		sn5_rclk		=>			snRCLK_5 	        ,--Z
		sn5_data		=>			snDATA_5 	        ,--Z
		sn6_lock		=>			snLOCK_6 	        ,--Z
		sn6_rclk		=>			snRCLK_6 	        ,--Z
		sn6_data		=>			snDATA_6 	        ,--Z
		sn7_lock		=>			snLOCK_7 	        ,--Z
		sn7_rclk		=>			snRCLK_7 	        ,--Z
		sn7_data		=>			snDATA_7 	        
	);

	Inst_clock_module: clock_module PORT MAP(
		clk	 			=> 		clk_sys					,
		reset	 		=> 		reset					,
		clk66	 		=> 		clk66					,
		PWRUP	 		=> 		PWRUP					,
		led 			=> 		led0
	);

	--===================================
	--		others unuseful signal 
	--===================================
	
	ctrl_fan	<=		'Z'		;
	heater1 	<=		'Z'		;

	
end Behavioral;

