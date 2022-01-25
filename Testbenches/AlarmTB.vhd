library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alarm_TB is
end entity;

architecture sim of Alarm_TB is

    constant ClockFrequency : integer := 12000000; --12MHz
    constant ClockPeriod : time := 1 sec / ClockFrequency;
    signal clk_i: std_logic := '1';
    signal Rst_n_i: std_logic := '0';

    signal Alarm_i: std_logic;
    signal Alarm_o: std_logic;

begin

    Alarm : entity work.Alarm_e(Alarm_a)
    port map(
        clk_i => clk_i,
        Rst_n_i => Rst_n_i,

        Alarm_i => Alarm_i,
        Alarm_o => Alarm_o
    );

clk_i <= not clk_i after Clockperiod;

process is
    begin
        
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);

        Rst_n_i <= '1';
        assert Rst_n_i = '1' report "Running..." severity note;

        wait for 200 ns;
        Alarm_i <= '1';
        wait for 200 ns;
        Alarm_i <= '0';

        wait until Alarm_o = '1';
        assert Alarm_o = '0' report "Output High! Test Passed." severity warning;

        wait;

    end process;

end architecture;