LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY comparador IS
    PORT (
        A     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        mayor : OUT STD_LOGIC;
        igual : OUT STD_LOGIC;
        menor : OUT STD_LOGIC
    );
END ENTITY comparador;

ARCHITECTURE behavioral OF comparador IS
BEGIN

    PROCESS(A, B)
    BEGIN
        IF A > B THEN
            mayor <= '1';
            igual <= '0';
            menor <= '0';

        ELSIF A = B THEN
            mayor <= '0';
            igual <= '1';
            menor <= '0';

        ELSE
            mayor <= '0';
            igual <= '0';
            menor <= '1';
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;