library ieee;
use ieee.std_logic_1164.all;

entity pe_enabler is
	port (current_state : in std_logic_vector(4 downto 0);
        pe_enable : out std_logic);
end entity;


architecture pe_enabler_arch of pe_enabler is
	begin
		process (current_state)
		begin
			if current_state = "00010" then
				pe_enable <= '1';
			else
				pe_enable <= '0';
			end if;
		end process;
end architecture;