-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
--  Copyright (C) 2026 Malefax
-- GENERAL SEQUENCE OF BITS
--r0 r1 r2 . . . r(8k−3) r(8k−2) r(8k−1) FOR 8K BITS
-- FOR 128 BITS => r0 r1 r2 . . . r125 r126 r127 
--IMPLEMENTATION r127 r126 r125 ... r2 r1 r0 
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
package BYTE_SEQUENCES is
        type S_IND is range 15 downto 0;
        type W_IND is range 3 downto 0;
        subtype AES_128 is std_logic_vector(127 downto 0 );
        subtype \8bit\ is std_logic_vector ( 7 downto 0 );
        subtype \32bit\ is std_logic_vector (31 downto 0);
        type STATE is array ( S_IND range <> ) of \8bit\;
        type WORD is array ( W_IND range <> ) of \32bit\;
        type RCON is array ( S_IND range <> ) of \32bit\;
        function rotword(\WORD\:\32bit\) return \32bit\; 
end package BYTE_SEQUENCES;        

package body BYTE_SEQUENCES is
        constant Rcon : RCON(10 downto 1) := (
        
        1=>(x"01" & x"00" & x"00" & x"00"),

        2=>(x"02" & x"00" & x"00" & x"00"),

        3=>(x"04" & x"00" & x"00" & x"00" ),

        4=>(x"08" & x"00" & x"00" & x"00" ),

        5=>(x"10" & x"00" & x"00" & x"00" ),

        6=>(x"20" & x"00" & x"00" & x"00" ),

        7=>(x"40" & x"00" & x"00" & x"00" ),

        8=>(x"80" & x"00" & x"00" & x"00" ),

        9=>(x"1b" & x"00" & x"00" & x"00" ),

        10=>(x"36" & x"00" & x"00" &x"00" )
        );

        function rotword(\WORD\:\32bit\) return \32bit\ is
                variable word:\32bit\ := (others =>'0');
        begin

                word(31 downto 24) := \WORD\(23 downto 16);
                word(23 downto 16) := \WORD\(15 downto 8);
                word(15 downto 8)  := \WORD\(7 downto 0);
                word(7 downto 0)   := \WORD\(31 downto 24);
                return word;
        end function rotword;
end package body BYTE_SEQUENCES;
                 

