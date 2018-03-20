----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:53:21 01/30/2018 
-- Design Name: 
-- Module Name:    usb_module_1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--		Architecture of CMD : --| 56~63 : flag            X
--								| 48~55 : No.cmos         X
--								| 32~47 : Gain            X
--								| 16~31 : Row Start       X
--								\  0~15 : Column Start    X
--							========================================	
--							  --| 63~48 : Gain          -> 
--								| 47~32 : Row Start     ->   
--								| 31~24 : flag          -> 24:Reg;	25:Skip(No use);	26:Global
--								| 23~16 : No.cmos       -> 17-16:cmos num;	20-18:SPB num;
--								\  0~15 : Nothing
--								
--
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

entity cmd_module is
	port(
		clk66			:		in 		std_logic							;
		reset			:		in 		std_logic							;
		ft_clk			:		in 		std_logic							;
		ft_rxf_n		:		in		std_logic							;
		ft_rd_n			:		out		std_logic							;
		ft_oe_n			:		out		std_logic							;
		ft_data			:		inout	std_logic_vector(15 downto 0)       ;
		
		ft_reset_n	    :		out     std_logic							;
		ft_siwu_n	    :		out     std_logic							;
		ft_be		    :		out     std_logic_vector( 1 downto 0)		;		
		
		cmd_spb_num		:		out		std_logic_vector( 3 downto 0)       ;
		cmd_spb_val		:		out		std_logic							;
		led				:		out		std_logic_vector( 2 downto 0)       ;
		--CMD
		SL0				:		out		std_logic							;
		SD0				:		out		std_logic							;
		SCK0			:		out		std_logic							;		
		SL1				:		out		std_logic							;
		SD1				:		out		std_logic							;
		SCK1			:		out		std_logic							;		
		SL2				:		out		std_logic							;
		SD2				:		out		std_logic							;
		SCK2			:		out		std_logic							;		
		SL3				:		out		std_logic							;
		SD3				:		out		std_logic							;
		SCK3			:		out		std_logic							;		
		SL4				:		out		std_logic							;
		SD4				:		out		std_logic							;
		SCK4			:		out		std_logic							;		
		SL5				:		out		std_logic							;
		SD5				:		out		std_logic							;
		SCK5			:		out		std_logic							;		
		SL6				:		out		std_logic							;
		SD6				:		out		std_logic							;
		SCK6			:		out		std_logic							;		
		SL7				:		out		std_logic							;
		SD7				:		out		std_logic							;
		SCK7			:		out		std_logic							
		
	);
end cmd_module;

architecture Behavioral of cmd_module is

	signal		ft_rxf_delay	:	std_logic_vector( 2 downto 0)			;
	signal		ft_rxf_n0		:	std_logic								;
	signal		rcv_cmd			:	std_logic_vector(63 downto 0)			;
	
	signal		cmd0_trig		:	std_logic								;
	signal		cmd0_data		:	std_logic_vector(63 downto 0)			;
	signal		idle0			:	std_logic								;
	
	signal		cmd1_trig		:	std_logic								;
	signal		cmd1_data		:	std_logic_vector(63 downto 0)			;
	signal		idle1			:	std_logic								;
	
	signal		cmd2_trig		:	std_logic								;
	signal		cmd2_data		:	std_logic_vector(63 downto 0)			;
	signal		idle2			:	std_logic								;
	
	signal		cmd3_trig		:	std_logic								;
	signal		cmd3_data		:	std_logic_vector(63 downto 0)			;
	signal		idle3			:	std_logic								;
	
	signal		cmd4_trig		:	std_logic								;
	signal		cmd4_data		:	std_logic_vector(63 downto 0)			;
	signal		idle4			:	std_logic								;
	
	signal		cmd5_trig		:	std_logic								;
	signal		cmd5_data		:	std_logic_vector(63 downto 0)			;
	signal		idle5			:	std_logic								;
	
	signal		cmd6_trig		:	std_logic								;
	signal		cmd6_data		:	std_logic_vector(63 downto 0)			;
	signal		idle6			:	std_logic								;
	
	signal		cmd7_trig		:	std_logic								;
	signal		cmd7_data		:	std_logic_vector(63 downto 0)			;
	signal		idle7			:	std_logic								;
	

	COMPONENT CMD2SPB
	PORT(
		clk 		: 		IN 		std_logic						;
		reset 		: 		IN 		std_logic						;
		cmd_trig 	: 		IN 		std_logic						;
		cmd_data 	: 		IN 		std_logic_vector(63 downto 0)	;          
		SCK 		: 		OUT 	std_logic						;
		SD 			: 		OUT 	std_logic						;
		SL 			: 		OUT 	std_logic						;
		idle 		: 		OUT 	std_logic
		);
	END COMPONENT;

