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
                type MIX_MATRIX is array ( integer range 3 downto 0,integer range 3 downto 0 ) of \8bit\;
                function mix_columns ( input_state:STATE(15 downto 0 ) ) return STATE; 
end package MIXCOLUMNS;
package body MIXCOLUMNS is 
        function mix_columns ( input_state:STATE(15 downto 0 ) ) return STATE is
                variable matrix : MIX_MATRIX;
                variable newmatrix:STATE(15 downto 0);
                variable mix : MIX_MATRIX := (
                0 => (others => ( others => '0')),
                1 => (others => ( others => '0')),
                2 => (others => ( others => '0')),
                3 => (others => ( others => '0'))
          );
        begin
            matrix(0,0) := input_state(15);
            matrix(1,0) := input_state(14);
            matrix(2,0) := input_state(13);
            matrix(3,0) := input_state(12);
            matrix(0,1) := input_state(11);
            matrix(1,1) := input_state(10);
            matrix(2,1) := input_state(9);
            matrix(3,1) := input_state(8);
            matrix(0,2) := input_state(7);
            matrix(1,2) := input_state(6);
            matrix(2,2) := input_state(5);
            matrix(3,2) := input_state(4);
            matrix(0,3) := input_state(3);
            matrix(1,3) := input_state(2);
            matrix(2,3) := input_state(1);
            matrix(3,3) := input_state(0);
  
             mix(0,0) := gf_mul(x"02", matrix(0,0)) xor
             gf_mul(x"03", matrix(1,0)) xor
             matrix(2,0) xor matrix(3,0);

             mix(1,0) := matrix(0,0) xor
             gf_mul(x"02", matrix(1,0)) xor
             gf_mul(x"03", matrix(2,0)) xor
             matrix(3,0);

             mix(2,0) := matrix(0,0) xor matrix(1,0) xor
             gf_mul(x"02", matrix(2,0)) xor
             gf_mul(x"03", matrix(3,0));

             mix(3,0) := gf_mul(x"03", matrix(0,0)) xor
             matrix(1,0) xor matrix(2,0) xor
             gf_mul(x"02", matrix(3,0));

             mix(0,1) := gf_mul(x"02", matrix(0,1)) xor
             gf_mul(x"03", matrix(1,1)) xor
             matrix(2,1) xor matrix(3,1);

             mix(1,1) := matrix(0,1) xor
             gf_mul(x"02", matrix(1,1)) xor
             gf_mul(x"03", matrix(2,1)) xor
             matrix(3,1);

             mix(2,1) := matrix(0,1) xor matrix(1,1) xor
             gf_mul(x"02", matrix(2,1)) xor
             gf_mul(x"03", matrix(3,1));

             mix(3,1) := gf_mul(x"03", matrix(0,1)) xor
             matrix(1,1) xor matrix(2,1) xor
             gf_mul(x"02", matrix(3,1));

             mix(0,2) := gf_mul(x"02", matrix(0,2)) xor
             gf_mul(x"03", matrix(1,2)) xor
             matrix(2,2) xor matrix(3,2);

             mix(1,2) := matrix(0,2) xor
             gf_mul(x"02", matrix(1,2)) xor
             gf_mul(x"03", matrix(2,2)) xor
             matrix(3,2);

             mix(2,2) := matrix(0,2) xor matrix(1,2) xor
             gf_mul(x"02", matrix(2,2)) xor
             gf_mul(x"03", matrix(3,2));

             mix(3,2) := gf_mul(x"03", matrix(0,2)) xor
             matrix(1,2) xor matrix(2,2) xor
             gf_mul(x"02", matrix(3,2));

             mix(0,3) := gf_mul(x"02", matrix(0,3)) xor
             gf_mul(x"03", matrix(1,3)) xor
             matrix(2,3) xor matrix(3,3);

             mix(1,3) := matrix(0,3) xor
             gf_mul(x"02", matrix(1,3)) xor
             gf_mul(x"03", matrix(2,3)) xor
             matrix(3,3);

             mix(2,3) := matrix(0,3) xor matrix(1,3) xor
             gf_mul(x"02", matrix(2,3)) xor
             gf_mul(x"03", matrix(3,3));

             mix(3,3) := gf_mul(x"03", matrix(0,3)) xor
             matrix(1,3) xor matrix(2,3) xor
             gf_mul(x"02", matrix(3,3));

            newmatrix(15) := mix(0,0);
            newmatrix(14) := mix(1,0);
            newmatrix(13) := mix(2,0);
            newmatrix(12) := mix(3,0);

            newmatrix(11) := mix(0,1);
            newmatrix(10) := mix(1,1);
            newmatrix(9)  := mix(2,1);
            newmatrix(8)  := mix(3,1);

            newmatrix(7) := mix(0,2);
            newmatrix(6) := mix(1,2);
            newmatrix(5) := mix(2,2);
            newmatrix(4) := mix(3,2);

            newmatrix(3) := mix(0,3);
            newmatrix(2) := mix(1,3);
            newmatrix(1) := mix(2,3);
            newmatrix(0) := mix(3,3);

return newmatrix;
end function mix_columns;
end package body MIXCOLUMNS; 
