-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
--  Copyright (C) 2026 Malefax
-- AES_128 CORE ENGINE
library IEEE;use IEEE.STD_LOGIC_1164.ALL;use IEEE.NUMERIC_STD.ALL;
use WORK.BYTE_SEQUENCES.all;
use WORK.SUBBYTES.all;
use WORK.ADD_ROUND_KEY.all;
use WORK.RUSSIAN_PEASENT.all;
use WORK.KEYEXPANSION.all;
use WORK.MIXCOLUMNS.all;
use WORK.SHIFTROWS.all;

entity AES is
        port(
            clock : in  std_logic ;
            key_state : in std_logic;
            plaintext : in AES_128;
            key : in AES_128;

            ciphertext : out AES_128;
            busy : out std_logic;
            done : out Std_logic;
);
end entity AES;

 
            
        
            
        
        


