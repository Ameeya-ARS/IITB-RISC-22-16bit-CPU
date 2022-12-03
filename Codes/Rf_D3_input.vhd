library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Rf_D3_input is
	port (T1 : in std_logic_vector(15 downto 0);
			T2 : in std_logic_vector(15 downto 0);
			right_sign_extended : in std_logic_vector(15 downto 0);
			R7 : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			data : out std_logic_vector(15 downto 0));
end entity;


architecture Rf_D3_input_arch of Rf_D3_input is
constant one: std_logic_vector(15 downto 0) := "0000000000000001";
 begin
    process (current_state,T1,T2,R7,right_sign_extended)
    begin
	 if current_state = "00110" or current_state = "00111" then
		data <= T1;
	 elsif current_state = "01000" then
		data <= right_sign_extended;
	 elsif current_state = "01100" or current_state = "01101" then
		data <= std_logic_vector(unsigned(R7) + unsigned(one));
	 elsif current_state = "01110" or current_state = "10010" then
		data <= T2;
	 else
		data <= (others=>'0');
	 end if;
    end process;
end architecture;