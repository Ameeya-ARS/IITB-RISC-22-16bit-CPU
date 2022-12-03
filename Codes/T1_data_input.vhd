library ieee;
use ieee.std_logic_1164.all;

entity T1_data_input is
	port (Rf_D1 : in std_logic_vector(15 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_value : out std_logic_vector(15 downto 0);
			write_enable : out std_logic);
end entity;


architecture T1_data_input_arch of T1_data_input is
 begin
    process (Rf_D1, alu_out, current_state)
    begin
	 if current_state = "00010" then
		update_value <= Rf_D1;
		write_enable <= '1';
	 elsif current_state = "00011" or current_state = "00101" or current_state = "10011" or current_state = "01110" or current_state = "10000" then
		update_value <= alu_out;
		write_enable <= '1';
	 else
		update_value <= (others=>'0');
		write_enable <= '0';
	 end if;
    end process;
end architecture;