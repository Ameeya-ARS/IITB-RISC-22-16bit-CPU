library ieee;
use ieee.std_logic_1164.all;

entity reg_1bit is
	port (input_data: in std_logic;
			enabler : in std_logic;
			reset : in std_logic;
			clock : in std_logic;
			output_data : out std_logic);
end entity;


architecture reg_1bit_arch of reg_1bit is
		begin
			process (reset, clock)
			begin
				if reset = '1' then
					output_data <= '0';
				elsif rising_edge(clock) then
					if enabler = '1' then
						output_data <= input_data;
					end if;
				end if;
			end process;
end architecture;