LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY alarm IS
PORT(fre2in:IN std_logic;
	  fre1kin:IN std_logic;
		set,enable,stop:IN std_logic;
		switch:IN integer RANGE 4 DOWNTO 0;
		hh,hl,mh,ml,sh,sl:IN integer RANGE 9 DOWNTO 0;
		beep,music:OUT std_logic);
END;
ARCHITECTURE bing OF alarm IS
SIGNAL flag:std_logic_vector(1 DOWNTO 0);
TYPE matrix IS ARRAY(5 DOWNTO 0) OF integer RANGE 9 DOWNTO 0;
SIGNAL alarmatrixset:matrix:=(2,2,2,2,2,2);
BEGIN
	al:PROCESS(hh,hl,mh,ml,sh,sl,set,enable)
		VARIABLE sethh,sethl,setmh,setml:integer RANGE 9 DOWNTO 0;
		BEGIN
		END PROCESS al;
	bs:PROCESS(sh,sl,mh,ml,sh,sl,enable,stop,switch)
		BEGIN
			IF stop='0' THEN
				flag<="00";
			END IF;
			IF enable='1' AND sl=3 AND sh=5 AND ml=9 AND mh=5 THEN --59,53
				flag<="10";
			ELSIF enable='1' AND sl=9 AND sh=5 AND ml=9 AND mh=5 THEN--59,59
				flag<="01";
			ELSIF enable='1' AND sl=0 AND sh=0 AND ml=0 AND mh=3 THEN--30,00
				flag<="10";
			END IF;
			IF sl=1 AND sh=0 AND flag/="11" THEN
				flag<="00";
			END IF;
			IF switch=0 AND enable='1' AND hh=alarmatrixset(0) AND hl=alarmatrixset(1) AND mh=alarmatrixset(2) AND ml=alarmatrixset(3) AND sh=alarmatrixset(4) AND sl=alarmatrixset(5) THEN
			   flag<="11";
			END IF;
		END PROCESS bs;
	bee:PROCESS(fre2in,fre1kin,flag)
		BEGIN 
			IF fre1kin='1' THEN
				IF flag="01" THEN 
				beep<='0';
				END IF;
			ELSE beep<='1';
			END IF;
			IF fre2in='1' THEN
				IF flag="10" THEN 
					beep<='0';
				END IF;
			ELSE beep<='1';
			END IF;
			IF flag="11" THEN
				music<='1';
			ELSE music<='0';
			END IF;
			IF flag="00" THEN
				beep<='1';
				music<='0';
			END IF;
		END PROCESS bee;
	st:PROCESS(hh,hl,mh,ml,sh,sl,set)
		BEGIN
			IF	set='1' AND switch=3 THEN
				alarmatrixset<=(sl,sh,ml,mh,hl,hh);
			END IF;
		END PROCESS st;
END;
		
		