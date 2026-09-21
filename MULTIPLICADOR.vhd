LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY multiplicador IS
    PORT (
        A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        P : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY multiplicador;

ARCHITECTURE structural OF multiplicador IS

    SIGNAL PP : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL C1, C2, C3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S1, S2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    -- Productos parciales
    PP(0) <= A(0) AND B(0);
    PP(1) <= A(1) AND B(0);
    PP(2) <= A(2) AND B(0);
    PP(3) <= A(3) AND B(0);

    PP(4) <= A(0) AND B(1);
    PP(5) <= A(1) AND B(1);
    PP(6) <= A(2) AND B(1);
    PP(7) <= A(3) AND B(1);

    PP(8)  <= A(0) AND B(2);
    PP(9)  <= A(1) AND B(2);
    PP(10) <= A(2) AND B(2);
    PP(11) <= A(3) AND B(2);

    PP(12) <= A(0) AND B(3);
    PP(13) <= A(1) AND B(3);
    PP(14) <= A(2) AND B(3);
    PP(15) <= A(3) AND B(3);

    P(0) <= PP(0);

    -- Primera suma
    FA1: ENTITY work.fullAdder
        PORT MAP(PP(1), PP(4), '0', P(1), C1(0));

    FA2: ENTITY work.fullAdder
        PORT MAP(PP(2), PP(5), C1(0), S1(1), C1(1));

    FA3: ENTITY work.fullAdder
        PORT MAP(PP(3), PP(6), C1(1), S1(2), C1(2));

    FA4: ENTITY work.fullAdder
        PORT MAP('0', PP(7), C1(2), S1(3), C1(3));

    -- Segunda suma
    FA5: ENTITY work.fullAdder
        PORT MAP(S1(1), PP(8), '0', P(2), C2(0));

    FA6: ENTITY work.fullAdder
        PORT MAP(S1(2), PP(9), C2(0), S2(1), C2(1));

    FA7: ENTITY work.fullAdder
        PORT MAP(S1(3), PP(10), C2(1), S2(2), C2(2));

    FA8: ENTITY work.fullAdder
        PORT MAP(C1(3), PP(11), C2(2), S2(3), C2(3));

    -- Tercera suma
    FA9: ENTITY work.fullAdder
        PORT MAP(S2(1), PP(12), '0', P(3), C3(0));

    FA10: ENTITY work.fullAdder
        PORT MAP(S2(2), PP(13), C3(0), P(4), C3(1));

    FA11: ENTITY work.fullAdder
        PORT MAP(S2(3), PP(14), C3(1), P(5), C3(2));

    FA12: ENTITY work.fullAdder
        PORT MAP(C2(3), PP(15), C3(2), P(6), P(7));

END structural;