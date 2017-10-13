LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY centertime IS
 PORT(in1s,up,shift,set,in1k,start:IN std_logic;
		switch:IN integer RANGE 4 DOWNTO 0;-- 0->time 1->date 2->week,aM pM 3->alarm
		h1,l1,h2,l2,h3,l3,mid1,mid2:OUT integer RANGE 12 DOWNTO 0;
		flash:OUT std_logic_vector(7 DOWNTO 0));
END;
ARCHITECTURE timeout OF centertime IS
	SIGNAL sect,temp:integer RANGE 5 DOWNTO 0;
	TYPE matrix IS ARRAY(5 DOWNTO 0) OF integer RANGE 9 DOWNTO 0;
	SIGNAL timematrixset:matrix:=(0,5,9,5,0,0);
	SIGNAL timematrix:matrix:=(0,5,9,5,0,0);
	SIGNAL timer:matrix:=(0,0,0,0,0,0);
	SIGNAL datematrixset:matrix:=(9,2,2,1,5,1);
	SIGNAL datematrix:matrix:=(0,1,9,0,5,1);
	SIGNAL alarmatrixset:matrix:=(2,2,2,2,2,2);
	SIGNAL weekmatrix:matrix:=(2,2,2,2,2,1);--1 am 2 pm
	SIGNAL weekset:integer RANGE 7 DOWNTO 1;
	shared VARIABLE setstate1,setstate2:std_logic;
BEGIN
p0:PROCESS(set)
 BEGIN
	IF RISING_EDGE(set) THEN
		setstate1:='1';
	END IF;
	IF FALLING_EDGE(set) THEN
		setstate2:='1';
	END IF;
	IF setstate2='1' THEN
		setstate1:='0';
		setstate2:='0';
	END IF;
END PROCESS p0;
p1:PROCESS(in1s)
--	VARIABLE yh:integer RANGE 9 DOWNTO 0;
--	VARIABLE yl:integer RANGE 9 DOWNTO 0;
--	VARIABLE timematrix(2):integer RANGE 9 DOWNTO 0;
--	VARIABLE timematrix(3):integer RANGE 9 DOWNTO 0;
--	VARIABLE dh:integer RANGE 9 DOWNTO 0;
--	VARIABLE dl:integer RANGE 9 DOWNTO 0;
 BEGIN
	IF RISING_EDGE(in1s) THEN
		IF setstate1/='1' THEN
			IF timematrix(5)=9 THEN timematrix(5)<=0;
				IF timematrix(4)=5 THEN timematrix(4)<=0;
					IF timematrix(3)=9 THEN timematrix(3)<=0;
						IF timematrix(2)=5 THEN timematrix(2)<=0;
							IF timematrix(1)=4 THEN timematrix(1)<=0;
								IF timematrix(0)=2 THEN timematrix(0)<=0;
									IF datematrix(5)=9 THEN datematrix(5)<=0;
										IF weekmatrix(5)=7 THEN weekmatrix(5)<=1;
										ELSE weekmatrix(5)<=weekmatrix(5)+1;
										END IF;
										IF datematrix(4)=3 THEN datematrix(4)<=0;
											IF datematrix(3)=2 THEN datematrix(3)<=0;
												IF datematrix(2)=1 THEN datematrix(2)<=0;
													IF datematrix(1)=9 THEN datematrix(1)<=0;
														IF datematrix(0)=9 THEN datematrix(0)<=0;
														ELSE datematrix(0)<=datematrix(0)+1;
														END IF;
													ELSE datematrix(1)<=datematrix(1)+1;
													END IF;
												ELSE datematrix(2)<=datematrix(2)+1;
												END IF;
											ELSE datematrix(3)<=datematrix(3)+1;
											END IF;
										ELSE datematrix(4)<=datematrix(4)+1;
										END IF;
									ELSE datematrix(5)<=datematrix(5)+1;
									END IF;
								ELSE timematrix(0)<=timematrix(0)+1;
								END IF;
							ELSE timematrix(1)<=timematrix(1)+1;
							END IF;
						ELSE timematrix(2)<=timematrix(2)+1;
						END IF;
					ELSE timematrix(3)<=timematrix(3)+1;
					END IF;
				ELSE timematrix(4)<=timematrix(4)+1;
				END IF;
			ELSE timematrix(5)<=timematrix(5)+1;
			END IF;
		END IF;
	END IF;
	IF setstate1='1' AND switch=0 THEN
		FOR i IN 5 DOWNTO 0 LOOP
		timematrix(i)<=timematrixset(i);
		END LOOP;
	END IF;
	IF setstate1='1' AND switch=1 THEN
	FOR i IN 5 DOWNTO 0 LOOP
	datematrix(i)<=datematrixset(i);
	END LOOP;
	END IF;
	IF setstate1='1' AND switch=2 THEN
		weekmatrix(5)<=weekset;
	END IF;
	IF (timematrix(1)+timematrix(0)*10)>12 THEN weekmatrix(4)<=(timematrix(0)-1);weekmatrix(3)<=(timematrix(1)-2);weekmatrix(0)<=2;
	ELSE weekmatrix(4)<=timematrix(0);weekmatrix(3)<=timematrix(1);weekmatrix(0)<=1;
	END IF;
	weekmatrix(2)<=timematrix(2);
	weekmatrix(1)<=timematrix(3);
