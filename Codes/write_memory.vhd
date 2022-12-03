library ieee;
use ieee.std_logic_1164.all;

entity write_memory is
	port (T1 : in std_logic_vector(15 downto 0);
			T2 : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			data : out std_logic_vector(15 downto 0);
			enable : out std_logic);
end entity;


architecture write_memory_Arch of write_memory is
  begin
    process (current_state, T1, T2)
    begin
		if current_state = "01011" then
			data <= T1;
			enable <= '1';
		elsif current_state = "10000" then
			data <= T2;
			enable <= '1';
		else
			data <= (others => '0');
			enable <= '0';
		end if;
    end process;
end architecture;