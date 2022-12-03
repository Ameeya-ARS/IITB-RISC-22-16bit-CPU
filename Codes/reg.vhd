library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity reg is
	generic(size: integer:=16);
	port(
			input_data: in std_logic_vector(size-1 downto 0);
			output_data: out std_logic_vector(size-1 downto 0);
			reset: in std_logic;
			clock: in std_logic;
			enabler: in std_logic
			);
end entity;

architecture reg_arch of reg is
begin
process(clock, reset, enabler)	
	begin
		if reset = '1' then
			output_data <= (others => '0');
		elsif rising_edge(clock) then
			if enabler = '1' then
				output_data <= input_data;
			end if;
		end if;
	end process;

end architecture;