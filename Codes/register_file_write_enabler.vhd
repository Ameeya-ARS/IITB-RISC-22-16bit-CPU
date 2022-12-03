library ieee;
use ieee.std_logic_1164.all;

entity register_file_write_enabler is
	port (Rf_A3 : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			R0_en, R1_en, R2_en, R3_en, R4_en, R5_en, R6_en, R7_en : out std_logic);
end entity;


architecture register_file_write_enabler_arch of register_file_write_enabler is
		begin
			process (Rf_A3, current_state)
			begin
				if (current_state = "00110") or (current_state = "00111") or (current_state = "01000") or (current_state = "01100") or (current_state = "01101") or (current_state = "01110") or (current_state = "10010") or (current_state = "10100") then
					if Rf_A3 = "000" then
						R0_en <= '1';
						R1_en <= '0';
						R2_en <= '0';
						R3_en <= '0';
						R4_en <= '0';
						R5_en <= '0';
						R6_en <= '0';
						R7_en <= '0';
					elsif Rf_A3 = "001" then
						R0_en <= '0';
						R1_en <= '1';
						R2_en <= '0';
						R3_en <= '0';
						R4_en <= '0';
						R5_en <= '0';
						R6_en <= '0';
						R7_en <= '0';
					elsif Rf_A3 = "010" then
						R0_en <= '0';
						R1_en <= '0';
						R2_en <= '1';
						R3_en <= '0';
						R4_en <= '0';
						R5_en <= '0';
						R6_en <= '0';
						R7_en <= '0';
					elsif Rf_A3 = "011" then
						R0_en <= '0';
						R1_en <= '0';
						R2_en <= '0';
						R3_en <= '1';
						R4_en <= '0';
						R5_en <= '0';
						R6_en <= '0';
						R7_en <= '0';
					elsif Rf_A3 = "100" then
						R0_en <= '0';
						R1_en <= '0';
						R2_en <= '0';
						R3_en <= '0';
						R4_en <= '1';
						R5_en <= '0';
						R6_en <= '0';
						R7_en <= '0';
					elsif Rf_A3 = "101" then
						R0_en <= '0';
						R1_en <= '0';
						R2_en <= '0';
						R3_en <= '0';
						R4_en <= '0';
						R5_en <= '1';
						R6_en <= '0';
						R7_en <= '0';
					elsif Rf_A3 = "110" then
						R0_en <= '0';
						R1_en <= '0';
						R2_en <= '0';
						R3_en <= '0';
						R4_en <= '0';
						R5_en <= '0';
						R6_en <= '1';
						R7_en <= '0';
					elsif Rf_A3 = "111" then
						R0_en <= '0';
						R1_en <= '0';
						R2_en <= '0';
						R3_en <= '0';
						R4_en <= '0';
						R5_en <= '0';
						R6_en <= '0';
						R7_en <= '1';
					else
						R0_en <= '0';
						R1_en <= '0';
						R2_en <= '0';
						R3_en <= '0';
						R4_en <= '0';
						R5_en <= '0';
						R6_en <= '0';
						R7_en <= '0';
					end if;
				else
					R0_en <= '0';
					R1_en <= '0';
					R2_en <= '0';
					R3_en <= '0';
					R4_en <= '0';
					R5_en <= '0';
					R6_en <= '0';
					R7_en <= '0';
			end if;

			end process;
end architecture;