LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY btn_ctrl IS
    PORT (
        BTN          : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        btn_test_hex : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY btn_ctrl;

ARCHITECTURE behavioral OF btn_ctrl IS
    SIGNAL BTN_X : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    BTN_X <= NOT BTN;

    PROCESS(BTN_X)
    BEGIN
        IF BTN_X(2) = '1' THEN
            btn_test_hex <= "100";
        ELSIF BTN_X(1) = '1' THEN
            btn_test_hex <= "010";
        ELSIF BTN_X(0) = '1' THEN
            btn_test_hex <= "001";
        ELSE
            btn_test_hex <= "000";
        END IF;
    END PROCESS;
END ARCHITECTURE behavioral;