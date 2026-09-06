-- IEEE 1076 and IEEE 1164
-- IEEE 1076.6 DISCOURAGE TILL NOW
-- PRODUCTION RULE FOLLOWED BY BNF GRAMMER AS PER IEEE 1076
--  Copyright (C) 2026 Malefax
-- AES_128 CORE ENGINE
library IEEE; library WORK; use IEEE.STD_LOGIC_1164.ALL;use IEEE.NUMERIC_STD.ALL;
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
            done : out Std_logic
);
end entity AES;

architecture AES_128_ENGINE of AES is

        type AES_ROUND_STATE is (
        IDLE,
        START,
        ROUND,
        FINAL_ROUND,
        END_STATE
);


        signal aes_state : AES_ROUND_STATE := IDLE;
        signal state_reg : AES_128 := (others => '0');
        signal round_key : AES_128 := (others => '0');
        signal round_counter : integer range 0 to 10 := 0;

begin
        
        busy <= '1' when aes_state /= IDLE and aes_state /= END_STATE
            else '0';

        done <= '1' when aes_state = END_STATE
            else '0';
        
                process(clock)
                        variable state_v : STATE(15 downto 0);
                        variable key_v   : WORD(3 downto 0);
                begin
                         if rising_edge(clock) then
                             if aes_state = IDLE then
                                 if key_state = '1' then

                                 state_reg <= plaintext;
                                 round_counter <= 0;
                                 round_key <= key;
                                 aes_state <= START;

                            end if;
                            
                         elsif aes_state = START then

                            state_v(15) := state_reg(127 downto 120);
                            state_v(14) := state_reg(119 downto 112);
                            state_v(13) := state_reg(111 downto 104);
                            state_v(12) := state_reg(103 downto 96);

                            state_v(11) := state_reg(95 downto 88);
                            state_v(10) := state_reg(87 downto 80);
                            state_v(9)  := state_reg(79 downto 72);
                            state_v(8)  := state_reg(71 downto 64);

                            state_v(7) := state_reg(63 downto 56);
                            state_v(6) := state_reg(55 downto 48);
                            state_v(5) := state_reg(47 downto 40);
                            state_v(4) := state_reg(39 downto 32);

                            state_v(3) := state_reg(31 downto 24);
                            state_v(2) := state_reg(23 downto 16);
                            state_v(1) := state_reg(15 downto 8);
                            state_v(0) := state_reg(7 downto 0);

                            key_v(3) := round_key(127 downto 96);
                            key_v(2) := round_key(95 downto 64);
                            key_v(1) := round_key(63 downto 32);
                            key_v(0) := round_key(31 downto 0);

                            state_v := add_roundkey(state_v, key_v);

                            state_reg(127 downto 120) <= state_v(15);
                            state_reg(119 downto 112) <= state_v(14);
                            state_reg(111 downto 104) <= state_v(13);
                            state_reg(103 downto 96)  <= state_v(12);

                            state_reg(95 downto 88) <= state_v(11);
                            state_reg(87 downto 80) <= state_v(10);
                            state_reg(79 downto 72) <= state_v(9);
                            state_reg(71 downto 64) <= state_v(8);

                            state_reg(63 downto 56) <= state_v(7);
                            state_reg(55 downto 48) <= state_v(6);
                            state_reg(47 downto 40) <= state_v(5);
                            state_reg(39 downto 32) <= state_v(4);

                            state_reg(31 downto 24) <= state_v(3);
                            state_reg(23 downto 16) <= state_v(2);
                            state_reg(15 downto 8)  <= state_v(1);
                            state_reg(7 downto 0)   <= state_v(0);

                            round_counter <= 1;

                            aes_state <= ROUND;

                        elsif aes_state = ROUND then

                            state_v(15) := state_reg(127 downto 120);
                            state_v(14) := state_reg(119 downto 112);
                            state_v(13) := state_reg(111 downto 104);
                            state_v(12) := state_reg(103 downto 96);

                            state_v(11) := state_reg(95 downto 88);
                            state_v(10) := state_reg(87 downto 80);
                            state_v(9)  := state_reg(79 downto 72);
                            state_v(8)  := state_reg(71 downto 64);

                            state_v(7) := state_reg(63 downto 56);
                            state_v(6) := state_reg(55 downto 48);
                            state_v(5) := state_reg(47 downto 40);
                            state_v(4) := state_reg(39 downto 32);

                            state_v(3) := state_reg(31 downto 24);
                            state_v(2) := state_reg(23 downto 16);
                            state_v(1) := state_reg(15 downto 8);
                            state_v(0) := state_reg(7 downto 0);

                            state_v := subytes(state_v);

                            state_v := shift_rows(state_v);

                            state_v := mix_columns(state_v);

                            key_v(3) := round_key(127 downto 96);
                            key_v(2) := round_key(95 downto 64);
                            key_v(1) := round_key(63 downto 32);
                            key_v(0) := round_key(31 downto 0);

                            key_v := key_expansion(key_v,round_counter);

                            round_key(127 downto 96) <= key_v(3);
                            round_key(95 downto 64)  <= key_v(2);
                            round_key(63 downto 32)  <= key_v(1);
                            round_key(31 downto 0)   <= key_v(0);

                            state_v := add_roundkey(state_v, key_v);

                            state_reg(127 downto 120) <= state_v(15);
                            state_reg(119 downto 112) <= state_v(14);
                            state_reg(111 downto 104) <= state_v(13);
                            state_reg(103 downto 96)  <= state_v(12);

                            state_reg(95 downto 88) <= state_v(11);
                            state_reg(87 downto 80) <= state_v(10);
                            state_reg(79 downto 72) <= state_v(9);
                            state_reg(71 downto 64) <= state_v(8);

                            state_reg(63 downto 56) <= state_v(7);
                            state_reg(55 downto 48) <= state_v(6);
                            state_reg(47 downto 40) <= state_v(5);
                            state_reg(39 downto 32) <= state_v(4);

                            state_reg(31 downto 24) <= state_v(3);
                            state_reg(23 downto 16) <= state_v(2);
                            state_reg(15 downto 8)  <= state_v(1);
                            state_reg(7 downto 0)   <= state_v(0);

                            if round_counter = 9 then
                                round_counter <= 10;
                                aes_state <= FINAL_ROUND;

                            else
                                round_counter <= round_counter + 1;
                            end if;
                        
                        elsif aes_state = FINAL_ROUND then

                            state_v(15) := state_reg(127 downto 120);
                            state_v(14) := state_reg(119 downto 112);
                            state_v(13) := state_reg(111 downto 104);
                            state_v(12) := state_reg(103 downto 96);

                            state_v(11) := state_reg(95 downto 88);
                            state_v(10) := state_reg(87 downto 80);
                            state_v(9)  := state_reg(79 downto 72);
                            state_v(8)  := state_reg(71 downto 64);

                            state_v(7) := state_reg(63 downto 56);
                            state_v(6) := state_reg(55 downto 48);
                            state_v(5) := state_reg(47 downto 40);
                            state_v(4) := state_reg(39 downto 32);

                            state_v(3) := state_reg(31 downto 24);
                            state_v(2) := state_reg(23 downto 16);
                            state_v(1) := state_reg(15 downto 8);
                            state_v(0) := state_reg(7 downto 0);

                            state_v := subytes(state_v);

                            state_v := shift_rows(state_v);

                            key_v(3) := round_key(127 downto 96);
                            key_v(2) := round_key(95 downto 64);
                            key_v(1) := round_key(63 downto 32);
                            key_v(0) := round_key(31 downto 0);

                            key_v := key_expansion(key_v,10);

                            state_v := add_roundkey(state_v, key_v);

                            state_reg(127 downto 120) <= state_v(15);
                            state_reg(119 downto 112) <= state_v(14);
                            state_reg(111 downto 104) <= state_v(13);
                            state_reg(103 downto 96)  <= state_v(12);

                            state_reg(95 downto 88) <= state_v(11);
                            state_reg(87 downto 80) <= state_v(10);
                            state_reg(79 downto 72) <= state_v(9);
                            state_reg(71 downto 64) <= state_v(8);

                            state_reg(63 downto 56) <= state_v(7);
                            state_reg(55 downto 48) <= state_v(6);
                            state_reg(47 downto 40) <= state_v(5);
                            state_reg(39 downto 32) <= state_v(4);

                            state_reg(31 downto 24) <= state_v(3);
                            state_reg(23 downto 16) <= state_v(2);
                            state_reg(15 downto 8)  <= state_v(1);
                            state_reg(7 downto 0)   <= state_v(0);

                            ciphertext <=
                                    state_v(15) & state_v(14) &
                                    state_v(13) & state_v(12) &
                                    state_v(11) & state_v(10) &
                                    state_v(9)  & state_v(8)  &
                                    state_v(7)  & state_v(6)  &
                                    state_v(5)  & state_v(4)  &
                                    state_v(3)  & state_v(2) &
                                    state_v(1)  & state_v(0);

                            aes_state <= END_STATE;

                        elsif aes_state = END_STATE then

                            aes_state <= IDLE;

                       end if;

               end if;
       end process;        

end architecture AES_128_ENGINE;

 
            
        
            
        
        


