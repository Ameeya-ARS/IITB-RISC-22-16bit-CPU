library ieee;
use ieee.std_logic_1164.all;

entity right_sign_extend is
	port (input_data : IN STD_LOGIC_VECTOR(8 downto 0);
			output_data : OUT STD_LOGIC_VECTOR(15 downto 0));
end entity;


architecture right_sign_extend_arch of right_sign_extend is
		begin
			process (input_data)
			begin
				output_data <= (input_data & "0000000");
			end process;
end architecture;