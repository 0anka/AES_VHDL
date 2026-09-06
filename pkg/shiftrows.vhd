-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
-- s = sr,(c+r) mod 4 for 0 ≤ r < 4 and 0 ≤ c < 4. MATHEMATICAL IMPLEMENTATION 
-- GOOD MATHEMATICALL REPRESNTATION BAD HARDWARE IMPLEMENTATION
library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library WORK; use WORK.BYTE_SEQUENCES.ALL;
package SHIFTROWS is
                type SHIFTROW is array ( 0 to 3,0 to 3 ) of \8bit\;
        function shift_rows ( input_state:STATE(15 downto 0 ) ) return STATE; 
end package SHIFTROWS;
package body SHIFTROWS is 
        function shift_rows ( input_state:STATE(15 downto 0) ) return STATE is 
                variable shift:SHIFTROW:=(

                0=>(input_state(15),input_state(11),input_state(7),input_state(3)),

                1=>(input_state(14),input_state(10),input_state(6),input_state(2)),

                2=>(input_state(13),input_state(9),input_state(5),input_state(1)),

                3=>(input_state(12), input_state(8),input_state(4),input_state(0))

        );
        variable output_state:STATE(15 downto 0):=(others =>(others => '0'));
        variable newshift : SHIFTROW;
        begin
                newshift(0,0) := shift(0,(0 + 0) mod 4);
                newshift(0,1) := shift(0,(1 + 0) mod 4);
                newshift(0,2) := shift(0,(2 + 0) mod 4);
                newshift(0,3) := shift(0,(3 + 0) mod 4);


                newshift(1,0) := shift(1,(0 + 1) mod 4);
                newshift(1,1) := shift(1,(1 + 1) mod 4);
                newshift(1,2) := shift(1,(2 + 1) mod 4);
                newshift(1,3) := shift(1,(3 + 1) mod 4);

                newshift(2,0) := shift(2,(0 + 2) mod 4);
                newshift(2,1) := shift(2,(1 + 2) mod 4);
                newshift(2,2) := shift(2,(2 + 2) mod 4);
                newshift(2,3) := shift(2,(3 + 2) mod 4);

                newshift(3,0) := shift(3,(0 + 3) mod 4);
                newshift(3,1) := shift(3,(1 + 3) mod 4);
                newshift(3,2) := shift(3,(2 + 3) mod 4);
                newshift(3,3) := shift(3,(3 + 3) mod 4);

                output_state(15) := newshift(0,0);
                output_state(14) := newshift(1,0);
                output_state(13) := newshift(2,0);
                output_state(12) := newshift(3,0);

                output_state(11) := newshift(0,1);
                output_state(10) := newshift(1,1);
                output_state(9)  := newshift(2,1);
                output_state(8)  := newshift(3,1);

                output_state(7) := newshift(0,2);
                output_state(6) := newshift(1,2);
                output_state(5) := newshift(2,2);
                output_state(4) := newshift(3,2);

                output_state(3) := newshift(0,3);
                output_state(2) := newshift(1,3);
                output_state(1) := newshift(2,3);
                output_state(0) := newshift(3,3);
                 
            return output_state;
end function shift_rows;
end package body SHIFTROWS;







