library ieee;
use ieee.std_logic_1164.all;

entity reg_file_access is
	port (R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(15 downto 0);
				address : in std_logic_vector(2 downto 0);
				data : out std_logic_vector(15 downto 0));
end entity;


architecture reg_file_access_arch of reg_file_access is
		begin
			process (address, R0, R1, R2, R3, R4, R5, R6, R7)
			begin
				case address is
					when "000" =>
	                data <= R0;
					when "001" =>
	                data <= R1;
					when "010" =>
	                data <= R2;
					when "011" =>
	                data <= R3;
					when "100" =>
	                data <= R4;
					when "101" =>
	                data <= R5;
					when "110" =>
	                data <= R6;
					when "111" =>
	                data <= R7;
					when others =>
						 data <= R0;
	      end case;
			end process;
end architecture;