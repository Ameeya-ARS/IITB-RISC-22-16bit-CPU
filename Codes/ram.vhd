library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
	port(
			address: in std_logic_vector(15 downto 0);
			data_in: in std_logic_vector(15 downto 0);
			write_in: in std_logic;
			clock: in std_logic;
			data_out: out std_logic_vector(15 downto 0)
			);
end ram;

architecture ram_arch of ram is

	type ram_array is array(0 to 127) of std_logic_vector(15 downto 0);

	signal ram_data: ram_array := ("0001001010011011",others=>"0000000000000000");
	
begin
process(clock)
begin
	if(rising_edge(clock)) then
		if(write_in='1') then
			ram_data(to_integer(unsigned(address(6 downto 0)))) <= data_in;
		end if;
	end if;
	
end process;

	data_out <= ram_data(to_integer(unsigned(address(6 downto 0))));

end ram_arch;