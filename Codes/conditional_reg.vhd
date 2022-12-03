library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity conditional_reg is
	generic(size: integer:=16);
	port(
			input_data: in std_logic_vector(size-1 downto 0);
			input_data2: in std_logic_vector(size-1 downto 0);
			output_data: out std_logic_vector(size-1 downto 0);
			reset: in std_logic;
			clock: in std_logic;
			enabler: in std_logic;
			enabler2: in std_logic
			);
end entity;

architecture conditional_reg_arch of conditional_reg is
begin
process(clock, reset, enabler)	
	begin
		if reset = '1' then
			output_data <= (others => '0');
		elsif rising_edge(clock) then
			if enabler = '1' then
				output_data <= input_data;
			elsif enabler2 = '1' then
				output_data <= input_data2;
			end if;
		end if;
	end process;

end architecture;