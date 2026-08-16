-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
-- s = sr,(c+r) mod 4 for 0 ≤ r < 4 and 0 ≤ c < 4. MATHEMATICAL IMPLEMENTATION 
-- GOOD MATHEMATICALL REPRESNTATION BAD HARDWARE IMPLEMENTATION
library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
package SHIFTROWS is
        type S_IND is range 15 downto 0;
        type W_IND is range 3 downto 0;
        subtype AES_128 is std_logic_vector(127 downto 0 );
        subtype \8bit\ is std_logic_vector ( 7 downto 0 );
        subtype \32bit\ is std_logic_vector (31 downto 0);
        type STATE is array ( S_IND range <> ) of \8bit\;
        type WORD is array ( W_IND range <> ) of \32bit\;
        type SHIFTROW is array ( integer range 3 downto 0,integer range 3 downto 0 ) of \8bit\;
        function shiftrows ( \STATE\:STATE(15 downto 0 ) ) return STATE; 
end package SHIFTROWS;
package body SHIFTROWS is 
        function shiftrows ( \STATE\:STATE(15 downto 0) ) return STATE is 
                variable shift:SHIFTROW:=(

                0=>(\STATE\(15),\STATE\(14),\STATE\(13),\STATE\(12)),

                1=>(\STATE\(11),\STATE\(10),\STATE\(9),\STATE\(8)),

                2=>(\STATE\(7),\STATE\(6),\STATE\(5),\STATE\(4)),

                3=>(\STATE\(3), \STATE\(2),\STATE\(1),\STATE\(0))

        );
        variable state:STATE:=(others =>(others => '0'));
        variable newshift : SHIFTROW;
        begin
                newshift(0)(0) := shift(0)((0 + 0) mod 4);
                newshift(0)(1) := shift(0)((1 + 0) mod 4);
                newshift(0)(2) := shift(0)((2 + 0) mod 4);
                newshift(0)(3) := shift(0)((3 + 0) mod 4);

                newshift(1)(0) := shift(1)((0 + 1) mod 4);
                newshift(1)(1) := shift(1)((1 + 1) mod 4);
                newshift(1)(2) := shift(1)((2 + 1) mod 4);
                newshift(1)(3) := shift(1)((3 + 1) mod 4);

                newshift(2)(0) := shift(2)((0 + 2) mod 4);
                newshift(2)(1) := shift(2)((1 + 2) mod 4);
                newshift(2)(2) := shift(2)((2 + 2) mod 4);
                newshift(2)(3) := shift(2)((3 + 2) mod 4);

                newshift(3)(0) := shift(3)((0 + 3) mod 4);
                newshift(3)(1) := shift(3)((1 + 3) mod 4);
                newshift(3)(2) := shift(3)((2 + 3) mod 4);
                newshift(3)(3) := shift(3)((3 + 3) mod 4);

                state(15) := newshift(0)(0);
                state(14) := newshift(0)(1);
                state(13) := newshift(0)(2);
                state(12) := newshift(0)(3);

                state(11) := newshift(1)(0);
                state(10) := newshift(1)(1);
                state(9)  := newshift(1)(2);
                state(8)  := newshift(1)(3);

                state(7) := newshift(2)(0);
                state(6) := newshift(2)(1);
                state(5) := newshift(2)(2);
                state(4) := newshift(2)(3);

                state(3) := newshift(3)(0);
                state(2) := newshift(3)(1);
                state(1) := newshift(3)(2);
                state(0) := newshift(3)(3);
     return state;
end function shiftrows;
end package body SHIFTROWS;







