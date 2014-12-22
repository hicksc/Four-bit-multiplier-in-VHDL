----------------------------------------------------------------------------------
-- Company: University of Birmingham
-- Engineer: Christopher Hicks
-- 
-- Create Date:    12:07:43 10/16/2014 
-- Design Name: 	 Lab 1 display
-- Module Name:    display - behavioral 
-- Project Name: 
-- Target Devices: xc6slx16
-- Tool versions: 
-- Description: This component converts an 8 bit input to the corresponding display
--					 segments for a seven segment display unit.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
	port( number : in STD_LOGIC_VECTOR(7 downto 0);
		   segments_0 : out STD_LOGIC_VECTOR(7 downto 0); -- This contains the signal to be displayed.
			segments_1 : out std_logic_vector(7 downto 0) );
end display;

architecture behavioral of display is
	--HEX-to-seven-segment decoder
	-- 
	-- segment encoding
	--      0
	--     ---  
	--  5 |   | 1
	--     ---   <- 6
	--  4 |   | 2
	--     ---
	--      3  		
begin 
	segments_0(7) <= '1';
	segments_1(7) <= '1';
	
	with number(3 downto 0) select -- Calculate digit zero display segments.
	segments_0(6 downto 0) <= "1111001" when "0001",   --1
									  "0100100" when "0010",   --2
									  "0110000" when "0011",   --3
								  	  "0011001" when "0100",   --4
									  "0010010" when "0101",   --5
									  "0000010" when "0110",   --6
									  "1111000" when "0111",   --7
									  "0000000" when "1000",   --8
									  "0010000" when "1001",   --9
									  "0001000" when "1010",   --A
									  "0000011" when "1011",   --b
									  "1000110" when "1100",   --C
									  "0100001" when "1101",   --d
									  "0000110" when "1110",   --E
									  "0001110" when "1111",   --F
									  "1000000" when others;   --0
									  
	with number(7 downto 4) select -- Calculate digit one display segments.
	segments_1(6 downto 0) <= "1111001" when "0001",   --1
									  "0100100" when "0010",   --2
									  "0110000" when "0011",   --3
									  "0011001" when "0100",   --4
									  "0010010" when "0101",   --5
									  "0000010" when "0110",   --6
									  "1111000" when "0111",   --7
									  "0000000" when "1000",   --8
									  "0010000" when "1001",   --9
									  "0001000" when "1010",   --A
									  "0000011" when "1011",   --b
									  "1000110" when "1100",   --C
									  "0100001" when "1101",   --d
									  "0000110" when "1110",   --E
									  "0001110" when "1111",   --F
									  "1000000" when others;   --0
end behavioral;