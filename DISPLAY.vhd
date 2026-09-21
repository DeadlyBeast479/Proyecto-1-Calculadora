LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY display IS 
    PORT ( 
        SW           : IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
        RS           : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        Cs           : IN  STD_LOGIC;
        Neg          : IN  STD_LOGIC;
        btn_test_hex : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		  mayor 			: IN  STD_LOGIC;
		  igual 			: IN  STD_LOGIC;
		  menor 			: IN  STD_LOGIC;
        SSEG0        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SSEG1        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SSEG2        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SSEG3        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        LED          : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END ENTITY display;

ARCHITECTURE behavioral OF display IS

    SIGNAL A          : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B          : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sub        : STD_LOGIC;
    SIGNAL err_A      : STD_LOGIC;
    SIGNAL err_B      : STD_LOGIC;
    SIGNAL err_global : STD_LOGIC;
    SIGNAL err_sub    : STD_LOGIC;
    SIGNAL decenas    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL unidades   : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL hex_result : STD_LOGIC;
    SIGNAL D1         : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D0         : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL SEG1       : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL SEG0       : STD_LOGIC_VECTOR(7 DOWNTO 0);
	 
	 SIGNAL NUMY		 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	 SIGNAL SSEGM 		 : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    A <= SW(7 DOWNTO 4);
    B <= SW(3 DOWNTO 0);
	 
	 NUMY <= A WHEN mayor = '1' OR igual = '1' ELSE B;
	 
    sub <= '1' WHEN SW(9 DOWNTO 8) = "01" ELSE '0';

	--ERRORES Y RANGOS
    err_A <= '1' WHEN (A > "1001" AND btn_test_hex(0) = '0') ELSE '0';
    err_B <= '1' WHEN (B > "1001" AND btn_test_hex(0) = '0') ELSE '0';
	 
    err_sub <= '1' WHEN (sub = '1' AND Neg = '1' AND RS > "00001001") ELSE '0';

    err_global <= '1' WHEN (SW(9 DOWNTO 8) = "11") OR 
                           (err_A = '1') OR 
                           (err_B = '1') OR 
                           (err_sub = '1') ELSE '0';
	--DISPLAY RESULTADO
    BCD: ENTITY work.BCD
        PORT MAP (
            bin      => RS,
            decenas  => decenas,
            unidades => unidades
        );

    hex_result <= '1' WHEN RS > "01100011" ELSE '0';

    D1 <= RS(7 DOWNTO 4) WHEN hex_result = '1' ELSE decenas;
    D0 <= RS(3 DOWNTO 0) WHEN hex_result = '1' ELSE unidades;

    DECODER1: ENTITY work.decoderSSEG
        PORT MAP (
            x => D1,
            y => SEG1
        );

    DECODER0: ENTITY work.decoderSSEG
        PORT MAP (
            x => D0,
            y => SEG0
        );
		  
	 DECODER_COMPA: ENTITY work.decoderSSEG
    PORT MAP (
        x => NUMY,
        y => SSEGM
    );

	--LEDS
	 LED(0) <= '0' WHEN btn_test_hex(2) = '1' ELSE
          '0' WHEN err_global = '1' ELSE
          menor WHEN btn_test_hex(1) = '1' ELSE
          RS(0);
	 
	 LED(1) <= '0' WHEN btn_test_hex(2) = '1' ELSE
          '0' WHEN err_global = '1' ELSE
          igual WHEN btn_test_hex(1) = '1' ELSE
          RS(1);
	 
	 LED(2) <= '0' WHEN btn_test_hex(2) = '1' ELSE
          '0' WHEN err_global = '1' ELSE
          mayor WHEN btn_test_hex(1) = '1' ELSE
          RS(2); 
	
    LED(3) <= '0' WHEN btn_test_hex(2) = '1' ELSE
          '0' WHEN err_global = '1' ELSE
          RS(3) WHEN btn_test_hex(1) = '0' ELSE
          '0';

    LED(4) <= '0'   WHEN btn_test_hex(2) = '1' ELSE
              '0'   WHEN err_global = '1'     ELSE
				  '0'   WHEN btn_test_hex(1)  ='1' ELSE
              RS(4) WHEN (SW(9 DOWNTO 8) = "10") ELSE
              Cs    WHEN (SW(9 DOWNTO 8) = "00") ELSE
              '0';          

    LED(7 DOWNTO 5) <= "000" WHEN btn_test_hex(2) = '1' ELSE
							  "000" WHEN btn_test_hex(1) = '1' ELSE
                       "000" WHEN err_global = '1'     ELSE 
                       RS(7 DOWNTO 5);

    LED(8) <= '0' WHEN btn_test_hex(2) = '1' ELSE
				  '0' WHEN btn_test_hex(1) = '1' ELSE
              '0' WHEN err_global = '1'     ELSE 
              Neg WHEN SW(9 DOWNTO 8) = "01" ELSE 
              '0';

    LED(9) <= '0' WHEN btn_test_hex(2) = '1' ELSE err_global;

	-- SALIDA BCD/HEX
    SSEG1 <= "00000000" WHEN btn_test_hex(2) = '1' ELSE
         "10000110" 		WHEN err_global = '1' ELSE
         SSEGM	     		WHEN btn_test_hex(1) = '1' ELSE
         "10111111" 		WHEN (sub = '1' AND Neg = '1') ELSE
         SEG1;

    SSEG0 <= "00000000" WHEN btn_test_hex(2) = '1' ELSE
         "10000110" 		WHEN err_global = '1'     ELSE
         "11111111" 		WHEN btn_test_hex(1) = '1' ELSE
         SEG0;

	--ENTRADAS
    SSEG3 <= "00000000" WHEN btn_test_hex(2) = '1'   ELSE 
             "10000110" WHEN SW(9 DOWNTO 8) = "11"   ELSE 
             "10000110" WHEN err_A = '1'             ELSE 
             "11000000" WHEN A = "0000" ELSE
             "11111001" WHEN A = "0001" ELSE
             "10100100" WHEN A = "0010" ELSE
             "10110000" WHEN A = "0011" ELSE
             "10011001" WHEN A = "0100" ELSE
             "10010010" WHEN A = "0101" ELSE
             "10000010" WHEN A = "0110" ELSE
             "11111000" WHEN A = "0111" ELSE
             "10000000" WHEN A = "1000" ELSE
             "10010000" WHEN A = "1001" ELSE
             "10001000" WHEN A = "1010" ELSE
             "10000011" WHEN A = "1011" ELSE
             "11000110" WHEN A = "1100" ELSE
             "10100001" WHEN A = "1101" ELSE
             "10000110" WHEN A = "1110" ELSE
             "10001110" WHEN A = "1111" ELSE
             "10000110";

    SSEG2 <= "00000000" WHEN btn_test_hex(2) = '1'   ELSE 
             "10000110" WHEN SW(9 DOWNTO 8) = "11"   ELSE 
             "10000110" WHEN err_B = '1'             ELSE 
             "11000000" WHEN B = "0000" ELSE
             "11111001" WHEN B = "0001" ELSE
             "10100100" WHEN B = "0010" ELSE
             "10110000" WHEN B = "0011" ELSE
             "10011001" WHEN B = "0100" ELSE
             "10010010" WHEN B = "0101" ELSE
             "10000010" WHEN B = "0110" ELSE
             "11111000" WHEN B = "0111" ELSE
             "10000000" WHEN B = "1000" ELSE
             "10010000" WHEN B = "1001" ELSE
             "10001000" WHEN B = "1010" ELSE
             "10000011" WHEN B = "1011" ELSE
             "11000110" WHEN B = "1100" ELSE
             "10100001" WHEN B = "1101" ELSE
             "10000110" WHEN B = "1110" ELSE
             "10001110" WHEN B = "1111" ELSE
             "10000110";

END behavioral;