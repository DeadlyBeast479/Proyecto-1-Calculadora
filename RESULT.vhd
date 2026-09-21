LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY RESULT IS
    PORT (
        SW    : IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
        RSum  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        RSub  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        RMult : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Cs    : OUT STD_LOGIC;
        Neg   : OUT STD_LOGIC
    );
END ENTITY RESULT;

ARCHITECTURE structural OF RESULT IS

    SIGNAL Cout_int : STD_LOGIC;
    SIGNAL Sog      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Snew     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL P        : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	-- SUMA/RESTA
    RTASUM_SUB: ENTITY work.adderSubstractor
        GENERIC MAP ( N => 4 )
        PORT MAP (
            A    => SW(7 DOWNTO 4),
            B    => SW(3 DOWNTO 0),
            Cin  => SW(8),   
            S    => Sog,
            Cout => Cout_int        
        );
	--RESTA CAMBIO
    Snew <= "0001" WHEN Sog = "1111" ELSE 
            "0010" WHEN Sog = "1110" ELSE 
            "0011" WHEN Sog = "1101" ELSE 
            "0100" WHEN Sog = "1100" ELSE
            "0101" WHEN Sog = "1011" ELSE
            "0110" WHEN Sog = "1010" ELSE
            "0111" WHEN Sog = "1001" ELSE
            "1000" WHEN Sog = "1000" ELSE
            Sog;
	--MULTIPLICACION
    RTA_MULT: ENTITY work.multiplicador
        PORT MAP (
            A => SW(7 DOWNTO 4),
            B => SW(3 DOWNTO 0),
            P => P
        );

    RMult <= P;
    RSum  <= "000" & Cout_int & Sog;
    
    Neg   <= (NOT Cout_int) WHEN SW(9 DOWNTO 8) = "01" ELSE '0';
    RSub  <= "0000" & Snew WHEN (NOT Cout_int = '1' AND SW(9 DOWNTO 8) = "01") ELSE ("0000" & Sog);
    Cs    <= Cout_int;

END ARCHITECTURE structural;