library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Timer_TB is
end entity;

architecture sim of Timer_TB is

    constant ClockFrequency : integer := 12000000; --12MHz
    constant ClockPeriod : time := 1 sec / ClockFrequency;
    signal clk_i: std_logic := '1';
    signal Rst_n_i: std_logic := '0';

    signal Sec_plus: std_logic;
    signal Sec_minus: std_logic;
    signal Min_plus: std_logic;
    signal Min_minus: std_logic;
    signal Timer_o: integer;
    
begin

    Timer : entity work.Timer_e(Timer_a)
    port map(
        clk_i => clk_i,
        Rst_n_i => Rst_n_i,

        Sec_plus => Sec_plus,
        Sec_minus => Sec_minus,
        Min_plus => Min_plus,
        Min_minus => Min_minus,
        Timer_o => Timer_o
    );

clk_i <= not clk_i after Clockperiod;

process is
    begin
        
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);

        Rst_n_i <= '1';
        assert Rst_n_i = '1' report "Running..." severity note;

        wait for 200 ns;
        Sec_plus <= '1';
        wait for 2000 ns;
        Sec_plus <= '0';

        wait until Timer_o = 1;
        assert Timer_o = 0 report "Time added! Test Passed." severity warning;

        wait;

    end process;

end architecture;