END PROCESS p1;
 p2:PROCESS(shift,in1s)
	BEGIN
	IF RISING_EDGE(shift) THEN
		IF setstate1='1' THEN
			IF temp=5 THEN temp<=0;
			ELSE temp<=temp+1;
			END IF;
			sect<=temp;
		END IF;
	END IF;
	END PROCESS p2;
 P3:PROCESS(up)
	BEGIN
	IF RISING_EDGE(up) THEN
		IF setstate1='1' AND switch=0 THEN
			CASE sect IS
			WHEN 0=>IF timematrixset(0)=2 THEN timematrixset(0)<=0;
						ELSE timematrixset(0)<=timematrixset(0)+1;
						END IF;
			WHEN 1=>IF timematrixset(1)=4 THEN timematrixset(1)<=0;
						ELSE timematrixset(1)<=timematrixset(1)+1;
						END IF;
			WHEN 2=>IF timematrixset(2)=5 THEN timematrixset(2)<=0;
						ELSE timematrixset(2)<=timematrixset(2)+1;
						END IF;
			WHEN 3=>IF timematrixset(3)=9 THEN timematrixset(3)<=0;
						ELSE timematrixset(3)<=timematrixset(3)+1;
						END IF;
			WHEN 4=>IF timematrixset(4)=5 THEN timematrixset(4)<=0;
						ELSE timematrixset(4)<=timematrixset(4)+1;
						END IF;	
			WHEN 5=>IF timematrixset(5)=9 THEN timematrixset(5)<=0;
						ELSE timematrixset(5)<=timematrixset(5)+1;
						END IF;		
			END CASE;
		END IF;
		IF setstate1='1' AND switch=1 THEN
			CASE sect IS
			WHEN 0=>IF datematrixset(0)=9 THEN datematrixset(0)<=0;
						ELSE datematrixset(0)<=datematrixset(0)+1;
						END IF;
			WHEN 1=>IF datematrixset(1)=9 THEN datematrixset(1)<=0;
						ELSE datematrixset(1)<=datematrixset(1)+1;
						END IF;
			WHEN 2=>IF datematrixset(2)=1 THEN datematrixset(2)<=0;
						ELSE datematrixset(2)<=datematrixset(2)+1;
						END IF;
			WHEN 3=>IF datematrixset(3)=2 THEN datematrixset(3)<=0;
						ELSE datematrixset(3)<=datematrixset(3)+1;
						END IF;
			WHEN 4=>IF datematrixset(4)=3 THEN datematrixset(4)<=0;
						ELSE datematrixset(4)<=datematrixset(4)+1;
						END IF;	
			WHEN 5=>IF datematrixset(5)=9 THEN datematrixset(5)<=0;
						ELSE datematrixset(5)<=datematrixset(5)+1;
						END IF;		
			END CASE;
		END IF;
		IF setstate1='1' AND switch=3 THEN
			CASE sect IS
			WHEN 0=>IF alarmatrixset(0)=2 THEN alarmatrixset(0)<=0;
						ELSE alarmatrixset(0)<=alarmatrixset(0)+1;
						END IF;
			WHEN 1=>IF alarmatrixset(1)=4 THEN alarmatrixset(1)<=0;
						ELSE alarmatrixset(1)<=alarmatrixset(1)+1;
						END IF;
			WHEN 2=>IF alarmatrixset(2)=5 THEN alarmatrixset(2)<=0;
						ELSE alarmatrixset(2)<=alarmatrixset(2)+1;
						END IF;
			WHEN 3=>IF alarmatrixset(3)=9 THEN alarmatrixset(3)<=0;
						ELSE alarmatrixset(3)<=alarmatrixset(3)+1;
						END IF;
			WHEN 4=>IF alarmatrixset(4)=5 THEN alarmatrixset(4)<=0;
						ELSE alarmatrixset(4)<=alarmatrixset(4)+1;
						END IF;	
			WHEN 5=>IF alarmatrixset(5)=9 THEN alarmatrixset(5)<=0;
						ELSE alarmatrixset(5)<=alarmatrixset(5)+1;
						END IF;		
			END CASE;
		END IF;
		IF setstate1='1' AND switch=2 THEN
			CASE sect IS
				WHEN 0=>IF weekset=7 THEN weekset<=1;
							ELSE weekset<=weekset+1;
							END IF;
				WHEN OTHERS=>weekset<=weekset;
			END CASE;
		END IF;
	END IF;
	END PROCESS p3;
