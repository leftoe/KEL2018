--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:55:15 03/05/2018
-- Design Name:   
-- Module Name:   F:/ISE Project/kel/KEL_v2.0/IPB/IPB_v2.0/CMD2SPB_tb.vhd
-- Project Name:  IPB_v2.0
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CMD2SPB
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CMD2SPB_tb IS
END CMD2SPB_tb;
 
ARCHITECTURE behavior OF CMD2SPB_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CMD2SPB
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         SCK : OUT  std_logic;
         SD : OUT  std_logic;
         SL : OUT  std_logic;
         new_flag : IN  std_logic;
         idle : OUT  std_logic;
         zdata : IN  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal new_flag : std_logic := '0';
   signal zdata : std_logic_vector(63 downto 0) := (others => '0');

 	--Outputs
   signal SCK : std_logic;
   signal SD : std_logic;
   signal SL : std_logic;
   signal idle : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	--
	signal cnt : std_logic_vector(15 downto 0);
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CMD2SPB PORT MAP (
          clk => clk,
          reset => reset,
          SCK => SCK,
          SD => SD,
          SL => SL,
          new_flag => new_flag,
          idle => idle,
          zdata => zdata
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
	  reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;
	
	process(reset,clk)
	begin
		if reset = '1' then
			cnt <= (others => '0');
			new_flag <= '0';
			zdata <= (others => 'Z');
		elsif rising_edge(clk) then
			cnt <= cnt + 1;
			if cnt = 10 then
				new_flag <= '1';
				zdata <= x"0123456789ABCDEF";
			else
				new_flag <= '0';
				zdata <= (others => 'Z');
			end if;
		end if;
	end process;
	
	
	
	
END;
