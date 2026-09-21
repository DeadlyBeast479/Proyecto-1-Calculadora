LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY adderSubstractor IS
	 GENERIC (N    : INTEGER := 4);
	
    PORT ( 	A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				Cin  : IN  STD_LOGIC;
				S    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				Cout : OUT STD_LOGIC);
END ENTITY adderSubstractor;

ARCHITECTURE structure OF adderSubstractor IS

	SIGNAL C 	: STD_LOGIC_VECTOR(N DOWNTO 0);
	SIGNAL NB	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);

BEGIN
	C(0) <= Cin;

    SUMB_BITS: FOR i IN 0 TO N-1 GENERATE
	 
		  NB(i)<= B(i) XOR Cin;
	 
        fullAdd: ENTITY work.fullAdder
            PORT MAP(
                A    => A(i),
                B    => NB(i),
                Cin  => C(i),
                S    => S(i),
                Cout => C(i+1)
            );
    END GENERATE SUMB_BITS;

    Cout <= C(N);
						 
END ARCHITECTURE structure;