p4:PROCESS(sect,in1s)
	BEGIN
	IF in1s='1' THEN
		IF setstate1='1' THEN
			CASE sect IS
				WHEN 0=>flash<="00000001";
				WHEN 1=>flash<="00000010";
				WHEN 2=>flash<="00001000";
				WHEN 3=>flash<="00010000";
				WHEN 4=>flash<="01000000";
				WHEN 5=>flash<="10000000";
				WHEN OTHERS=>flash<="00000000";
			END CASE;
		ELSE flash<="00000000";
		END IF;
	ELSE flash<="00000000";
	END IF;
	END PROCESS p4;
p5:PROCESS(in1k,start)
	BEGIN
	IF RISING_EDGE(in1k) THEN
		IF start='1' AND switch=4 THEN
			IF timer(5)=9 THEN timer(5)<=0;--1ms
				IF timer(4)=9 THEN timer(4)<=0;--10ms
					IF timer(3)=9 THEN timer(3)<=0;--0.1s
						IF timer(2)=9 THEN timer(2)<=0;--1s
							IF timer(1)=5 THEN timer(1)<=0;--10s
								IF timer(0)=9 THEN timer(0)<=0;--1min
								ELSE timer(0)<=timer(0)+1;
								END IF;
							ELSE timer(1)<=timer(1)+1;
							END IF;
						ELSE timer(2)<=timer(2)+1;
						END IF;
					ELSE timer(3)<=timer(3)+1;
					END IF;
				ELSE timer(4)<=timer(4)+1;
				END IF;
			ELSE timer(5)<=timer(5)+1;
			END IF;
		END IF;
	END IF;
	IF up='1' THEN
			FOR i IN 5 DOWNTO 0 LOOP
			timer(i)<=0;
			END LOOP;
	END IF;
	END PROCESS p5;
p6:PROCESS(in1k,switch)
	BEGIN
	IF RISING_EDGE(in1k) THEN
		IF switch=0 THEN
			h1<=timematrix(0);
			l1<=timematrix(1);
			h2<=timematrix(2);
			l2<=timematrix(3);
			h3<=timematrix(4);
			l3<=timematrix(5);
			mid1<=10;
			mid2<=10;
		ELSIF switch=1 THEN
			h1<=datematrix(0);
			l1<=datematrix(1);
			h2<=datematrix(2);
			l2<=datematrix(3);
			h3<=datematrix(4);
			l3<=datematrix(5);
			mid1<=10;
			mid2<=10;
		ELSIF switch=3 THEN
			h1<=alarmatrixset(0);
			l1<=alarmatrixset(1);
			h2<=alarmatrixset(2);
			l2<=alarmatrixset(3);
			h3<=alarmatrixset(4);
			l3<=alarmatrixset(5);
			mid1<=10;
			mid2<=10;
		ELSIF switch=2 THEN
			h1<=weekmatrix(5);
			l1<=10;
			mid1<=weekmatrix(4);
			h2<=weekmatrix(3);
			l2<=10;
			mid2<=weekmatrix(2);
			h3<=weekmatrix(1);
			l3<=weekmatrix(0)+10;			
		ELSIF switch=4 THEN
			h1<=timer(0);
			l1<=10;
			mid1<=timer(1);
			h2<=timer(2);
			l2<=10;
			mid2<=timer(3);
			h3<=timer(4);
			l3<=timer(5);
		END IF;
	END IF;
	END PROCESS p6;
END;