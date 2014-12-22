----------------------------------------------------------------------------------
-- Company:        University of Birmingham
-- Engineer:       Christopher Hicks
-- Create Date:    16:16:11 19/12/2014
-- Design Name:    Lab 1 - 4 bit multiplier.
-- Module Name:    nx3_top - Behavioral 
-- Project Name:   lab1
-- Target Devices: xc6slx16
-- Description:    Four bit multiplier which displays 8-bit product on Nexys3 board.
-- Additional Comments: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nx3_top is
  Port ( clk      : in  STD_LOGIC; -- Clock input.
         buttons  : in  STD_LOGIC_VECTOR (4 downto 0);  -- centre, left, up, right, down
			--		  Buttons mapped as follows		--
			--		#					[00100]				--
			-- #	#	#	[01000]	[10000]	[00010]	--
			--		#					[00001]				--
			--													--
         switches : in  STD_LOGIC_VECTOR (7 downto 0);  
         leds     : out  STD_LOGIC_VECTOR (7 downto 0);
			AN3 : inout std_logic;
         AN2 : inout std_logic;
         AN1 : inout std_logic;
         AN0 : inout std_logic;
         segments : out  STD_LOGIC_VECTOR (7 downto 0));
end nx3_top;	  

architecture behavioral of nx3_top is
	component display
	PORT(
		number : in std_logic_vector(7 downto 0); 
		segments_0 : out std_logic_vector(7 downto 0);
		segments_1: out std_logic_vector(7 downto 0)
		);
	end component;
	signal counter : std_logic_vector(12 downto 0); -- Used to multiplex the display.
	signal segs0 : std_logic_vector(7 downto 0);
	signal segs1 : std_logic_vector(7 downto 0);
	signal sum : std_logic_vector(7 downto 0);
begin	
   sum <= switches(7 downto 4) * switches(3 downto 0); -- Sum is the 8-bit product.
   leds(7 downto 0) <= sum;	
   convert: display PORT MAP( number => sum,
										segments_0 => segs0,   -- Right-most display digit.
										segments_1 => segs1); -- Third display digit.
   process (clk)
   begin
		if clk'event and clk = '1' then
			if (counter = "0000000000000") then
				if (AN0='0') then 
					AN0 <= '1';	 
						segments <= segs1;
					AN1 <= '0';
				elsif (AN1='0') then -- Address the right-most display digit.
					AN1 <= '1';
					segments <= segs0;            
					AN0 <= '0';
				end if; --if (AN0='0') 
			end if; -- if (counter = "0000000000000")
      counter <= counter + "0000000000001"; -- Increment the counter.
      if (counter > "1000000000000") then   -- counter reaches 2^13.
			counter <= "0000000000000"; 		  -- Roll back round.
      end if;
    end if; -- CLK'event and CLK = '1' 
  end process;
end behavioral;