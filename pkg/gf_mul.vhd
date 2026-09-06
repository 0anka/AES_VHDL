-- RUSSIAN PEASENT ALGORITHM GF_MUL
-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
--  Copyright (C) 2026 Malefax
library IEEE; use IEEE.STD_LOGIC_1164.ALL;use ieee.numeric_std.all;
package RUSSIAN_PEASENT is
        function gf_mul(\8BIT1\:std_logic_vector(7 downto 0);\8BIT2\:std_logic_vector(7 downto 0)) return std_logic_vector;
        constant  \0x01\:std_logic_vector(7 downto 0) := ( 7 downto 1 => '0',others => '1');
        constant  \0x1b\:std_logic_vector(7 downto 0 ) :=   ('0','0','0','1','1','0','1','1');
end package RUSSIAN_PEASENT;

package  body RUSSIAN_PEASENT is
        
        function gf_mul(\8BIT1\:std_logic_vector(7 downto 0);\8BIT2\:std_logic_vector( 7 downto 0)) return std_logic_vector is
                variable \8BIT_VAL1\:std_logic_vector(7 downto 0) := \8BIT1\;
                variable \8BIT_VAL2\:std_logic_vector (7 downto 0 ) := \8BIT2\;
                variable RP_VAL:std_logic_vector ( 7 downto 0 ) := ( others => '0');
                variable HIGH_BIT:std_logic;
        begin
                loop8times:for I in  0 to 7  loop
                    AND_COND:if \8BIT_VAL2\(0) = \0x01\(0) then
                           RP_VAL:= RP_VAL xor \8BIT_VAL1\;
                    end if AND_COND;
                HIGH_BIT:= \8BIT_VAL1\(7) ;
                \8BIT_VAL1\ := std_logic_vector(unsigned(\8BIT_VAL1\) sll 1);
                XOR_COND:if HIGH_BIT = '1' then
                        \8BIT_VAL1\ := \8BIT_VAL1\ xor \0x1b\;
                    end if XOR_COND;
                \8BIT_VAL2\ := std_logic_vector(unsigned(\8BIT_VAL2\) srl 1);
        end loop loop8times;
        return RP_VAL;
end function gf_mul;
end package body RUSSIAN_PEASENT;
