library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity priority_encoder is
    port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (2 downto 0);
			  v: out STD_Logic 
			 );
end entity;

architecture priority_encoder_arch of priority_encoder is

begin
   process(input)
   begin
      if (input(7)='1') then
         output <= "000";
			v <= '0';
      elsif (input(6)='1') then
         output <= "001";
			v <= '0';
      elsif (input(5)='1') then
         output <= "010";
			v <= '0';
      elsif (input(4)='1') then
         output <= "011";
			v <= '0';
		elsif (input(3)='1') then
         output <= "100";
			v <= '0';
      elsif (input(2)='1') then
         output <= "101";
			v <= '0';
      elsif (input(1)='1') then
         output <= "110";
			v <= '0';
		elsif (input(0)='1') then
         output <= "111";
			v <= '0';
      else
         output <= "000";
			v <= '1';
   end if;
end process;

end architecture;