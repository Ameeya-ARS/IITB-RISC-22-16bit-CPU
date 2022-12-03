library ieee;
use ieee.std_logic_1164.all;

entity pe_modifier is
	port (PEReg : in std_logic_vector(7 downto 0);
			PE_out : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			PE_zero_enable : out std_logic;
			ModifiedPEReg : out std_logic_vector(7 downto 0));
end entity;


architecture pe_modifier_arch of pe_modifier is
		begin
			process (PEReg, PE_out, current_state)
			begin
					if current_state = "01110" or current_state = "01111" then
							if PE_out = "111" then
								ModifiedPEReg(7 downto 1) <= PEReg(7 downto 1);
								ModifiedPEReg(0) <= '0';
								PE_zero_enable <= '1';

							elsif PE_out = "110" then
								ModifiedPEReg(7 downto 2) <= PEReg(7 downto 2);
								ModifiedPEReg(1) <= '0';
								ModifiedPEReg(0) <= PEReg(0);
								PE_zero_enable <= '1';

							elsif PE_out = "101" then
								ModifiedPEReg(7 downto 3) <= PEReg(7 downto 3);
								ModifiedPEReg(2) <= '0';
								ModifiedPEReg(1 downto 0) <= PEReg(1 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "100" then
								ModifiedPEReg(7 downto 4) <= PEReg(7 downto 4);
								ModifiedPEReg(3) <= '0';
								ModifiedPEReg(2 downto 0) <= PEReg(2 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "011" then
								ModifiedPEReg(7 downto 5) <= PEReg(7 downto 5);
								ModifiedPEReg(4) <= '0';
								ModifiedPEReg(3 downto 0) <= PEReg(3 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "010" then
								ModifiedPEReg(7 downto 6) <= PEReg(7 downto 6);
								ModifiedPEReg(5) <= '0';
								ModifiedPEReg(4 downto 0) <= PEReg(4 downto 0);
								PE_zero_enable <= '1';

							elsif PE_out = "001" then
								ModifiedPEReg(7 downto 7) <= PEReg(7 downto 7);
								ModifiedPEReg(6) <= '0';
								ModifiedPEReg(5 downto 0) <= PEReg(5 downto 0);
								PE_zero_enable <= '1';

							else
								ModifiedPEReg(7) <= '0';
								ModifiedPEReg(6 downto 0) <= PEReg(6 downto 0);
								PE_zero_enable <= '1';
							end if;

					else
							PE_zero_enable <= '0';
							ModifiedPEReg(7 downto 0) <= PEReg(7 downto 0);
					end if;
			end process;
end architecture;