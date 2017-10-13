LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
ENTITY showmodel IS
PORT (p1,p2,p3,p4,p5,p6,p7,p8:IN integer RANGE 12 DOWNTO 0;--number in x6 10=- 11=blank
		clk:IN std_logic;
		flash:IN std_logic_vector(7 DOWNTO 0);
		duanout:OUT std_logic_vector(7 DOWNTO 0);
		weiout:OUT std_logic_vector(7 DOWNTO 0));
END;
ARCHITECTURE show OF showmodel IS
	SIGNAL duan:integer RANGE 12 DOWNTO 0;
	SIGNAL wei:integer RANGE 8 DOWNTO 1;
BEGIN
pro1:PROCESS (clk)
 BEGIN
  IF clk 'EVENT AND clk='1' THEN
	IF wei=8 THEN wei<=1;
	ELSE wei<=wei+1;
	END IF;
  END IF;
 END PROCESS pro1;
pro2:PROCESS (wei)
 BEGIN
	CASE wei IS
		WHEN 1=>weiout<=("11111110" OR flash);duan<=p1;
		WHEN 2=>weiout<=("11111101" OR flash);duan<=p2;
		WHEN 3=>weiout<=("11111011" OR flash);duan<=p3;
		WHEN 4=>weiout<=("11110111" OR flash);duan<=p4;
		WHEN 5=>weiout<=("11101111" OR flash);duan<=p5;
		WHEN 6=>weiout<=("11011111" OR flash);duan<=p6;
		WHEN 7=>weiout<=("10111111" OR flash);duan<=p7;
		WHEN 8=>weiout<=("01111111" OR flash);duan<=p8;
		WHEN OTHERS=>NULL;
	END CASE;
 END PROCESS pro2;
pro3:PROCESS (duan)
 BEGIN
	CASE duan IS
	 WHEN 0=>duanout<="11000000";
	 WHEN 1=>duanout<="11111001";
	 WHEN 2=>duanout<="10100100";
	 WHEN 3=>duanout<="10110000";
	 WHEN 4=>duanout<="10011001";
	 WHEN 5=>duanout<="10010010";
	 WHEN 6=>duanout<="10000010";
	 WHEN 7=>duanout<="11111000";
	 WHEN 8=>duanout<="10000000";
	 WHEN 9=>duanout<="10010000";
	 WHEN 10=>duanout<="10111111";
	 WHEN 11=>duanout<="10001000";
	 WHEN 12=>duanout<="10001100";
	 WHEN OTHERS=>duanout<="11111111";
	END CASE;
--	duanout<="10010010";
 END PROCESS pro3;
END;