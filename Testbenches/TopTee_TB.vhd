library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopTee_TB is
end entity;

architecture sim of TopTee_TB is

    constant ClockFrequency : integer := 12000000; --12MHz
    constant ClockPeriod : time := 1 sec / ClockFrequency;
    signal clk_i: std_logic := '1';
    signal Rst_n_i: std_logic := '0';

    signal Sec_plus: std_logic:= '0';
    signal Sec_minus: std_logic:= '0';
    signal Min_plus: std_logic:= '0';
    signal Min_minus: std_logic:= '0';

    signal Sens_i: std_logic;

    signal Alarm_o: std_logic;

    signal rxd_i: std_logic;
    signal txd_o: std_logic;

    -- signal Led_rst_o: std_logic;
    -- signal Led_sec_o: std_logic;

begin

    TopTee : entity work.TopTee_e(TopTee_a)
    port map(
        clk_i => clk_i,
        Rst_n_i => Rst_n_i,

        Sec_plus => Sec_plus,
        Sec_minus => Sec_minus,
        Min_plus => Min_plus,
        Min_minus => Min_minus,
        Sens_i => Sens_i,
        Alarm_o => Alarm_o,
        rxd_i => rxd_i,
        txd_o => txd_o

        -- Led_rst_o => Led_rst_o,
        -- Led_sec_o => Led_sec_o
    );

clk_i <= not clk_i after Clockperiod;

process is
    begin
        
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);

        Rst_n_i <= '1';
        assert Rst_n_i = '1' report "Running..." severity note;

        wait for 100ns;
        Min_plus <= '1';
        wait for 40ns;
        Min_plus <= '0';
        wait for 600ns;

        Sec_plus <= '1';
        wait for 1400ns;
        Sec_plus <= '0';
        wait for 600ns;

        Min_plus <= '1';
        wait for 1400ns;
        Min_plus <= '0';
        wait for 600ns;

        Min_minus <= '1';
        wait for 1400ns;
        Min_minus <= '0';
        wait for 600ns;

        Min_minus <= '1';
        wait for 1400ns;
        Min_minus <= '0';
        wait for 600ns ;

        Sec_plus <= '1';
        wait for 1400ns;
        Sec_plus <= '0';
        wait for 600ns;
        
        Sec_plus <= '1';
        wait for 1400ns;
        Sec_plus <= '0';
        wait for 600ns;

        Sens_i <= '1';
        wait for 300ns;
        Sens_i <= '0';

        wait;

    end process;

end architecture;