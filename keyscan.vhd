LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY keyscan IS
PORT(k1,k2,k3,k4,k5,clk:IN std_logic;
		out1:OUT integer RANGE 4 DOWNTO 0;
		out2,out3,out4,out5:OUT std_logic);--k1 0 time 1 date 
END;
ARCHITECTURE scan OF keyscan IS
	SIGNAL state2,state3,state4,state5,state6:std_logic;-- 1 hold --0 release
	SIGNAL a,b:std_logic;
BEGIN
PROCESS(k1,k2,k3,k4,k5)
	VARIABLE keys:integer RANGE 0 TO 100000;
	VARIABLE state1:integer RANGE 4 DOWNTO 0:=0;
	BEGIN
			out2<=a;
			out5<=b;
			IF RISING_EDGE(clk) THEN
				IF(k1='0')then
					IF(keys=100000 AND k1='0')THEN
					 state2<='1';
					 keys:=0;
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				IF(state2='1' and k1='1')THEN
					IF(keys=100000 and k1='1')THEN
					 state2<='0';
					 keys:=0;
					 IF state1=4 THEN state1:=0;
					 ELSE state1:=state1+1;
					 END IF;
					 out1<=state1;
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				
				IF(k2='0')then
					IF(keys=100000 AND k2='0')THEN
					 state3<='1';
					 keys:=0;
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				IF(state3='1' and k2='1')THEN
					IF(keys=100000 and k2='1')THEN
					 state3<='0';
					 keys:=0;
					 a<=NOT a;
					 out2<=a;
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				
				IF(k3='0')then
					IF(keys=100000 AND k3='0')THEN
					 state4<='1';
					 keys:=0;
					 out3<='1';
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				IF(state4='1' and k3='1')THEN
					IF(keys=100000 and k3='1')THEN
					 state4<='0';
					 keys:=0;
					 out3<='0';
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				
				IF(k4='0')then
					IF(keys=100000 AND k4='0')THEN
					 state5<='1';
					 keys:=0;
					 out4<='1';
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				IF(state5='1' and k4='1')THEN
					IF(keys=100000 and k4='1')THEN
					 state5<='0';
					 keys:=0;
					 out4<='0';
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				
				IF(k5='0')then
					IF(keys=100000 AND k5='0')THEN
					 state6<='1';
					 keys:=0;
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
				IF(state6='1' and k5='1')THEN
					IF(keys=100000 and k5='1')THEN
					 state6<='0';
					 keys:=0;
					 b<=NOT b;
					 out5<=b;
					ELSE
					 keys:=keys+1;
					END IF;
				END IF;
			END IF;
	END PROCESS;
END;