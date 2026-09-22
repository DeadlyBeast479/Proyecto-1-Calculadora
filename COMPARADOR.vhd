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

    mayor <= '1' WHEN A > B ELSE '0';
    igual <= '1' WHEN A = B ELSE '0';
    menor <= '1' WHEN A < B ELSE '0';

END ARCHITECTURE behavioral;
