library ieee;
use ieee.std_logic_1164.all;

entity pc_update_value is
	port (Rf_D1 : in std_logic_vector(15 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_value : out std_logic_vector(15 downto 0);
			pc_enable : out std_logic);
end entity;


architecture pc_update_value_arch of pc_update_value is
 begin
    process (current_state, Rf_D1, alu_out)
    begin
		if current_state = "01101" then
			update_value <= Rf_D1;
			pc_enable <= '1';
		elsif current_state = "01100" or current_state = "10001" or current_state = "00001" or current_state = "10100" then
			update_value <= alu_out;
			pc_enable <= '1';
		else
			update_value <= (others=>'0');
			pc_enable <= '0';
		end if;
    end process;
end architecture;