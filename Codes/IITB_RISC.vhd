library ieee;
use ieee.std_logic_1164.all;

entity IITB_RISC is
	port (clock : IN STD_LOGIC);
end IITB_RISC;


architecture IITB_RISC_arch of IITB_RISC is

	component NextStateLogic is
	port (current_state: IN STD_LOGIC_VECTOR(4 downto 0);
        op_code: IN STD_LOGIC_VECTOR(3 downto 0);
        condition: IN STD_LOGIC_VECTOR(1 downto 0);
        C, Z: IN STD_LOGIC;
        temp : IN STD_LOGIC;
        PE0: IN STD_LOGIC;
        next_state: OUT STD_LOGIC_VECTOR(4 downto 0));
	end component;

	component alu is
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
	end component;

	component ram is
	port(
			address: in std_logic_vector(15 downto 0);
			data_in: in std_logic_vector(15 downto 0);
			write_in: in std_logic;
			clock: in std_logic;
			data_out: out std_logic_vector(15 downto 0));
	end component;

	component mem_address_in is
	port (T1 : in std_logic_vector(15 downto 0);
			PC : in std_logic_vector(15 downto 0);
			T2 : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			mem_address : out std_logic_vector(15 downto 0));
	end component;

	component write_memory is
	port (T1 : in std_logic_vector(15 downto 0);
			T2 : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			data : out std_logic_vector(15 downto 0);
			enable : out std_logic);
	end component;

	component instruction_write_enabler is
	port (current_state : in std_logic_vector(4 downto 0);
			enable : out std_logic);
	end component;

	component reset_state is
	port (current_state : IN STD_LOGIC_VECTOR(4 downto 0);
        clear : OUT STD_LOGIC);
	end component;
	
	component reg_1bit is
	port (input_data: in std_logic;
			enabler : in std_logic;
			reset : in std_logic;
			clock : in std_logic;
			output_data : out std_logic);
	end component;
	
  component reg is
  generic(size: integer:=16);
  port(input_data: in std_logic_vector(size-1 downto 0);
		 output_data: out std_logic_vector(size-1 downto 0);
		 reset: in std_logic;
		 clock: in std_logic;
		 enabler: in std_logic);
  end component;

	component conditional_reg is
	generic(size: integer:=16);
	port(input_data: in std_logic_vector(size-1 downto 0);
			input_data2: in std_logic_vector(size-1 downto 0);
			output_data: out std_logic_vector(size-1 downto 0);
			reset: in std_logic;
			clock: in std_logic;
			enabler: in std_logic;
			enabler2: in std_logic);
	end component;

	component priority_encoder is
	port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (2 downto 0);
			  v: out STD_Logic );
	end component;
	
	component pe_enabler is
	port (current_state : in std_logic_vector(4 downto 0);
        pe_enable : out std_logic);
	end component;

	component pe_modifier is
	port (PEReg : in std_logic_vector(7 downto 0);
			PE_out : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			PE_zero_enable : out std_logic;
			ModifiedPEReg : out std_logic_vector(7 downto 0));
	end component;

   component reg_file_access is
   port (R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(15 downto 0);
				address : in std_logic_vector(2 downto 0);
				data : out std_logic_vector(15 downto 0));
   end component;

   component register_file_write_enabler is
	port (Rf_A3 : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			R0_en, R1_en, R2_en, R3_en, R4_en, R5_en, R6_en, R7_en : out std_logic);
   end component;

   component Rf_A1_input is
	port (ir9_11 : in std_logic_vector(2 downto 0);
			ir6_8 : in std_logic_vector(2 downto 0);
			pe_out : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_address : out std_logic_vector(2 downto 0));
   end component;

   component Rf_D3_input is
	port (T1 : in std_logic_vector(15 downto 0);
			T2 : in std_logic_vector(15 downto 0);
			right_sign_extended : in std_logic_vector(15 downto 0);
			R7 : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			data : out std_logic_vector(15 downto 0));
   end component;

	component Rf_A3_input is
	port (Pe_out : in std_logic_vector(2 downto 0);
			ir3_5 : in std_logic_vector(2 downto 0);
			ir6_8 : in std_logic_vector(2 downto 0);
			ir9_11 : in std_logic_vector(2 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_address : out std_logic_vector(2 downto 0));
	end component;

	component T1_data_input is
	port (Rf_D1 : in std_logic_vector(15 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_value : out std_logic_vector(15 downto 0);
			write_enable : out std_logic);
	end component;

	component T2_data_input is
	port (Rf_D1 : in std_logic_vector(15 downto 0);
			Rf_D2 : in std_logic_vector(15 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			mem_d : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_value : out std_logic_vector(15 downto 0);
			write_enable : out std_logic);
	end component;

	component r7_update_value is
	port (Rf_D1 : in std_logic_vector(15 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			PC : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_value : out std_logic_vector(15 downto 0);
			r7_enable : out std_logic);
	end component;

   component sign_extend is
	generic(	input_size: integer := 6;
				output_size: integer := 16);
	port(input: in std_logic_vector(input_size-1 downto 0);
			output: out std_logic_vector(output_size-1 downto 0));
   end component;

   component right_sign_extend is
	port (input_data : IN STD_LOGIC_VECTOR(8 downto 0);
			output_data : OUT STD_LOGIC_VECTOR(15 downto 0));
   end component;

	component pc_update_value is
	port (Rf_D1 : in std_logic_vector(15 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			current_state : in std_logic_vector(4 downto 0);
			update_value : out std_logic_vector(15 downto 0);
			pc_enable : out std_logic);
	end component;


    -- SIGNALS
    signal clear : STD_LOGIC;
	 
    signal T1_in : STD_LOGIC_VECTOR(15 downto 0);
    signal T2_in : STD_LOGIC_VECTOR(15 downto 0);

    signal T1_out : STD_LOGIC_VECTOR(15 downto 0);
    signal T2_out : STD_LOGIC_VECTOR(15 downto 0);

	 signal PC_in : STD_LOGIC_VECTOR(15 downto 0);
	 signal PC_out : STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";

    signal C_in : STD_LOGIC;
    signal C_out : STD_LOGIC;

    signal Z_in : STD_LOGIC;
    signal Z_out : STD_LOGIC;

		signal temp_z : STD_LOGIC;

    signal alu_out : STD_LOGIC_VECTOR(15 downto 0);

    signal SE_6bit : STD_LOGIC_VECTOR(15 downto 0);
    signal SE_9bit : STD_LOGIC_VECTOR(15 downto 0);
    signal SE9_right_extend : STD_LOGIC_VECTOR(15 downto 0);

    signal instruction : STD_LOGIC_VECTOR(15 downto 0);
    signal current_state : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	 signal next_state : STD_LOGIC_VECTOR(4 downto 0);

    -- REGISTERS
    signal R0 : STD_LOGIC_VECTOR(15 downto 0); signal R0_en : STD_LOGIC;
    signal R1 : STD_LOGIC_VECTOR(15 downto 0); signal R1_en : STD_LOGIC;
    signal R2 : STD_LOGIC_VECTOR(15 downto 0); signal R2_en : STD_LOGIC;
    signal R3 : STD_LOGIC_VECTOR(15 downto 0); signal R3_en : STD_LOGIC;
    signal R4 : STD_LOGIC_VECTOR(15 downto 0); signal R4_en : STD_LOGIC;
    signal R5 : STD_LOGIC_VECTOR(15 downto 0); signal R5_en : STD_LOGIC;
    signal R6 : STD_LOGIC_VECTOR(15 downto 0); signal R6_en : STD_LOGIC;
    signal R7 : STD_LOGIC_VECTOR(15 downto 0); signal R7_en : STD_LOGIC;
	
	 signal R7_in : STD_LOGIC_VECTOR(15 downto 0); --Enable in enable pins section

	 signal PEReg : STD_LOGIC_VECTOR(7 downto 0);
	 signal PE0 : STD_LOGIC;
	 signal PE_out : STD_LOGIC_VECTOR(2 downto 0);
	 signal ModifiedPEReg : STD_LOGIC_VECTOR(7 downto 0);

    signal Rf_d1 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_d2 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_d3 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_a1 : STD_LOGIC_VECTOR(2 downto 0);
    signal Rf_a2 : STD_LOGIC_VECTOR(2 downto 0);
    signal Rf_a3 : STD_LOGIC_VECTOR(2 downto 0);

		signal mem_d : STD_LOGIC_VECTOR(15 downto 0);
		signal mem_a : STD_LOGIC_VECTOR(15 downto 0);
		signal mem_data_in : STD_LOGIC_VECTOR(15 downto 0);

    -- CONTROL SIGNALS
    signal C_enabler : STD_LOGIC;
    signal Z_enabler : STD_LOGIC;
    signal T1_write_enabler: STD_LOGIC;
    signal T2_write_enabler: STD_LOGIC;
	 signal PC_enable : STD_LOGIC;
	 signal R7_direct_enable : STD_LOGIC;
	 signal PE_enable : STD_LOGIC;
	 signal PE_Z_enabler : STD_LOGIC;
	 signal instruction_write_enable : STD_LOGIC;
	 signal memory_write_enable : STD_LOGIC;

	begin
		NextState0 : NextStateLogic 
		port map(current_state=>current_state, op_code=>instruction(15 downto 12), condition=>instruction(1 downto 0), C=>C_out, Z=>Z_out, temp=>temp_z, PE0=>PE0, next_state=>next_state);
		
		StateTransition: reg
		generic map(5)
		port map(input_data=>next_state, enabler=>'1', reset=>'0', clock=>clock, output_data=>current_state);

		reset: reset_state 
		port map (current_state=>current_state, clear=>clear);

		memory0: ram 
		port map (address=>mem_a, data_in=>mem_data_in, write_in=>memory_write_enable, clock=>clock, data_out=>mem_d);
		
		memory_write: write_memory 
		port map (T1=>T1_out, T2=>T2_out, current_state=>current_state, data=>mem_data_in, enable=>memory_write_enable);
		
		memory_address_mux: mem_address_in 
		port map (T1=>T1_out, PC=>PC_out, T2=>T2_out, current_state=>current_state, mem_address=>mem_a);
		
		instruction_write_en: instruction_write_enabler 
		port map (current_state=>current_state, enable=>instruction_write_enable);
		
		instruction_get: reg 
		generic map(16)
		port map (input_data=>mem_d, enabler=>instruction_write_enable, reset=>clear, clock=>clock, output_data=>instruction);

		Carry_flag: reg_1bit 
		port map(input_data=>C_in, enabler=>C_enabler, reset=>clear, clock=>clock, output_data=>C_out);
    
		Zero_flag: reg_1bit
		port map(input_data=>Z_in, enabler=>Z_enabler, reset=>clear, clock=>clock, output_data=>Z_out);

		T1: reg
		generic map(16)
		port map(input_data=>T1_in, enabler=>T1_write_enabler, reset=>clear, clock=>clock, output_data=>T1_out);
		
		T2: reg
		generic map(16)
		port map(input_data=>T2_in, enabler=>T2_write_enabler, reset=>clear, clock=>clock, output_data=>T2_out);

		alu1: alu 
		port map (current_state=>current_state, op_code=>instruction(15 downto 12), PC=>PC_out, T1=>T1_out, T2=>T2_out, SE_6bit=>SE_6bit, SE_9bit=>SE_9bit, alu_out=>ALU_out, C_out=>C_in, C_enabler=>C_enabler, Z_out=>Z_in, Z_enabler=>Z_enabler, alu_temp_z=>temp_z);

		SE6: sign_extend
		generic map(6,16)
		port map(input=>instruction(5 downto 0), output=>SE_6bit);
    
		SE9: sign_extend
		generic map(9,16)
		port map(input=>instruction(8 downto 0), output=>SE_9bit);
    
		SE9spl: right_sign_extend -- Padding of zeros on right side
		port map(input_data=>instruction(8 downto 0), output_data=>SE9_right_extend);

		RegisterFile1: reg_file_access 
		port map(R0=>R0, R1=>R1, R2=>R2, R3=>R3, R4=>R4, R5=>R5, R6=>R6, R7=>R7, address=>Rf_a1, data=>Rf_d1);
    
		RegisterFile2: reg_file_access 
		port map(R0=>R0, R1=>R1, R2=>R2, R3=>R3, R4=>R4, R5=>R5, R6=>R6, R7=>R7, address=>Rf_a2, data=>Rf_d2);

    RegisterWriteEnable: register_file_write_enabler 
	 port map(Rf_A3=>Rf_a3, current_state=>current_state, R0_en=>R0_en, R1_en=>R1_en, R2_en=>R2_en, R3_en=>R3_en, R4_en=>R4_en, R5_en=>R5_en, R6_en=>R6_en, R7_en=>R7_en);
    
	 Register0: reg
	 generic map(16)
	 port map(input_data=>Rf_d3, enabler=>R0_en, reset=>clear, clock=>clock, output_data=>R0);
	 Register1: reg
	 generic map(16)
	 port map(input_data=>Rf_d3, enabler=>R1_en, reset=>clear, clock=>clock, output_data=>R1);
	 Register2: reg
	 generic map(16)
	 port map(input_data=>Rf_d3, enabler=>R2_en, reset=>clear, clock=>clock, output_data=>R2);
	 Register3: reg
	 generic map(16)
	 port map(input_data=>Rf_d3, enabler=>R3_en, reset=>clear, clock=>clock, output_data=>R3);
	 Register4: reg
	 generic map(16)
	 port map(input_data=>Rf_d3, enabler=>R4_en, reset=>clear, clock=>clock, output_data=>R4);
	 Register5: reg
	 generic map(16)
	 port map(input_data=>Rf_d3, enabler=>R5_en, reset=>clear, clock=>clock, output_data=>R5);
	 Register6: reg
	 generic map(16)
	 port map(input_data=>Rf_d3, enabler=>R6_en, reset=>clear, clock=>clock, output_data=>R6);

	 Register7: conditional_reg
	 generic map(16)
	 port map(input_data=>R7_in, input_data2=>Rf_d3, enabler=>R7_direct_enable, enabler2=>R7_en, reset=>clear, clock=>clock, output_data=>R7);

    RegisterInputA: Rf_A1_input 
	 port map(ir9_11=>instruction(11 downto 9), ir6_8=>instruction(8 downto 6), pe_out=>PE_out, current_state=>current_state, update_address=>Rf_a1);
    
	 RegisterInputB: Rf_a2 <= instruction(8 downto 6);
    
	 RegisterInputC: Rf_A3_input
	 port map(ir3_5=>instruction(5 downto 3), ir6_8=>instruction(8 downto 6), ir9_11=>instruction(11 downto 9), Pe_out=>PE_out, current_state=>current_state, update_address=>Rf_a3);
    
	 RegisterInputD3: Rf_D3_input
	 port map(T1=>T1_out, right_sign_extended=>SE9_right_extend, R7=>R7, T2=>T2_out, current_state=>current_state, data=>Rf_d3);

	 TempRegA: T1_data_input 
	 port map(Rf_D1=>Rf_d1, alu_out=>alu_out, current_state=>current_state, update_value=>T1_in, write_enable=>T1_write_enabler);
		
	 TempRegB: T2_data_input
	 port map(Rf_D2=>Rf_d2, alu_out=>alu_out, mem_d=>mem_d, RF_D1=>Rf_d1, current_state=>current_state, update_value=>T2_in, write_enable=>T2_write_enabler);

	 PCInput: pc_update_value
	 port map (Rf_D1=>Rf_d1, alu_out=>alu_out, current_state=>current_state, update_value=>PC_in, pc_enable=>PC_enable);

	 R7Input: r7_update_value 
	 port map (Rf_D1=>Rf_d1, alu_out=>alu_out, PC=>PC_out, current_state=>current_state, update_value=>R7_in, r7_enable=>R7_direct_enable);

	 Conditional_PC_Input: conditional_reg
	 generic map(16)
	 port map (input_data=>Rf_d3, input_data2=>PC_in, enabler=>R7_en, enabler2=>PC_enable, reset=>clear, clock=>clock, output_data=>PC_out);

	 PEEnableBlock : pe_enabler 
	 port map (current_state=>current_state, pe_enable=>PE_enable);
	 
	 PEBlock: priority_encoder
	 port map (input=>PEReg, output=>PE_out, v=>PE0);

	 PriorityModif : pe_modifier
	 port map (PEReg=>PEReg, PE_out=>PE_out, current_state=>current_state, PE_zero_enable=>PE_Z_enabler, ModifiedPEReg=>ModifiedPEReg);

	 PriorityEncoderCondition: conditional_reg
	 generic map(8)
	 port map (input_data=>instruction(7 downto 0), input_data2=>ModifiedPEReg, enabler=>PE_enable, enabler2=>PE_Z_enabler, reset=>clear, clock=>clock, output_data=>PEReg);

end architecture;