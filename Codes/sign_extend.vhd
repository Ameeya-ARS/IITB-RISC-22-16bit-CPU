library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
	generic(	input_size: integer := 6;
				output_size: integer := 16
			 );
	port(
			input: in std_logic_vector(input_size-1 downto 0);
			output: out std_logic_vector(output_size-1 downto 0)
		 );
end entity;

architecture sign_extend_arch of sign_extend is
begin
	
	output(input_size-1 downto 0) <= input;
	
	extend:
	for i in input_size to output_size-1 generate
		output(i) <= input(input_size-1);
	end generate extend;
	
end architecture;