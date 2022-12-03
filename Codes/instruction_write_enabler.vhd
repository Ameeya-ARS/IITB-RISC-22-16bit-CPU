library ieee;
use ieee.std_logic_1164.all;

entity instruction_write_enabler is
	port (current_state : in std_logic_vector(4 downto 0);
			enable : out std_logic);
end entity;


architecture instruction_write_enabler_arch of instruction_write_enabler is
  begin
    process (current_state)
    begin
		if current_state = "00001" then
			enable <= '1';
		else
			enable <= '0';
		end if;
    end process;
end architecture;