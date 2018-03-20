----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:42:29 01/16/2018 
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

entity usb_module is
	port(
		-- clk			:	in		std_logic;
		reset		:	in		std_logic;
		--FT600
		ft_clk		:	in		std_logic;
		ft_txe_n	:	in		std_logic;
		ft_wr_n 	:	out		std_logic;
		ft_data 	:	inout	std_logic_vector(15 downto 0);
		
		ft_reset_n	:	out		std_logic;
		-- ft_rxf_n	:	in		std_logic;
		ft_siwu_n	:	out		std_logic;
		ft_rd_n		:	out		std_logic;
		ft_oe_n		:	out		std_logic;
		ft_be		:	inout	std_logic_vector( 1 downto 0);
		--
		bram_data	:	in		std_logic_vector(15 downto 0);
		bram_dval	:	in		std_logic;--data valid
		usb_wr_req	:	in		std_logic;--no pulse
		usb_wr_en	:	out		std_logic;--pulse
		usb_busy	:	out		std_logic
		);
end usb_module;

architecture Behavioral of usb_module is
	--state
	constant	USB_ARB			:	std_logic_vector( 3 downto 0) 	:= 		x"0";
	constant	USB_IDLE		:	std_logic_vector( 3 downto 0) 	:= 		x"1";--do nothing
--	constant	USB_BUSY		:	std_logic_vector( 3 downto 0) 	:= 		x"2";--imply:no need data transfer
	constant	USB_WR			:	std_logic_vector( 3 downto 0) 	:= 		x"3";
	signal		state			:	std_logic_vector( 3 downto 0);
	
--	signal		usb_wr_req		:	std_logic;
	signal		flag_init_end	:	std_logic;
	signal		usb_wr_en0		:	std_logic;
	signal		usb_wr_end		:	std_logic;

	signal		ft_txe_n0		:	std_logic;
	
begin
	--state
	process(reset,ft_clk)
	begin
		if reset = '1' then
			state <= USB_IDLE;
		elsif rising_edge(ft_clk) then
			case state is
				when USB_IDLE	=>
										if ft_txe_n = '0' then
											state <= USB_ARB;
										else	
											state <= USB_IDLE;
										end if;
				when USB_ARB	=>
										if ft_txe_n = '1' then
											state <= USB_IDLE;
										elsif usb_wr_en0 = '1' then
											state <= USB_WR;
										else
											state <= USB_ARB;
										end if;
				when USB_WR		=>
										if ft_txe_n = '1' then
											state <= USB_IDLE;
										elsif usb_wr_end = '1' then
											state <= USB_ARB;
										else	
											state <= USB_WR;
										end if;
				when others		=>
										state <= USB_IDLE;
			end case;
		end if;
	end process;
	
	--when txe_n = 1, one write usb end.
	process(reset,ft_clk)
	begin
		if reset = '1' then 
			usb_wr_en0 <= '0';
		elsif rising_edge(ft_clk) then
			if state = USB_ARB and usb_wr_req = '1' and usb_wr_en0 = '0' then
				usb_wr_en0 <= '1';
			else
				usb_wr_en0 <= '0';
			end if;
		end if;
	end process;
	usb_wr_en <= usb_wr_en0;
	--usb_busy
	process(reset,ft_clk)
	begin
		if reset = '1' then
			usb_busy <= '1';
		elsif rising_edge(ft_clk) then
			if usb_wr_en0 = '1' then
				usb_busy <= '1';
			elsif usb_wr_end = '1' then
				usb_busy <= '0';
			end if;
		end if;
	end process;
	--usb_wr_end
	process(reset,ft_clk)
	begin
		if reset = '1' then
			usb_wr_end <= '0';
			ft_wr_n <= '1';
		elsif rising_edge(ft_clk) then

			ft_txe_n0 <= ft_txe_n;
			if ft_txe_n = '1' and ft_txe_n0 = '0' then
				usb_wr_end <= '1';
			else
				usb_wr_end <= '0';
			end if;
			
			if bram_dval = '1' then--usb_wr_en0 = '1'
				ft_wr_n <= '0';
			elsif ft_txe_n = '1' then
				ft_wr_n <= '1';
			end if;
		end if;
	end process;
	--ft_data
	process(reset,ft_clk)
	begin
		if reset = '1' then
			ft_data <= (others => '0');
		elsif rising_edge(ft_clk) then
			if bram_dval = '1' then
				ft_data <= bram_data;
			else
				ft_data <= (others => '0');
			end if;
		end if;
	end process;
	--ft_data
	-- ft_data <= bram_data when bram_dval = '1' else (others => '1');
	
	
	--usb configure
	ft_reset_n	<=	'1';
	ft_siwu_n	<=	'1';
	ft_rd_n		<=	'1';
	ft_oe_n		<=	'1';
	ft_be		<=	"11";
	
end Behavioral;

