library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopTee_e is
    port(
        clk_i: in std_logic;
        Rst_n_i: in std_logic:= '0';

        Sec_plus: in std_logic;
        Sec_minus: in std_logic;
        Min_plus: in std_logic;
        Min_minus: in std_logic;

        Sens_i:in std_logic;

        Alarm_o: out std_logic;

        rxd_i:in std_logic;
        txd_o:out std_logic

        -- Led_rst_o: out std_logic;
        -- Led_sec_o: out std_logic
    );
end entity;

architecture TopTee_a of TopTee_e is

    signal Timer_o: integer;

    signal Timer_i: integer;
    signal Counter_i: std_logic; 
    signal Counter_o: std_logic;

    signal Sens_o: std_logic;

    signal Alarm_i: std_logic;

    -- signal Rst_pwr: std_logic := '1';
begin

Timer : entity work.Timer_e(Timer_a)
port map(
    clk_i => clk_i,
    Rst_n_i => Rst_n_i,

    Sec_plus => Sec_plus,
    Sec_minus => Sec_minus,
    Min_plus => Min_plus,
    Min_minus => Min_minus,

    Timer_o => Timer_i
    
    -- Led_rst_o => Led_rst_o,
    -- Led_sec_o => Led_sec_o
);

Counter : entity work.Counter_e(Counter_a)
port map(
    clk_i => clk_i,
    Rst_n_i => Rst_n_i,

    Timer_i => Timer_i,
    Counter_i => Counter_i,

    Counter_o => Alarm_i
);

Sensor : entity work.Sensor_e(Sensor_a)
port map(
    clk_i => clk_i,
    Rst_n_i => Rst_n_i,

    Sens_i => Sens_i,

    Sens_o => Counter_i
);

Alarm : entity work.Alarm_e(Alarm_a)
port map(
    clk_i => clk_i,
    Rst_n_i => Rst_n_i,

    Alarm_i => Alarm_i,

    Alarm_o => Alarm_o
); 

Uart : entity work.Uart_e(Uart_a)
port map(
    clk_i => clk_i,
    Rst_n_i => Rst_n_i,

    rxd_i => rxd_i,

    txd_o => txd_o
); 

end architecture;