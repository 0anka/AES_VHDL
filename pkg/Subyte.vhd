
-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
--  Copyright (C) 2026 Malefax
-- GENERAL SEQUENCE OF BITS
-- SUBBYTES USING SBOX 
library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
package SUBBYTES is
        type S_IND is range 15 downto 0;
        type W_IND is range 3 downto 0;
        subtype AES_128 is std_logic_vector(127 downto 0 );
        subtype \8bit\ is std_logic_vector ( 7 downto 0 );
        subtype \32bit\ is std_logic_vector (31 downto 0);
        type STATE is array ( S_IND range <> ) of \8bit\;
        type WORD is array ( W_IND range <> ) of \32bit\;
        type SBOX is array ( integer range 15 downto 0 , integer range 15 downto 0 ) of std_logic_vector(7 downto 0);
        function subytes ( \STATE\:STATE(15 downto 0 ) ) return STATE; 
end package SUBBYTES;
package body SUBBYTES is
        function subytes ( \STATE\:STATE( 15 downto 0) ) return STATE is
              constant AES_SBOX : SBOX := (
    0 => (
        0 => x"63",  1 => x"7c",  2 => x"77",  3 => x"7b",
        4 => x"f2",  5 => x"6b",  6 => x"6f",  7 => x"c5",
        8 => x"30",  9 => x"01", 10 => x"67", 11 => x"2b",
       12 => x"fe", 13 => x"d7", 14 => x"ab", 15 => x"76"
    ),

    1 => (
        0 => x"ca",  1 => x"82",  2 => x"c9",  3 => x"7d",
        4 => x"fa",  5 => x"59",  6 => x"47",  7 => x"f0",
        8 => x"ad",  9 => x"d4", 10 => x"a2", 11 => x"af",
       12 => x"9c", 13 => x"a4", 14 => x"72", 15 => x"c0"
    ),

    2 => (
        0 => x"b7",  1 => x"fd",  2 => x"93",  3 => x"26",
        4 => x"36",  5 => x"3f",  6 => x"f7",  7 => x"cc",
        8 => x"34",  9 => x"a5", 10 => x"e5", 11 => x"f1",
       12 => x"71", 13 => x"d8", 14 => x"31", 15 => x"15"
    ),

    3 => (
        0 => x"04",  1 => x"c7",  2 => x"23",  3 => x"c3",
        4 => x"18",  5 => x"96",  6 => x"05",  7 => x"9a",
        8 => x"07",  9 => x"12", 10 => x"80", 11 => x"e2",
       12 => x"eb", 13 => x"27", 14 => x"b2", 15 => x"75"
    ),

    4 => (
        0 => x"09",  1 => x"83",  2 => x"2c",  3 => x"1a",
        4 => x"1b",  5 => x"6e",  6 => x"5a",  7 => x"a0",
        8 => x"52",  9 => x"3b", 10 => x"d6", 11 => x"b3",
       12 => x"29", 13 => x"e3", 14 => x"2f", 15 => x"84"
    ),

    5 => (
        0 => x"53",  1 => x"d1",  2 => x"00",  3 => x"ed",
        4 => x"20",  5 => x"fc",  6 => x"b1",  7 => x"5b",
        8 => x"6a",  9 => x"cb", 10 => x"be", 11 => x"39",
       12 => x"4a", 13 => x"4c", 14 => x"58", 15 => x"cf"
    ),

    6 => (
        0 => x"d0",  1 => x"ef",  2 => x"aa",  3 => x"fb",
        4 => x"43",  5 => x"4d",  6 => x"33",  7 => x"85",
        8 => x"45",  9 => x"f9", 10 => x"02", 11 => x"7f",
       12 => x"50", 13 => x"3c", 14 => x"9f", 15 => x"a8"
    ),

    7 => (
        0 => x"51",  1 => x"a3",  2 => x"40",  3 => x"8f",
        4 => x"92",  5 => x"9d",  6 => x"38",  7 => x"f5",
        8 => x"bc",  9 => x"b6", 10 => x"da", 11 => x"21",
       12 => x"10", 13 => x"ff", 14 => x"f3", 15 => x"d2"
    ),

    8 => (
        0 => x"cd",  1 => x"0c",  2 => x"13",  3 => x"ec",
        4 => x"5f",  5 => x"97",  6 => x"44",  7 => x"17",
        8 => x"c4",  9 => x"a7", 10 => x"7e", 11 => x"3d",
       12 => x"64", 13 => x"5d", 14 => x"19", 15 => x"73"
    ),

    9 => (
        0 => x"60",  1 => x"81",  2 => x"4f",  3 => x"dc",
        4 => x"22",  5 => x"2a",  6 => x"90",  7 => x"88",
        8 => x"46",  9 => x"ee", 10 => x"b8", 11 => x"14",
       12 => x"de", 13 => x"5e", 14 => x"0b", 15 => x"db"
    ),

    10 => (
        0 => x"e0",  1 => x"32",  2 => x"3a",  3 => x"0a",
        4 => x"49",  5 => x"06",  6 => x"24",  7 => x"5c",
        8 => x"c2",  9 => x"d3", 10 => x"ac", 11 => x"62",
       12 => x"91", 13 => x"95", 14 => x"e4", 15 => x"79"
    ),

    11 => (
        0 => x"e7",  1 => x"c8",  2 => x"37",  3 => x"6d",
        4 => x"8d",  5 => x"d5",  6 => x"4e",  7 => x"a9",
        8 => x"6c",  9 => x"56", 10 => x"f4", 11 => x"ea",
       12 => x"65", 13 => x"7a", 14 => x"ae", 15 => x"08"
    ),

    12 => (
        0 => x"ba",  1 => x"78",  2 => x"25",  3 => x"2e",
        4 => x"1c",  5 => x"a6",  6 => x"b4",  7 => x"c6",
        8 => x"e8",  9 => x"dd", 10 => x"74", 11 => x"1f",
       12 => x"4b", 13 => x"bd", 14 => x"8b", 15 => x"8a"
    ),

    13 => (
        0 => x"70",  1 => x"3e",  2 => x"b5",  3 => x"66",
        4 => x"48",  5 => x"03",  6 => x"f6",  7 => x"0e",
        8 => x"61",  9 => x"35", 10 => x"57", 11 => x"b9",
       12 => x"86", 13 => x"c1", 14 => x"1d", 15 => x"9e"
    ),

    14 => (
        0 => x"e1",  1 => x"f8",  2 => x"98",  3 => x"11",
        4 => x"69",  5 => x"d9",  6 => x"8e",  7 => x"94",
        8 => x"9b",  9 => x"1e", 10 => x"87", 11 => x"e9",
       12 => x"ce", 13 => x"55", 14 => x"28", 15 => x"df"
    ),

    15 => (
        0 => x"8c",  1 => x"a1",  2 => x"89",  3 => x"0d",
        4 => x"bf",  5 => x"e6",  6 => x"42",  7 => x"68",
        8 => x"41",  9 => x"99", 10 => x"2d", 11 => x"0f",
       12 => x"b0", 13 => x"54", 14 => x"bb", 15 => x"16"
    )
);
variable state : STATE ( 15 downto 0) := \STATE\;
        begin
                state(15):=sbox(
                to_integer(unsigned(state(15)(7 downto 4))),
                to_integer(unsigned(state(15)(3 downto 0)))
                );

                state(14):=sbox(
                to_integer(unsigned(state(14)(7 downto 4))),
                to_integer(unsigned(state(14)(3 downto 0)))
                );

                state(13):=sbox(
                to_integer(unsigned(state(13)(7 downto 4))),
                to_integer(unsigned(state(13)(3 downto 0)))
                );

                state(12):=sbox(
                to_integer(unsigned(state(12)(7 downto 4))),
                to_integer(unsigned(state(12)(3 downto 0)))
                );

                state(11):=sbox(
                to_integer(unsigned(state(11)(7 downto 4))),
                to_integer(unsigned(state(11)(3 downto 0)))
                );

                state(10):=sbox(
                to_integer(unsigned(state(10)(7 downto 4))),
                to_integer(unsigned(state(10)(3 downto 0)))
                );

                state(9):=sbox(
                to_integer(unsigned(state(9)(7 downto 4))),
                to_integer(unsigned(state(9)(3 downto 0)))
                );

                state(8):=sbox(
                to_integer(unsigned(state(8)(7 downto 4))),
                to_integer(unsigned(state(8)(3 downto 0)))
                );

                state(7):=sbox(
                to_integer(unsigned(state(7)(7 downto 4))),
                to_integer(unsigned(state(7)(3 downto 0)))
                );

                state(6):=sbox(
                to_integer(unsigned(state(6)(7 downto 4))),
                to_integer(unsigned(state(6)(3 downto 0)))
                );

                state(5):=sbox(
                to_integer(unsigned(state(5)(7 downto 4))),
                to_integer(unsigned(state(5)(3 downto 0)))
                );

                state(4):=sbox(
                to_integer(unsigned(state(4)(7 downto 4))),
                to_integer(unsigned(state(4)(3 downto 0)))
                );

                state(3):=sbox(
                to_integer(unsigned(state(3)(7 downto 4))),
                to_integer(unsigned(state(3)(3 downto 0)))
                );

                state(2):=sbox(
                to_integer(unsigned(state(2)(7 downto 4))),
                to_integer(unsigned(state(2)(3 downto 0)))
                );

                state(1):=sbox(
                to_integer(unsigned(state(1)(7 downto 4))),
                to_integer(unsigned(state(1)(3 downto 0)))
                );
                
                state(0):=sbox(
                to_integer(unsigned(state(0)(7 downto 4))),
                to_integer(unsigned(state(0)(3 downto 0)))
                );
            return state;
    end function subytes;
end package body SUBBYTES; 