begin
	
	Inst0_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK0       	,
		SD 			=> 		SD0        	,
		SL 			=> 		SL0        	,
		cmd_trig 	=> 		cmd0_trig  	,
		idle 		=> 		idle0      	,
		cmd_data 	=> 		cmd0_data      
	);
	
	Inst1_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK1       	,
		SD 			=> 		SD1        	,
		SL 			=> 		SL1        	,
		cmd_trig 	=> 		cmd1_trig  	,
		idle 		=> 		idle1      	,
		cmd_data	=> 		cmd1_data      
	);
	
	Inst2_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK2       	,
		SD 			=> 		SD2        	,
		SL 			=> 		SL2        	,
		cmd_trig 	=> 		cmd2_trig  	,
		idle 		=> 		idle2      	,
		cmd_data	=> 		cmd2_data      
	);
	
	Inst3_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK3       	,
		SD 			=> 		SD3        	,
		SL 			=> 		SL3        	,
		cmd_trig 	=> 		cmd3_trig  	,
		idle 		=> 		idle3      	,
		cmd_data	=> 		cmd3_data      
	);
	
	Inst4_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK4       	,
		SD 			=> 		SD4        	,
		SL 			=> 		SL4        	,
		cmd_trig 	=> 		cmd4_trig  	,
		idle 		=> 		idle4      	,
		cmd_data	=> 		cmd4_data      
	);
	
	Inst5_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK5       	,
		SD 			=> 		SD5        	,
		SL 			=> 		SL5        	,
		cmd_trig 	=> 		cmd5_trig  	,
		idle 		=> 		idle5      	,
		cmd_data	=> 		cmd5_data      
	);
	
	Inst6_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK6       	,
		SD 			=> 		SD6        	,
		SL 			=> 		SL6        	,
		cmd_trig 	=> 		cmd6_trig  	,
		idle 		=> 		idle6      	,
		cmd_data	=> 		cmd6_data      
	);
	
	Inst7_CMD2SPB: CMD2SPB PORT MAP(
		clk 		=> 		clk66     	,
		reset 		=> 		reset     	,
		SCK 		=> 		SCK7       	,
		SD 			=> 		SD7        	,
		SL 			=> 		SL7        	,
		cmd_trig 	=> 		cmd7_trig  	,
		idle 		=> 		idle7      	,
		cmd_data	=> 		cmd7_data      
	);

	--===========================
	--		Receive CMD
	--===========================
	process(reset,ft_clk)
	begin
		if reset = '1' then
			ft_rxf_n0 <= '1';
			ft_oe_n <= '1';
			ft_rd_n <= '1';
			rcv_cmd <= (others => '0');
			led <= (others => '0');
			cmd_spb_num <= (others => '0');
			cmd_spb_val <= '0';
		elsif rising_edge(ft_clk) then
			ft_rxf_n0 <= ft_rxf_n;
			--ft_oe_n
			if ft_rxf_n = '0' then
				ft_oe_n <= '0';
			else
				ft_oe_n <= '1';
			end if;
			--ft_rd_n
			if ft_rxf_n0 = '0' and ft_rxf_n = '0' then
				ft_rd_n <= '0';
			else
				ft_rd_n <= '1';
			end if;
			--ft_data
			if ft_rxf_n = '0' then
				rcv_cmd <= rcv_cmd(47 downto 0) & ft_data;
			end if;
			--cmd_spb_num cmd_spb_val
			if ft_rxf_n = '1' then
				cmd_spb_num <= "0" & rcv_cmd(20 downto 18);
				cmd_spb_val <= '1';
				led <= rcv_cmd(18 downto 16);
			else
				cmd_spb_val <= '0';
			end if;

		end if;
	end process;
	
	--==========================
	--		Send CMD
	--==========================
	--
	process(reset,clk66)
	begin
		if reset = '1' then
			cmd0_trig <= '0';
			cmd0_data <= (others => '0');
			cmd1_trig <= '0';
			cmd1_data <= (others => '0');
			cmd2_trig <= '0';
			cmd2_data <= (others => '0');
			cmd3_trig <= '0';
			cmd3_data <= (others => '0');
			cmd4_trig <= '0';
			cmd4_data <= (others => '0');
			cmd5_trig <= '0';
			cmd5_data <= (others => '0');
			cmd6_trig <= '0';
			cmd6_data <= (others => '0');
			cmd7_trig <= '0';
			cmd7_data <= (others => '0');	
			ft_rxf_delay <= (others => '0');	
			
		elsif rising_edge(clk66) then
			ft_rxf_delay <= ft_rxf_delay(1 downto 0) & ft_rxf_n;--across clock
			if ft_rxf_delay = "011" then
				if rcv_cmd(26) = '1' then--Global
					cmd0_trig <= '1';
					cmd0_data <= rcv_cmd;
					cmd1_trig <= '1';
					cmd1_data <= rcv_cmd;
					cmd2_trig <= '1';
					cmd2_data <= rcv_cmd;
					cmd3_trig <= '1';
					cmd3_data <= rcv_cmd;
					cmd4_trig <= '1';
					cmd4_data <= rcv_cmd;
					cmd5_trig <= '1';
					cmd5_data <= rcv_cmd;
					cmd6_trig <= '1';
					cmd6_data <= rcv_cmd;
					cmd7_trig <= '1';
					cmd7_data <= rcv_cmd;
				else
					case rcv_cmd(20 downto 18) is
						when "000" => cmd0_trig <= '1';cmd0_data <= rcv_cmd;
						when "001" => cmd1_trig <= '1';cmd1_data <= rcv_cmd;
						when "010" => cmd2_trig <= '1';cmd2_data <= rcv_cmd;
						when "011" => cmd3_trig <= '1';cmd3_data <= rcv_cmd;
						when "100" => cmd4_trig <= '1';cmd4_data <= rcv_cmd;
						when "101" => cmd5_trig <= '1';cmd5_data <= rcv_cmd;
						when "110" => cmd6_trig <= '1';cmd6_data <= rcv_cmd;
						when "111" => cmd7_trig <= '1';cmd7_data <= rcv_cmd;
						when others => NULL;
						
					end case;
				end if;
			else
				cmd0_trig <= '0';
				cmd1_trig <= '0';
				cmd2_trig <= '0';
				cmd3_trig <= '0';
				cmd4_trig <= '0';
				cmd5_trig <= '0';
				cmd6_trig <= '0';
				cmd7_trig <= '0';
			end if;
		
		end if;
	end process;
	
	--============================
	--		No use now		
	--============================
	ft_reset_n	  <=	'1'				;
	ft_siwu_n	  <=	'1'				;
	ft_be		  <=	(others => '1')	;
	
	
	

end Behavioral;

