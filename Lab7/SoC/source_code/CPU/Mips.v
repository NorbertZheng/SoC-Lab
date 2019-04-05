module Mips(clk, reset, MIO_ready, inst_in, Data_in, mem_w, PC_out, Addr_out, Data_out, CPU_MIO, INT, DEBUG_SW, DEBUG_BTN, DEBUG_INFO);
	input clk;
	input reset;
	input MIO_ready;
	input[31:0] inst_in;
	input[31:0] Data_in;	
	output mem_w;
	output[31:0] PC_out;
	output[31:0] Addr_out;
	output[31:0] Data_out;
	output CPU_MIO;
	input INT;
	input[3:0] DEBUG_SW;
	input[3:0] DEBUG_BTN;
	output[15:0] DEBUG_INFO;
	
	//PC
	wire [31:0] PC_i;
	wire [31:0] PC_o;
	wire write_next;
	PC m_PC(.clk(clk), .reset(reset), .write_next(write_next), .PC_i(PC_i), .PC_o(PC_o));
	assign PC_out = PC_o;
	
	//Instruction_Memory
	wire [31:0] Instruction_i;
	assign Instruction_i = inst_in;
	
	//Instruction_Register
	wire IRWrite;
	wire [31:0] Instruction_o;
	flopr m_Instruction_Register(.clk(clk), .update(IRWrite), .d(Instruction_i), .q(Instruction_o));
	
	//RegDst_Mux
	wire [4:0] Write_register;
	wire [1:0] RegDst;
	Mux #(5, 2) m_RegDst_Mux(.s(RegDst), .y(Write_register), .d0(Instruction_o[20:16]), .d1(Instruction_o[15:11]), .d2(5'b11111), .d3(5'b0), .d4(5'b0), .d5(5'b0), .d6(5'b0), .d7(5'b0), .d8(5'b0), .d9(5'b0), .d10(5'b0), .d11(5'b0), .d12(5'b0), .d13(5'b0), .d14(5'b0), .d15(5'b0));
	
	//Registers
	wire [31:0] Write_data;
	wire [31:0] Read_data1;
	wire [31:0] Read_data2;
	wire RegWrite;
	wire [15:0] DEBUG_RFINFO;
	Registers m_Registers(.clk(clk), .reset(reset), .RegWrite(RegWrite), .Read_register1(Instruction_o[25:21]), .Read_register2(Instruction_o[20:16]), .Write_register(Write_register), .Write_data(Write_data), .Read_data1(Read_data1), .Read_data2(Read_data2), .CPU_MIO(CPU_MIO), .DEBUG_SW32(DEBUG_SW[3:2]), .DEBUG_BTN(DEBUG_BTN), .DEBUG_RFINFO(DEBUG_RFINFO));
	assign Data_out = Read_data2;
	assign DEBUG_INFO = (DEBUG_SW[1]) ? DEBUG_RFINFO : PC_out[17:2];
	
	//A
	wire [31:0] A_data;
	flopr m_A(.clk(clk), .update(1'b1), .d(Read_data1), .q(A_data));
	
	//B
	wire [31:0] B_data;
	flopr m_B(.clk(clk), .update(1'b1), .d(Read_data2), .q(B_data));
	
	//ALUSrcA_Mux
	wire [1:0] ALUSrcA;
	wire [31:0] src0;
	Mux #(32, 2) m_ALUSrcA_Mux(.s(ALUSrcA), .y(src0), .d0(PC_o), .d1(A_data), .d2({27'b0, Instruction_o[10:6]}), .d3(32'b0), .d4(32'b0), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//Sign_Extend
	wire [31:0] signExtendedOffset;
	EXT m_Sign_Extend(.EXTOp(`ArithmeticEXT), .Imm16(Instruction_o[15:0]), .Imm32(signExtendedOffset));
	
	//Logic_Extend
	wire [31:0] logicExtendedOffset;
	EXT m_Logic_Extend(.EXTOp(`LogicEXT), .Imm16(Instruction_o[15:0]), .Imm32(logicExtendedOffset));
	
	//ALUSrcB_Mux
	wire [2:0] ALUSrcB;
	wire [31:0] src1;
	Mux #(32, 3) m_ALUSrcB_Mux(.s(ALUSrcB), .y(src1), .d0(B_data), .d1(32'd4), .d2(signExtendedOffset), .d3((signExtendedOffset << 2)), .d4(logicExtendedOffset), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//ALU
	wire [5:0] ALUOp;
	wire Zero;
	wire [31:0] ALU_result;
	ALU m_ALU(.ALU_control(ALUOp), .src0(src0), .src1(src1), .Zero(Zero), .ALU_result(ALU_result));
	assign Addr_out = ALU_result;
	
	//ALUOut
	wire [31:0] ALUOut_data;
	flopr m_ALUOut(.clk(clk), .update(1'b1), .d(ALU_result), .q(ALUOut_data));
	
	//BE
	wire [1:0] StoreType;
	wire [3:0] be;
	BE m_BE(.StoreType(StoreType), .ALUOut(ALUOut_data[1:0]), .be(be));
	
	//Data_Memory
	wire MemWrite;
	wire [31:0] MemData;
	assign MemData = Data_in;
	
	//Memory_data_register
	wire [31:0] Memory_data_register_data;
	flopr m_Memory_data_register(.clk(clk), .update(1'b1), .d(MemData), .q(Memory_data_register_data));
	
	//LoadBE
	wire [2:0] LoadType;
	wire [31:0] LoadBE_data;
	LoadBE m_LoadBE(.LoadType(LoadType), .ALUOut(ALUOut_data[1:0]), .MemData_i(Memory_data_register_data), .MemData_o(LoadBE_data));
	
	//MemtoReg_Mux
	wire [1:0] MemtoReg;
	Mux #(32, 2) m_MemtoReg_Mux(.s(MemtoReg), .y(Write_data), .d0(ALUOut_data), .d1(LoadBE_data), .d2(PC_o), .d3(32'b0), .d4(32'b0), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//Control
	wire [2:0] PCSource;
	wire PCWriteCond;
	wire PCWrite;
	wire Reverse;
	Control m_Control(.clk(clk), .reset(reset), .Op(Instruction_o[31:26]), .Rt(Instruction_o[20:16]), .Funct(Instruction_o[5:0]), .RegDst(RegDst), .RegWrite(RegWrite), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .ALUOp(ALUOp), .PCSource(PCSource), .PCWriteCond(PCWriteCond), .PCWrite(PCWrite), .MemWrite(MemWrite), .MemtoReg(MemtoReg), .IRWrite(IRWrite), .StoreType(StoreType), .LoadType(LoadType), .Reverse(Reverse));
	assign mem_w = MemWrite;
	
	//TargetPC
	wire [31:0] targetPC;
	TargetPC m_TargetPC(.nextPC(PC_o), .target(Instruction_o[25:0]), .targetPC(targetPC));
	
	//PCSource_Mux
	Mux #(32, 3) m_PCSource_Mux(.s(PCSource), .y(PC_i), .d0(ALU_result), .d1(ALUOut_data), .d2(targetPC), .d3(32'h8000_0180), .d4(A_data), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//WriteNext
	WriteNext m_WriteNext(.Reverse(Reverse), .Zero(Zero), .PCWriteCond(PCWriteCond), .PCWrite(PCWrite), .write_next(write_next));
endmodule