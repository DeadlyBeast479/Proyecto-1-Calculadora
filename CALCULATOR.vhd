LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY calculator IS
    PORT (
        SW    : IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
        BTN   : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        LED   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
        SSEG0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SSEG1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SSEG2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SSEG3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY calculator;

ARCHITECTURE structural OF calculator IS

    SIGNAL btn_test_hex : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL RSum         : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL RSub         : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL RMult        : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL RS           : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Cs           : STD_LOGIC;
    SIGNAL Neg          : STD_LOGIC;
	 SIGNAL RI				: STD_LOGIC;
	 SIGNAL mayor : STD_LOGIC;
	 SIGNAL igual : STD_LOGIC;
	 SIGNAL menor : STD_LOGIC;

BEGIN

	--BOTONES 2-1-0
    BOTONES: ENTITY work.btn_ctrl
        PORT MAP (
            BTN          => BTN,
            btn_test_hex => btn_test_hex
        );
	--RESULTADOS
    RESULT: ENTITY work.RESULT
        PORT MAP (
            SW    => SW,
            RSum  => RSum,
            RSub  => RSub,
            RMult => RMult,
            Cs    => Cs,
            Neg   => Neg
        );
	--COMPARADOR
	COMPARADOR: ENTITY work.comparador
    PORT MAP (
        A     => SW(7 DOWNTO 4),
        B     => SW(3 DOWNTO 0),
        mayor => mayor,
        igual => igual,
        menor => menor
    );
	--SELECCIONADOR
    MUX: ENTITY work.sel_Mux
        PORT MAP (
            sel   => SW(9 DOWNTO 8),
            RSum  => RSum,
            RSub  => RSub,
            RMult => RMult,
            RS    => RS,
            RI    => RI
        );
	--DISPLAY LEDS/SSEG
    DISPLAY: ENTITY work.display
    PORT MAP (
        SW           => SW,
        RS           => RS,
        Cs           => Cs,
        Neg          => Neg,
        btn_test_hex => btn_test_hex,
        mayor        => mayor,
        igual        => igual,
        menor        => menor,
        SSEG0        => SSEG0,
        SSEG1        => SSEG1,
        SSEG2        => SSEG2,
        SSEG3        => SSEG3,
        LED          => LED
    );

END ARCHITECTURE structural;