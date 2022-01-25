library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter_TB is
end entity;

architecture sim of Counter_TB is

    constant ClockFrequency : integer := 12000000; --12MHz
    constant ClockPeriod : time := 1 sec / ClockFrequency;
    signal clk_i: std_logic := '1';
    signal Rst_n_i: std_logic := '0';

    signal Timer_i: integer:= 2;
    signal Counter_i: std_logic:= '0';
    signal Counter_o: std_logic;

begin

    Counter : entity work.Counter_e(Counter_a)
    port map(
        clk_i => clk_i,
        Rst_n_i => Rst_n_i,

        Timer_i => Timer_i,
        Counter_i => Counter_i,
        Counter_o => Counter_o
    );

clk_i <= not clk_i after Clockperiod;

process is
    begin
        
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);

        Rst_n_i <= '1';
        assert Rst_n_i = '1' report "Running..." severity note;

        wait for 200 ns;
        Counter_i <= '1';

        wait until Counter_o = '1';
        assert Counter_o = '0' report "Output High! Test Passed." severity warning;

        wait;

    end process;

end architecture;