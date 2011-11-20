-- Quartus II VHDL Program 
-- PWM Control
-- Author Kiran Jose

library ieee;
use ieee.std_logic_1164.all;

entity pwm is

	port 
	(
		clk		: in std_logic;
		pwm_out	: buffer std_logic
	);

end entity;

architecture rtl of pwm is

begin
	process (clk)
	--variable to count the clock pulse
	variable count : integer range 0 to 50000;
	--variable to change duty cycle of the pulse
	variable duty_cycle : integer range 0 to 50000;
	--variable to determine whether to increse or decrese the dutycycle
	variable flag : integer range 0 to 1;
	begin
		if (rising_edge(clk)) then
		    --increasing the count for each clock cycle
			count:= count+1;
			--setting output to logic 1 when count reach duty cycle value
			--output stays at logic 1 @ duty_cycle <= count <=50000
			if (count = duty_cycle) then
				pwm_out <= '1';
			end if;
			--setting output to logic 0 when count reach 50000
			--output stays at logic 0 @ 50000,0 <= count <= duty_cycle
			if (count = 50000) then
				pwm_out <= '0';
				count:= 0;
				--after each complete pulse the duty cycle varies
				if(flag = 0) then
					duty_cycle:= duty_cycle+50;
				else
					duty_cycle:= duty_cycle-50;
				end if;
				-- flag changes when duty_cycle reaches max and min value
				if(duty_cycle = 50000) then
					flag:= 1;
				elsif(duty_cycle = 0) then
					flag:= 0;
				end if;
				
			end if;	
			
		end if;
		
	end process;

end rtl;