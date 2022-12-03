library ieee;
use ieee.std_logic_1164.all;

entity reset_state is
	port (current_state : IN STD_LOGIC_VECTOR(4 downto 0);
        clear : OUT STD_LOGIC);
end entity;


architecture reset_state_arch of reset_state is

	begin
		process (current_state)
		begin
			if current_state >= "00001" and current_state <= "10100" then
				clear <= '0';
			else
				clear <= '1';
			end if;
		end process;
end architecture;
