-- AFFINE_TRANSFORMATION IN GALIOS FEILD => GF(2^8)
-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
--  Copyright (C) 2026 Malefax
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
package AFFINE_TRANSFORMATION is
        function affine_transformation(\8BIT1\ : std_logic_vector ( 7 downto 0 )) return std_logic_vector;
        constant \0x63\ : std_logic_vector ( 7 downto 0 ) := ( 6 downto 5 => '1' , 1 downto 0 =>'1' , others => '0');
end package AFFINE_TRANSFORMATION;

package body AFFINE_TRANSFORMATION is
        function affine_transformation(\8BIT1\ : std_logic_vector ( 7 downto 0)) return std_logic_vector is
         variable \8BIT_VAL1\ : std_logic_vector ( 7 downto 0 ):= \8BIT1\;
         variable \8BIT_VAL2\ : std_logic_vector ( 7 downto 0 ):= (others=>'0');
         begin
         loop8times:for Z in 0 to 7 loop 
                 \8BIT_VAL2\(z) := \8BIT_VAL1\(Z) xor
                 \8BIT_VAL1\((Z+4) mod 8) xor 
                 \8BIT_VAL1\((Z+5) mod 8) xor 
                 \8BIT_VAL1\((Z+6) mod 8) xor 
                 \8BIT_VAL1\((Z+7) mod 8) xor
                 \0x63\(Z);
         end loop loop8times;
         return \8BIT_VAL2\;
 end function affine_transformation;
end package body AFFINE_TRANSFORMATION;






