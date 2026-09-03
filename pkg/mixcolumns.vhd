-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
-- GOOD MATHEMATICALL REPRESNTATION BAD HARDWARE IMPLEMENTATION
--MIXCOLUMNS IMPLEMENTATION
--s = ({02} • s0,c) ⊕ ({03} • s1,c) ⊕ s2,c ⊕ s3,c
--s = s0,c ⊕ ({02} • s1,c) ⊕ ({03} • s2,c) ⊕ s,c
--s = s0,c ⊕ s1,c ⊕ ({02} • s2,c) ⊕ ({03} • s3,c)
--s = ({03} • s0,c) ⊕ s1,c ⊕ s2,c ⊕ ({02} • s3,c)
library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library WORK; use WORK.BYTE_SEQUENCES.ALL;use WORK.RUSSIAN_PEASENT.ALL;
package MIXCOLUMNS is
                type \MIXCOLUMNS\ is array ( integer range 3 downto 0,integer range 3 downto 0 ) of \8bit\;
        function mixcolumns ( \STATE\:STATE(15 downto 0 ) ) return STATE; 
end package MIXCOLUMNS;
package body MIXCOLUMNS is 
        function mixcolumns ( \STATE\:STATE(15 downto 0 ) ) return STATE is
                variable state:\MIXCOLUMNS := (
                0=>(\STATE\(15),\STATE\(14),\STATE\(13),\STATE\(12)),

                1=>(\STATE\(11),\STATE\(10),\STATE\(9),\STATE\(8)),

                2=>(\STATE\(7),\STATE\(6),\STATE\(5),\STATE\(4)),

                3=>(\STATE\(3),\STATE\(2),\STATE\(1),\STATE\(0))
        );
                variable mix:\MIXCOLUMNS\ := (others =>(others => '0'));
                variable newstate:STATE(15 downto 0);
        begin
                
             mix(0)(0) := gf_mul(x"02", state(0)(0)) xor
             gf_mul(x"03", state(1)(0)) xor
             state(2)(0) xor state(3)(0);

             mix(1)(0) := state(0)(0) xor
             gf_mul(x"02", state(1)(0)) xor
             gf_mul(x"03", state(2)(0)) xor
             state(3)(0);

             mix(2)(0) := state(0)(0) xor state(1)(0) xor
             gf_mul(x"02", state(2)(0)) xor
             gf_mul(x"03", state(3)(0));

             mix(3)(0) := gf_mul(x"03", state(0)(0)) xor
             state(1)(0) xor state(2)(0) xor
             gf_mul(x"02", state(3)(0));

             mix(0)(1) := gf_mul(x"02", state(0)(1)) xor
             gf_mul(x"03", state(1)(1)) xor
             state(2)(1) xor state(3)(1);

             mix(1)(1) := state(0)(1) xor
             gf_mul(x"02", state(1)(1)) xor
             gf_mul(x"03", state(2)(1)) xor
             state(3)(1);

             mix(2)(1) := state(0)(1) xor state(1)(1) xor
             gf_mul(x"02", state(2)(1)) xor
             gf_mul(x"03", state(3)(1));

             mix(3)(1) := gf_mul(x"03", state(0)(1)) xor
             state(1)(1) xor state(2)(1) xor
             gf_mul(x"02", state(3)(1));

             mix(0)(2) := gf_mul(x"02", state(0)(2)) xor
             gf_mul(x"03", state(1)(2)) xor
             state(2)(2) xor state(3)(2);

             mix(1)(2) := state(0)(2) xor
             gf_mul(x"02", state(1)(2)) xor
             gf_mul(x"03", state(2)(2)) xor
             state(3)(2);

             mix(2)(2) := state(0)(2) xor state(1)(2) xor
             gf_mul(x"02", state(2)(2)) xor
             gf_mul(x"03", state(3)(2));

             mix(3)(2) := gf_mul(x"03", state(0)(2)) xor
             state(1)(2) xor state(2)(2) xor
             gf_mul(x"02", state(3)(2));

             mix(0)(3) := gf_mul(x"02", state(0)(3)) xor
             gf_mul(x"03", state(1)(3)) xor
             state(2)(3) xor state(3)(3);

             mix(1)(3) := state(0)(3) xor
             gf_mul(x"02", state(1)(3)) xor
             gf_mul(x"03", state(2)(3)) xor
             state(3)(3);

             mix(2)(3) := state(0)(3) xor state(1)(3) xor
             gf_mul(x"02", state(2)(3)) xor
             gf_mul(x"03", state(3)(3));

             mix(3)(3) := gf_mul(x"03", state(0)(3)) xor
             state(1)(3) xor state(2)(3) xor
             gf_mul(x"02", state(3)(3));

            newstate(15) := mix(0)(0);
newstate(14) := mix(1)(0);
newstate(13) := mix(2)(0);
newstate(12) := mix(3)(0);

newstate(11) := mix(0)(1);
newstate(10) := mix(1)(1);
newstate(9)  := mix(2)(1);
newstate(8)  := mix(3)(1);

newstate(7) := mix(0)(2);
newstate(6) := mix(1)(2);
newstate(5) := mix(2)(2);
newstate(4) := mix(3)(2);

newstate(3) := mix(0)(3);
newstate(2) := mix(1)(3);
newstate(1) := mix(2)(3);
newstate(0) := mix(3)(3);

return newstate;
end function mixcolumns;
end package body MIXCOLUMNS; 
