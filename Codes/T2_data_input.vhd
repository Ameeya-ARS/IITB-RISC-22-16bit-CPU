library ieee;
use ieee.std_logic_1164.all;

entity T2_data_input is
	port (Rf_D1 : in std_logic_vector(15 downto 0);
			Rf_D2 : in std_logic_vector(15 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			mem_d : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_value : out std_logic_vector(15 downto 0);
			write_enable : out std_logic);
end entity;


architecture T2_data_input_arch of T2_data_input is
 begin
    process (current_state,Rf_D1,Rf_D2,mem_d,alu_out)
    begin
	 if current_state = "00010" then
		update_value <= Rf_D2;
		write_enable <= '1';
	 elsif current_state = "00100" then
		update_value <= alu_out;
		write_enable <= '1';
	 elsif current_state = "01001" or current_state = "01010" then
		update_value <= mem_d;
		write_enable <= '1';
	 elsif current_state = "01111" then
		update_value <= Rf_D1;
		write_enable <= '1';
	 else
		update_value <= (others=>'0');
		write_enable <= '0';
	 end if;
    end process;
end architecture;