library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alarm_e is
    port(
        clk_i: in std_logic;
        Rst_n_i: in std_logic;

        Alarm_i: in std_logic;
        
        Alarm_o: out std_logic
    );
    end entity;

architecture Alarm_a of Alarm_e is
    signal state: std_logic;
    signal ticks: integer;
    
    begin
    process(clk_i, Rst_n_i) is
        begin
        if Rst_n_i = '0' then
            Alarm_o <= '0';
            state <= '0';
            ticks <= 0;
        elsif rising_edge(clk_i) then
            if Alarm_i = '1' then
                state <= '1';
            elsif state = '1' then
                Alarm_o <= '1';
                -- if rising_edge(clk_i) then
                    if ticks = 18750000 then
                        state <= '0';
                    else 
                    ticks <= ticks + 1;
                    end if;
                -- end if;
            else
                Alarm_o <= '0';
                ticks <= 0;
            end if;
        end if;
        
    end process;

end architecture;