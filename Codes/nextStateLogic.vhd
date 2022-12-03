library ieee;
use ieee.std_logic_1164.all;

entity nextStateLogic is
  port (current_state: IN STD_LOGIC_VECTOR(4 downto 0);
        op_code: IN STD_LOGIC_VECTOR(3 downto 0);
        condition: IN STD_LOGIC_VECTOR(1 downto 0);
        C, Z: IN STD_LOGIC;
        temp : IN STD_LOGIC;
        PE0: IN STD_LOGIC;
        next_state: OUT STD_LOGIC_VECTOR(4 downto 0));
end entity;


architecture nextStateLogic_arch of nextStateLogic is

begin

    process (current_state, op_code, C, Z, condition, PE0, temp)

    begin

        if ( current_state = "00000" ) then

            next_state <= "00001" ;

        elsif ( current_state = "00001" ) then
            
            next_state <= "00010" ;
        
        elsif ( current_state = "00010" ) then

            if ( op_code = "0000" ) then
                next_state <= "00011" ;
            elsif ( op_code = "0011" ) then
                next_state <= "01000" ;
            elsif ( op_code = "1001" ) then
                next_state <= "01100" ;
            elsif ( op_code = "1011" ) then
                next_state <= "10100" ;
            elsif ( op_code = "1010" ) then
                next_state <= "01101";
            elsif ( op_code = "1101" ) then
                next_state <= "01010";
            elsif ( op_code = "1100" ) then
                next_state <= "01111";
            elsif ( op_code = "0101" or op_code = "0111" ) then
                next_state <= "00100" ;
            elsif ( op_code = "0001" and condition = "11" ) then
                next_state <= "10011";
            elsif ((op_code = "1000") OR (((op_code = "0001") OR (op_code = "0010")) AND ((condition = "00") OR (condition = "01" AND Z='1') OR (condition = "10" AND C='1'))))  then
                next_state <= "00101" ;
            else
                next_state <= "00001" ;
            end if ;
        
        elsif ( current_state = "00011" ) then
            next_state <= "00110" ;
        
        elsif ( current_state = "00101" ) then

            if ( op_code = "0001" or op_code = "0010" ) then
                next_state <= "00111" ;
            elsif (op_code = "1000" AND temp = '1') then
                next_state <= "10001";
            else
                next_state <= "00001" ;
            end if ;
        
        elsif ( current_state = "00100" ) then

            if ( op_code = "0101" ) then
                next_state <= "01001" ;
            else    
                next_state <= "01011";
            end if ;
        
        elsif ( current_state = "00110" ) then

            next_state <= "00001" ;
        
        elsif ( current_state = "00111" ) then

            next_state <= "00001" ;
        
        elsif ( current_state = "01000" ) then

            next_state <= "00001" ;
        
        elsif ( current_state = "01001" ) then

            next_state <= "10010";
        
        elsif ( current_state = "01010" ) then

            if ( PE0 = '1' ) then
                next_state <= "00001" ;
            else
                next_state <= "01110";
            end if ;
        elsif ( current_state = "01011" ) then
            next_state <= "00001" ;
        
        elsif ( current_state = "01100" ) then

            next_state <= "00001" ;
        
        elsif ( current_state = "01101" ) then  

            next_state <= "00001" ;
        
        elsif ( current_state = "01110" ) then

            next_state <= "01010" ;
        
        elsif ( current_state = "01111" ) then

            if( PE0 = '1' ) then
                next_state <= "00001" ;
            else
                next_state <= "10000" ;
            end if ;

        elsif ( current_state = "10000" ) then

            next_state <= "01111";
        
        elsif ( current_state = "10001" ) then

            next_state <= "00001" ;
        
        elsif ( current_state = "10010" ) then

            next_state <= "00001" ;
        
        elsif ( current_state = "10011" ) then

            next_state <= "00111" ;
        
        else

            next_state <= "00001" ;

        end if ;

    end process ;   

end architecture ;