library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sensor_e is
    port(
        clk_i: in std_logic;
        Rst_n_i: in std_logic;

        Sens_i: in std_logic;

        Sens_o: out std_logic
    );
    end entity;

architecture Sensor_a of Sensor_e is

    signal debouncer_1: std_logic;
    signal debouncer_2: std_logic;
    
    begin
    process(clk_i, Rst_n_i) is
        begin
        if Rst_n_i = '0' then
            Sens_o <= '0';
            debouncer_1 <= '0';
            debouncer_2 <= '0';
        elsif rising_edge(clk_i) then
            if Sens_i = '1' then
                if Sens_i = '1' and debouncer_1 = '1' then
                    debouncer_2 <= '1';
                else 
                    debouncer_1 <= Sens_i;
                end if;
            elsif Sens_i = '0' and debouncer_2 = '1' then
                Sens_o <= '1';
                debouncer_1 <= '0';
                debouncer_2 <= '0';
            else
                debouncer_1 <= '0';
                debouncer_2 <= '0';
            end if;
        end if;
    end process;

end architecture;