LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY fullAdder IS
    PORT (
        A    : IN  STD_LOGIC;
        B    : IN  STD_LOGIC;
        Cin  : IN  STD_LOGIC;
        S    : OUT STD_LOGIC;
        Cout : OUT STD_LOGIC);
END ENTITY fullAdder;

ARCHITECTURE gateLevel OF fullAdder IS
BEGIN
    S    <= A XOR B XOR Cin;
    Cout <= (A AND B) OR (Cin AND (A XOR B));
END ARCHITECTURE gateLevel;