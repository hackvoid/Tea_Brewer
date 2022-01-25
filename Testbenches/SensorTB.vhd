library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sensor_TB is
end entity;

architecture sim of Sensor_TB is

    constant ClockFrequency : integer := 12000000; --12MHz
    constant ClockPeriod : time := 1 sec / ClockFrequency;
    signal clk_i: std_logic := '1';
    signal Rst_n_i: std_logic := '0';

    signal Sens_i: std_logic;
    signal Sens_o: std_logic;

begin

    Sensor : entity work.Sensor_e(Sensor_a)
    port map(
        clk_i => clk_i,
        Rst_n_i => Rst_n_i,

        Sens_i => Sens_i,
        Sens_o => Sens_o
    );

clk_i <= not clk_i after Clockperiod;

process is
    begin
        
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);

        Rst_n_i <= '1';
        assert Rst_n_i = '1' report "Running..." severity note;

        wait for 200 ns;
        Sens_i <= '1';
        wait for 2000 ns;
        Sens_i <= '0';

        wait until Sens_o = '1';
        assert Sens_o = '0' report "Output High! Test Passed." severity warning;

        wait;

    end process;

end architecture;