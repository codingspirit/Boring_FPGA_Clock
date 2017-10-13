LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY count IS
 PORT(clk0:IN std_logic;
		fre1k,fre2:OUT std_logic;
		time1s:OUT std_logic);
END;
ARCHITECTURE fre OF count IS
	 SIGNAL a,b,c:std_logic;
BEGIN
	PROCESS(clk0)
	 VARIABLE i:integer RANGE 50000 DOWNTO 0;
	 VARIABLE j:integer RANGE 1000 DOWNTO 0;
	BEGIN
		fre1k<=a;
		fre2<=b;
		time1s<=c;
		IF RISING_EDGE(clk0) THEN
			IF i=50000 THEN 
				i:=0;a<=NOT a;fre1k<=a;
				IF j=500 THEN c<=NOT c;time1s<=c;
				END IF;
				IF j=1000 THEN j:=0;c<=NOT c;time1s<=c;b<=NOT b;fre2<=b; 
				ELSE j:=j+1; 
				END IF;
			ELSE i:=i+1;
			END IF;
		END IF;
	END PROCESS;
END;