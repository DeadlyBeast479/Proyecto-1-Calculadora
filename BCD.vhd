LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY BCD IS
    PORT(
        bin      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        decenas  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        unidades : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END BCD;

ARCHITECTURE behavioral OF BCD IS

    SIGNAL bcd_result : STD_LOGIC_VECTOR(15 DOWNTO 0);

    FUNCTION ADD3(x : STD_LOGIC_VECTOR(3 DOWNTO 0))
    RETURN STD_LOGIC_VECTOR IS
    BEGIN
        CASE x IS
            WHEN "0101" => RETURN "1000";
            WHEN "0110" => RETURN "1001";
            WHEN "0111" => RETURN "1010";
            WHEN "1000" => RETURN "1011";
            WHEN "1001" => RETURN "1100";
            WHEN OTHERS => RETURN x;
        END CASE;
    END FUNCTION;

    FUNCTION BIN2BCD(x : STD_LOGIC_VECTOR(7 DOWNTO 0))
    RETURN STD_LOGIC_VECTOR IS

        VARIABLE bcd : STD_LOGIC_VECTOR(15 DOWNTO 0);

    BEGIN

        bcd := "00000000" & x;

        FOR i IN 0 TO 7 LOOP

            IF bcd(15 DOWNTO 12) = "0101" OR
               bcd(15 DOWNTO 12) = "0110" OR
               bcd(15 DOWNTO 12) = "0111" OR
               bcd(15 DOWNTO 12) = "1000" OR
               bcd(15 DOWNTO 12) = "1001" THEN

                bcd(15 DOWNTO 12) := ADD3(bcd(15 DOWNTO 12));

            END IF;

            IF bcd(11 DOWNTO 8) = "0101" OR
               bcd(11 DOWNTO 8) = "0110" OR
               bcd(11 DOWNTO 8) = "0111" OR
               bcd(11 DOWNTO 8) = "1000" OR
               bcd(11 DOWNTO 8) = "1001" THEN

                bcd(11 DOWNTO 8) := ADD3(bcd(11 DOWNTO 8));

            END IF;

            bcd := bcd(14 DOWNTO 0) & '0';

        END LOOP;

        RETURN bcd;

    END FUNCTION;

BEGIN

    bcd_result <= BIN2BCD(bin);

    decenas  <= bcd_result(15 DOWNTO 12);
    unidades <= bcd_result(11 DOWNTO 8);

END ARCHITECTURE behavioral;
