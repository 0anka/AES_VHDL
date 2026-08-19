-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
-- ADD_ROUND KEY 0 0 0 0
--[s0c, s1c, s2c, s3c] = [s0c, s1c, s2c, s3c] ⊕ [w(4∗round+c)] for 0 ≤ c < 4
-- MATHEMATICAL IMPLEMENTATION ADDEd
--  Copyright (C) 2026 Malefax
library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
package ADD_ROUND_KEY is
        type S_IND is range 15 downto 0;
        type W_IND is range 3 downto 0;
        subtype AES_128 is std_logic_vector(127 downto 0 );
        subtype \8bit\ is std_logic_vector ( 7 downto 0 );
        subtype \32bit\ is std_logic_vector (31 downto 0);
        type STATE is array ( S_IND range <> ) of \8bit\;
        type WORD is array ( W_IND range <> ) of \32bit\;
        function add_round_key(\STATE\:STATE(15 downto 0);\WORD\:WORD(3 downto 0)) return state;
end package ADD_ROUND_KEY;
package body ADD_ROUND_KEY is
        function add_round_key(\STATE\:STATE(15 downto 0);\WORD\:WORD(3 downto 0)) return state is
                variable state:STATE(15 downto 0) := \STATE\;
                variable newstate:STATE(15 downto 0);
                variable new_word:WORD(3 downto 0);
        begin
                new_word(0) := (STATE(15) & STATE(14) & STATE(13) & STATE(12)) xor \word\(3);
                new_word(1) := (STATE(11) & STATE(10) & STATE(9) & STATE(8)) xor \word\(2);
                new_word(2) := (STATE(7) & STATE(6) & STATE(5) & STATE(4)) xor \word\(1);
                new_word(3) := (STATE(3) & STATE(2) & STATE(1) & STATE(0)) xor \word\(0);

                new_state(15) := new_word(0)(31 downto 24);
                new_state(14) := new_word(0)(23 downto 16 );
                new_state(13) := new_word(0)(15 downto 8 );
                new_state(12) := new_word(0)(7 downto 0);

                new_state(11) := new_word(1)(31 downto 24);
                new_state(10) := new_word(1)(23 downto 16 );
                new_state(9) := new_word(1)(15 downto 8 );
                new_state(8) := new_word(1)(7 downto 0);
             
                new_state(7) := new_word(2)(31 downto 24);
                new_state(6) := new_word(2)(23 downto 16 );
                new_state(5) := new_word(2)(15 downto 8 );
                new_state(4) := new_word(2)(7 downto 0);

                new_state(3) := new_word(3)(31 downto 24);
                new_state(2) := new_word(3)(23 downto 16 );
                new_state(1) := new_word(3)(15 downto 8 );
                new_state(0) := new_word(3)(7 downto 0);
                
                return new_state;
        end function add_round_key;
end package body add_round_key;











