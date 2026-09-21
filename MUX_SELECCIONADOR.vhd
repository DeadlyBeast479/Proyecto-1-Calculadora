LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY sel_Mux IS
    PORT (
        sel    : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        RSum   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        RSub   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        RMult  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        
        RS 		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		  RI     : OUT STD_LOGIC
    );
END ENTITY sel_Mux;

ARCHITECTURE structural OF sel_Mux IS
BEGIN

    WITH sel SELECT
        RS <= RSum  WHEN "00",
              RSub  WHEN "01",
              RMult WHEN "10",
              "00000000" WHEN "11";
				  
		  RI <= '1' WHEN sel = "11" ELSE '0';

END ARCHITECTURE structural;