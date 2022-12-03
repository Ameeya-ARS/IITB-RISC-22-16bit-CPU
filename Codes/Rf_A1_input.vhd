library ieee;
use ieee.std_logic_1164.all;

entity Rf_A1_input is
	port (ir9_11 : in std_logic_vector(2 downto 0);
			ir6_8 : in std_logic_vector(2 downto 0);
			pe_out : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_address : out std_logic_vector(2 downto 0));
end entity;


architecture Rf_A1_input_Arch of Rf_A1_input is
 begin
    process (current_state,ir9_11,ir6_8,pe_out)
    begin
	 if current_state = "00010" then
		update_address <= ir9_11;
	 elsif current_state = "01101" then
		update_address <= ir6_8;
	 elsif current_state = "01111" then
		update_address <= pe_out;
	 else
		update_address <= (others=>'0');
	 end if;
    end process;
end architecture;