-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
--  Copyright (C) 2026 Malefax
-- KEY_EXPANSION ALGORITHM IMPLEMENTATED
library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library WORK; use WORK.BYTE_SEQUENCES.ALL; use WORK.SUBBYTES.ALL;
package KEYEXPANSION is
                 type KEY_EXPANSION_STATE is (
        KEY_IDLE,
        KEY_EXPAND,
        KEY_DONE
    );
        subtype counter is integer range 0 to 10;
        function key_expansion(\word\:WORD(3 downto 0);coun:counter) return WORD; 
end package KEYEXPANSION;
package body KEYEXPANSION is
        function key_expansion(\word\:WORD(3 downto 0);coun:counter) return WORD is
                variable word_out:WORD(3 downto 0) := (others=>(others=>'0'));
                variable temp:\32bit\;
        begin
                temp := subword(rotword(\word\(0))) xor \Rcon\(S_IND(coun));
                word_out(3) := \word\(3) xor temp;
                word_out(2) := \word\(2) xor word_out(3);
                word_out(1) := \word\(1) xor word_out(2);
                word_out(0) := \word\(0) xor word_out(1);
                return word_out;
        end function key_expansion;
end package body;


                                



        

