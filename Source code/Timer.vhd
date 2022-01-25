library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Timer_e is
    port(
        clk_i: in std_logic;
        Rst_n_i: in std_logic;

        Sec_plus: in std_logic;
        Sec_minus: in std_logic;
        Min_plus: in std_logic;
        Min_minus: in std_logic;
        Timer_o: out integer
        -- Led_rst_o: out std_logic;
        -- Led_sec_o: out std_logic
    );
    end entity;

    architecture Timer_a of Timer_e is
    
        signal timer: integer;
        signal debouncer_1: std_logic;
        signal debouncer_2: std_logic;
        type timer_state IS (A, B, C, D, E);  -- Define the states
	    signal state : timer_state;    

        begin
        process(clk_i, Rst_n_i) is
            begin
            if Rst_n_i = '0' then
                timer <= 0;
                debouncer_1 <= '0';
                debouncer_2 <= '0';
                Timer_o <= 0;
                state <= A;
                -- Led_rst_o <= '1';
            elsif rising_edge(clk_i) then
                case state is
                    when A =>
                        -- Led_rst_o <= '0';
                        if timer < 0 then
                            timer <= 0;
                        end if;
                        if timer > 300 then
                            timer <= 300;
                        end if;
                        Timer_o <= timer;
                        if Sec_plus = '1' then
                            state <= B;
                        end if;
                        if Sec_minus = '1' then
                            state <= C;
                        end if;
                        if Min_plus = '1' then
                            state <= D;
                        end if;
                        if Min_minus = '1' then
                            state <= E;
                        end if;
                    
                    when B => 
                        if Sec_plus = '1' then
                            if Sec_plus = '1' and debouncer_1 = '1' then
                                debouncer_2 <= '1';
                            else 
                                debouncer_1 <= Sec_plus;
                            end if;
                        elsif Sec_plus = '0' and debouncer_2 = '1' then
                            timer <= timer + 1;
                            -- Led_sec_o <= '1';
                            debouncer_1 <= '0';
                            debouncer_2 <= '0';
                            state <= A;
                        else
                            debouncer_1 <= '0';
                            debouncer_2 <= '0';
                            state <= A;
                        end if;
                    when C =>
                    if Sec_minus = '1' then
                        if Sec_minus = '1' and debouncer_1 = '1' then
                            debouncer_2 <= '1';
                        else 
                            debouncer_1 <= Sec_minus;
                        end if;
                    elsif Sec_minus = '0' and debouncer_2 = '1' then
                        timer <= timer - 1;
                        debouncer_1 <= '0';
                        debouncer_2 <= '0';
                        state <= A;
                    else
                        debouncer_1 <= '0';
                        debouncer_2 <= '0';
                        state <= A;
                    end if;
                    when D =>
                        if Min_plus = '1' then
                            if Min_plus = '1' and debouncer_1 = '1' then
                                debouncer_2 <= '1';
                            else 
                                debouncer_1 <= Min_plus;
                            end if;
                        elsif Min_plus = '0' and debouncer_2 = '1' then
                            timer <= timer + 60;
                            debouncer_1 <= '0';
                            debouncer_2 <= '0';
                            state <= A;
                        else
                            debouncer_1 <= '0';
                            debouncer_2 <= '0';
                            state <= A;
                        end if;
                    when E =>
                        if Min_minus = '1' then
                            if Min_minus = '1' and debouncer_1 = '1' then
                                debouncer_2 <= '1';
                            else 
                                debouncer_1 <= Min_minus;
                            end if;
                        elsif Min_minus = '0' and debouncer_2 = '1' then
                            timer <= timer - 60;
                            debouncer_1 <= '0';
                            debouncer_2 <= '0';
                            state <= A;
                        else
                            debouncer_1 <= '0';
                            debouncer_2 <= '0';
                            state <= A;
                        end if;
                end case;
            end if;
        end process;
    
    end architecture;