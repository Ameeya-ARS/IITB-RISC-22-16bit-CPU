library ieee;
use ieee.std_logic_1164.all;

entity Rf_A3_input is
	port (Pe_out : in std_logic_vector(2 downto 0);
			ir3_5 : in std_logic_vector(2 downto 0);
			ir6_8 : in std_logic_vector(2 downto 0);
			ir9_11 : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_address : out std_logic_vector(2 downto 0));
end entity;


architecture Rf_A3_input_arch of Rf_A3_input is
 begin
    process (current_state,pe_out,ir3_5,ir6_8,ir9_11)
    begin
	 if current_state = "00111" then
		update_address <= ir3_5;
	 elsif current_state = "00110" then
		update_address <= ir6_8;
	 elsif current_state = "01000" or current_state = "01100" or current_state = "01101" or current_state = "10010" then
		update_address <= ir9_11;
	 elsif current_state = "01110" then
		update_address <= pe_out;
	 else
		update_address <= (others=>'0');
	 end if;
    end process;
end architecture;