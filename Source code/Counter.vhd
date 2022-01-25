library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter_e is
    port(
        clk_i: in std_logic;
        Rst_n_i: in std_logic;

        Timer_i: in integer;
        Counter_i: in std_logic;

        Counter_o: out std_logic
    );
    end entity;

    architecture Counter_a of Counter_e is

        signal Ticks: integer;
        signal Seconds: integer;
        signal counter_input: integer;
        signal counter_state: std_logic;
    
        begin
        process(clk_i, Rst_n_i) is
            begin
            if Rst_n_i = '0' then
                Ticks <= 0;
                Seconds <= 0;
                counter_input <= 0;
                counter_state <= '0';
                Counter_o <= '0';
            -- end if;
            elsif rising_edge(clk_i) then
                if counter_state = '0' then
                    if (Timer_i /= 0 and Counter_i = '1') then
                        counter_state <= '1';
                        counter_input <= Timer_i;
                    else
                        counter_state <= '0';
                        counter_input <= Timer_i;
                    end if;
                    Ticks <= 0;
                    Seconds <= 0;
                    Counter_o <= '0';
                else
                    -- if rising_edge(clk_i) then
                        if Ticks = 6250000 then
                            if Seconds = counter_input - 1 then
                                Counter_o <= '1';
                                counter_state <= '0';
                            else
                                Seconds <= Seconds + 1;
                                Ticks <= 0;
                            end if;
                            else 
                            Ticks <= Ticks + 1;
                        end if;
                    -- end if;
                end if;
            end if;
        end process;
    
    end architecture;