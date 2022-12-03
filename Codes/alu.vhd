library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (current_state: in std_logic_vector(4 downto 0);
        op_code: in std_logic_vector(3 downto 0);
        PC: in std_logic_vector(15 downto 0);
        T1: in std_logic_vector(15 downto 0);
        T2: in std_logic_vector(15 downto 0);
        SE_6bit: in std_logic_vector(15 downto 0);
        SE_9bit: in std_logic_vector(15 downto 0);
        alu_out: out std_logic_vector(15 downto 0);
        C_out: out std_logic; C_enabler: out std_logic;
        Z_out: out std_logic; Z_enabler: out std_logic;
        alu_temp_z : out std_logic);
end entity;

architecture alu_arch of alu is
  constant one: std_logic_vector(15 downto 0) := "0000000000000001";
  constant zero: std_logic_vector(15 downto 0) := "0000000000000000";
  begin
    process (current_state, op_code, PC, T1, T2, SE_6bit, SE_9bit)
	 variable temp_output: std_logic_vector(15 downto 0);
	 variable temp : std_logic_vector(15 downto 0);
    begin
        if current_state = "00001" then
                alu_out <= std_logic_vector(unsigned(PC) + unsigned(one));
                C_out <= '0'; --dont care
                C_enabler <= '0';
                Z_out <= '0'; --dont care
                Z_enabler <= '0';
                alu_temp_z <= '0';
        elsif current_state = "01100" then
                alu_out <= std_logic_vector(unsigned(PC) + unsigned(SE_9bit) - unsigned(one));
                C_out <= '0'; --dont care
                C_enabler <= '0';
                Z_out <= '0'; --dont care
                Z_enabler <= '0';
                alu_temp_z <= '0';
		  elsif current_state = "10100" then
					 alu_out <= std_logic_vector(unsigned(T1) + unsigned(SE_9bit));
                C_out <= '0'; --dont care
                C_enabler <= '0';
                Z_out <= '0'; --dont care
                Z_enabler <= '0';
                alu_temp_z <= '0';
        elsif current_state = "10001" then
                alu_out <= std_logic_vector(unsigned(PC) + unsigned(SE_6bit) - unsigned(one));
                C_out <= '0'; --dont care
                C_enabler <= '0';
                Z_out <= '0'; --dont care
                Z_enabler <= '0';
                alu_temp_z <= '0';
        elsif current_state = "00100" then
                alu_out <= std_logic_vector(unsigned(T2) + unsigned(SE_6bit));
                C_out <= '0'; --dont care
                C_enabler <= '0';
                Z_out <= '0'; --dont care
                Z_enabler <= '0';
                alu_temp_z <= '0';
        elsif current_state = "01110" or current_state = "10000" then
                alu_out <= std_logic_vector(unsigned(T1) + unsigned(one));
                C_out <= '0'; --dont care
                C_enabler <= '0';
                Z_out <= '0'; --dont care
                Z_enabler <= '0';
                alu_temp_z <= '0';
        elsif current_state = "00011" then
                alu_out <= std_logic_vector(unsigned(T1) + unsigned(SE_6bit));
                temp_output := std_logic_vector(unsigned(T1) + unsigned(SE_6bit));
                C_out <= (T1(15) and SE_6bit(15) and (not temp_output(15))) or ((not T1(15)) and (not SE_6bit(15)) and temp_output(15));
                C_enabler <= '1';
                Z_enabler <= '1';
                if temp_output = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                alu_temp_z <= '0';
        elsif current_state = "10010" then
                alu_out <= std_logic_vector(unsigned(T2) + unsigned(zero));
                C_out <= '0'; --dont care
                C_enabler <= '0';
                Z_enabler <= '1';
                temp_output := std_logic_vector(unsigned(T2) + unsigned(zero));
                if temp_output = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                alu_temp_z <= '0';
				elsif current_state = "10011" then
					temp(15 downto 0) := T2(14 downto 0) & '0';
					alu_out <= std_logic_vector(unsigned(temp) + unsigned(T1));
                temp_output := std_logic_vector(unsigned(temp) + unsigned(T1));
                C_out <= (T1(15) and temp(15) and (not temp_output(15))) or ((not T1(15)) and (not temp(15)) and temp_output(15));
                C_enabler <= '1';
                Z_enabler <= '1';
                if temp_output = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                alu_temp_z <= '0';
					
        elsif current_state = "00101" then
              if op_code = "0001" then
                alu_out <= std_logic_vector(unsigned(T2) + unsigned(T1));
                temp_output := std_logic_vector(unsigned(T2) + unsigned(T1));
                C_out <= (T1(15) and T2(15) and (not temp_output(15))) or ((not T1(15)) and (not T2(15)) and temp_output(15));
                C_enabler <= '1';
                Z_enabler <= '1';
                if temp_output = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                alu_temp_z <= '0';
              elsif op_code = "0010" then
                alu_out <= T1 nand T2;
                C_out <= '0';
                C_enabler <= '0';
                Z_enabler <= '1';
                temp_output := T1 nand T2;
                if temp_output = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                alu_temp_z <= '0';
              elsif op_code = "1000" then
                alu_out <= "0000000000000001"; --dont care
                C_out <= '0';
                C_enabler <= '0';
                Z_enabler <= '0';
                Z_out <= '0';
                if T1 = T2 then
                  alu_temp_z <= '1';
                else
                  alu_temp_z <= '0';
                end if;
              else
                alu_out <= "0000000000000001"; --dont care
                C_out <= '0';
                C_enabler <= '0';
                Z_enabler <= '0';
                Z_out <= '0';
                alu_temp_z <= '0';
              end if;
        else
            alu_out <= "0000000000000001"; --dont care
            C_out <= '0';
            C_enabler <= '0';
            Z_enabler <= '0';
            Z_out <= '0';
            alu_temp_z <= '0';
		 end if;
    end process;
end architecture;