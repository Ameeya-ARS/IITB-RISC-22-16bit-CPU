library ieee;
use ieee.std_logic_1164.all;

entity mem_address_in is
	port (T1 : in std_logic_vector(15 downto 0);
			PC : in std_logic_vector(15 downto 0);
			T2 : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			mem_address : out std_logic_vector(15 downto 0));
end entity;


architecture mem_address_in_arch of mem_address_in is
  begin
    process (current_state, T1, T2, PC)
    begin
	 if current_state = "10000" or current_state = "01010" then
		mem_address <= T1;
	 elsif current_state = "00001" then
		mem_address <= PC;
	 elsif current_state = "01001" or current_state = "01011" then
		mem_address <= T2;
	 else
		mem_address <= (others=>'0');
	 end if;
    end process;
end architecture;