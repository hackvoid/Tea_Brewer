library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Uart_e is
port(
    clk_i : in std_logic := '1';
    Rst_n_i: in std_logic := '0';

    rxd_i: in std_logic;

	txd_o: out std_logic
);
end entity;

architecture Uart_a of Uart_e is
    type state is (ready,r0,r1,r2,r3,r4,r5,r6,r7,r8,stop1);   ----fsm for receive
	signal idle : state := ready;
	type state1 is (ready1,t0,t1,t2,t3,t4,t5,t6,t7,t8,stop1);  -----fsm for transmit
	signal idle1 : state1 := ready1;
	signal start,stop2 : std_logic := '0';
	signal store : std_logic_vector(8 downto 0) := "000000000";

    begin

        process(Rst_n_i,clk_i)					------------------------------------------------ receive
		variable i : integer := 0 ;
			begin
			if Rst_n_i = '1' then
				if clk_i'event and clk_i = '1' then
---------------------------------------------------------------------------------------- start 
					if idle = ready then    
						start <= rxd_i;
					end if;
					if start = '0' then
						idle <= r0;
					elsif start = '1' then
						idle <= ready;
					end if;
---------------------------------------------------------------------------------------- 1
					if idle = r0 then
					store(0) <= rxd_i;
					i := i + 1;
					idle <= r0;
						if i = 1250 then
						i := 0;
						idle <= r1;
						end if;
					end if;
---------------------------------------------------------------------------------------- 2
					if idle = r1 then
					store(1) <= rxd_i;       
					i := i + 1;
					idle <= r1;
						if i = 1250 then   
						i := 0;
						idle <= r2;
						end if;
					end if;
---------------------------------------------------------------------------------------- 3
					if idle = r2 then
					store(2) <= rxd_i;       
					i := i + 1;
					idle <= r2;
						if i = 1250 then   
						i := 0;
						idle <= r3;
						end if;
					end if;
---------------------------------------------------------------------------------------- 4
					if idle = r3 then
					store(3) <= rxd_i;       
					i := i + 1;
					idle <= r3;
						if i = 1250 then   
						i := 0;
						idle <= r4;
						end if;
					end if;
---------------------------------------------------------------------------------------- 5
					if idle = r4 then
					store(4) <= rxd_i;       
					i := i + 1;
					idle <= r4;
						if i = 1250 then   
						i := 0;
						idle <= r5;
						end if;
					end if;
---------------------------------------------------------------------------------------- 6
					if idle = r5 then
					store(5) <= rxd_i;       
					i := i + 1;
					idle <= r5;
						if i = 1250 then   
						i := 0;
						idle <= r6;
						end if;
					end if;
---------------------------------------------------------------------------------------- 7
					if idle = r6 then
					store(6) <= rxd_i;       
					i := i + 1;
					idle <= r6;
						if i = 1250 then   
						i := 0;
						idle <= r7;
						end if;
					end if;
---------------------------------------------------------------------------------------- 8
					if idle = r7 then
					store(7) <= rxd_i;       
					i := i + 1;
					idle <= r7;
						if i = 1250 then   
						i := 0;
						idle <= r8;
						end if;
					end if;
---------------------------------------------------------------------------------------- stop1
					if idle = r8 then
					store(8) <= rxd_i;       
					i := i + 1;
					idle <= r8;
						if i = 1250 then   
						i := 0;
						idle <= stop1;
						end if;
					end if;
---------------------------------------------------------------------------------------- stop2
					if idle = stop1 then
					stop2 <= rxd_i;       
					i := i + 1;
					idle <= stop1;
						if i = 1250 then   
						i := 0;
						idle <= ready;
						end if;
					end if;
----------------------------------------------------------------------------------------					
				end if;
			end if;
	end process;
	process(Rst_n_i,clk_i)					------------------------------------------------ transmit
		variable i : integer := 0 ;
			begin
			if Rst_n_i = '1' then
				if clk_i'event and clk_i = '1' then
---------------------------------------------------------------------------------------- start 
					if idle1 = ready1 then    
                        txd_o <= start;   
					end if;
					if start = '0' then
						idle1 <= t0;
					elsif start = '1' then
						idle1 <= ready1;
					end if;
---------------------------------------------------------------------------------------- 1
					if idle1 = t0 then
					-- store(0) <= txd_o;
                    txd_o <= store(0);
					i := i + 1;
					idle1 <= t0;
						if i = 1250 then
						i := 0;
						idle1 <= t1;
						end if;
					end if;
---------------------------------------------------------------------------------------- 2
					if idle1 = t1 then
                    txd_o <= store(1);       
					i := i + 1;
					idle1 <= t1;
						if i = 1250 then   
						i := 0;
						idle1 <= t2;
						end if;
					end if;
---------------------------------------------------------------------------------------- 3
					if idle1 = t2 then
                    txd_o <= store(2);       
					i := i + 1;
					idle1 <= t2;
						if i = 1250 then   
						i := 0;
						idle1 <= t3;
						end if;
					end if;
---------------------------------------------------------------------------------------- 4
					if idle1 = t3 then
                    txd_o <= store(3);       
					i := i + 1;
					idle1 <= t3;
						if i = 1250 then   
						i := 0;
						idle1 <= t4;
						end if;
					end if;
---------------------------------------------------------------------------------------- 5
					if idle1 = t4 then
                    txd_o <= store(4);       
					i := i + 1;
					idle1 <= t4;
						if i = 1250 then   
						i := 0;
						idle1 <= t5;
						end if;
					end if;
---------------------------------------------------------------------------------------- 6
					if idle1 = t5 then
                    txd_o <= store(5);       
					i := i + 1;
					idle1 <= t5;
						if i = 1250 then   
						i := 0;
						idle1 <= t6;
						end if;
					end if;
---------------------------------------------------------------------------------------- 7
					if idle1 = t6 then
                    txd_o <= store(6);       
					i := i + 1;
					idle1 <= t6;
						if i = 1250 then   
						i := 0;
						idle1 <= t7;
						end if;
					end if;
---------------------------------------------------------------------------------------- 8
					if idle1 = t7 then
                    txd_o <= store(7);       
					i := i + 1;
					idle1 <= t7;
						if i = 1250 then   
						i := 0;
						idle1 <= t8;
						end if;
					end if;
---------------------------------------------------------------------------------------- stop1
					if idle1 = t8 then
                    txd_o <= store(8);       
					i := i + 1;
					idle1 <= t8;
						if i = 1250 then   
						i := 0;
						idle1 <= stop1;
						end if;
					end if;
---------------------------------------------------------------------------------------- stop2
					if idle1 = stop1 then
					txd_o <= stop2;       
					i := i + 1;
					idle1 <= stop1;
						if i = 1250 then   
						i := 0;
						idle1 <= ready1;
						end if;
					end if;
----------------------------------------------------------------------------------------					
				end if;
			end if;
	end process;

end architecture;