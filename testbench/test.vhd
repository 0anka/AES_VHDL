-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
-- Copyright (C) 2026 Malefax
-- IEEE 1076 TEXTIO PACKAGE USED
-- AES_128 IP CORE TESTBENCHES
library IEEE; library WORK ;use IEEE.STD_LOGIC_1164.ALL;use IEEE.NUMERIC_STD.ALL;
use std.textio.all;use IEEE.std_logic_textio.all; use WORK.BYTE_SEQUENCES.all;

entity testbench is
end entity testbench;

architecture test of testbench is
        component AES_128
                port(
                    clock : in std_logic;
                    key_state : in std_logic;
                    plaintext : in AES_128;
                    key : in AES_128;
                
                    ciphertext : out AES_128;
                    busy : out std_logic;
                    done : out std_logic
            );
        end component AES_128;

        signal clk       : std_logic := '0';
        signal testks    : std_logic := '1';
        signal busy       : std_logic;
        signal done       : std_logic;
        signal testplain : AES_128 := x"3243F6A8885A308D313198A2E0370734";
        signal testkey   : AES_128 := x"2B7E151628AED2A6ABF7158809CF4F3C";
        signal cipher : AES_128;
begin
        testunit:AES_128
        port map (
                clock=>clk,
                key_state=>testks,
                plaintext=>testplain,
                key=>testkey,
                ciphertext=>cipher,
                busy => busy,
                done => done
        );

        clock:process
        begin
                clk<='0';
                wait for 10 ns;

                clk<='1';
                wait for 10 ns;
        end process clock;

        event:process(busy,done)
                variable l : line;
        begin
                if busy'event then 
                        write(l,string'("BUSY: "));
                        write(l,busy);
                        writeline(output,l);
                end if;

                if done'event then 
                        write(l,string'("DONE: "));
                        write(l,done);
                        writeline(output,l);
                end if;
        end process event;

        triggerd:process(done)
                variable l : line ;
        begin
                if done = '1' then
                        write(l,string'("CIPHERTEXT : "));
                        hwrite(l,cipher);
                        writeline(output,l);
                end if;
        end process triggerd;
end architecture test;

configuration CFG_AES_128 of testbench is
        for testbench
                for testunit:AES_128
                        use entity WORK.AES(AES_128_ENGINE);
                end for;
        end for;
end configuration CFG_AES_128;


