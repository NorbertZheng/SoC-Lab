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
	PC m_PC(.clk(clk), .reset(reset), .PC_i(PC_i), .PC_o(PC_o));
	assign PC_out = PC_o;
	
	//PCIncrement
	wire [31:0] nextPC;
	PCIncrement m_PCIncrement(.currentPC(PC_o), .nextPC(nextPC));
	
	//InstructionMemory
	wire [31:0] Instruction;
	assign Instruction = inst_in;
	
	//Control
	wire [1:0] RegDst;
	wire Jump;
	wire Branch;
	wire MemRead;
	wire [1:0] MemtoReg;
	wire [5:0] ALUOp;
	wire [1:0] EXTOp;
	wire MemWrite;
	wire ALUSrc;
	wire RegWrite;
	Control m_Control(.Op(Instruction[31:26]), .Funct(Instruction[5:0]), .MIO_ready(), .RegDst(RegDst), .Jump(Jump), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .EXTOp(EXTOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .CPU_MIO());
	assign mem_w = MemWrite;
	
	//RegDst_Mux
	wire [4:0] tempWriteReg;
	Mux #(5, 2) m_RegDst_Mux(.s(RegDst), .y(tempWriteReg), .d0(Instruction[15:11]), .d1(Instruction[20:16]), .d2(5'b0), .d3(5'b0), .d4(5'b0), .d5(5'b0), .d6(5'b0), .d7(5'b0), .d8(5'b0), .d9(5'b0), .d10(5'b0), .d11(5'b0), .d12(5'b0), .d13(5'b0), .d14(5'b0), .d15(5'b0));
	
	//Jump_RegDst_Mux
	wire [4:0] writeReg;
	Mux #(5, 1) m_Jump_RegDst_Mux(.s(Jump), .y(writeReg), .d0(tempWriteReg), .d1(5'b11111), .d2(5'b0), .d3(5'b0), .d4(5'b0), .d5(5'b0), .d6(5'b0), .d7(5'b0), .d8(5'b0), .d9(5'b0), .d10(5'b0), .d11(5'b0), .d12(5'b0), .d13(5'b0), .d14(5'b0), .d15(5'b0));
	
	//Registers
	wire [31:0] writeData;
	wire [31:0] readData1;
	wire [31:0] readData2;
	wire [15:0] DEBUG_RFINFO;
	Registers m_Registers(.clk(clk), .reset(reset), .RegWrite(RegWrite), .readReg1(Instruction[25:21]), .readReg2(Instruction[20:16]), .writeReg(writeReg), .writeData(writeData), .readData1(readData1), .readData2(readData2), .CPU_MIO(CPU_MIO), .DEBUG_SW32(DEBUG_SW[3:2]), .DEBUG_BTN(DEBUG_BTN), .DEBUG_RFINFO(DEBUG_RFINFO));
	assign Data_out = readData2;
	assign DEBUG_INFO = (DEBUG_SW[1]) ? DEBUG_RFINFO : PC_out;
	
	//SignExtend
	wire [31:0] extendedOffset;
	EXT m_SignEXT(.EXTOp(EXTOp), .Imm16(Instruction[15:0]), .Imm32(extendedOffset));
	
	//ALUSrc_Mux
	wire [31:0] src1;
	Mux #(32, 1) m_ALUSrc_Mux(.s(ALUSrc), .y(src1), .d0(readData2), .d1(extendedOffset), .d2(32'b0), .d3(32'b0), .d4(32'b0), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//ALU
	wire Zero;
	wire [31:0] ALU_result;
	ALU m_ALU(.ALU_control(ALUOp), .src0(readData1), .src1(src1), .Zero(Zero), .ALU_result(ALU_result));
	assign Addr_out = ALU_result;
	
	//DataMemory
	wire [31:0] Read_data;
	assign Read_data = Data_in;
	
	//MemtoReg_Mux
	wire [31:0] tempWriteData;
	Mux #(32, 2) m_MemtoReg_Mux(.s(MemtoReg), .y(tempWriteData), .d0(ALU_result), .d1(Read_data), .d2(32'b0), .d3(32'b0), .d4(32'b0), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//Jump_MemtoReg_Mux
	wire [31:0] targetPC;
	Mux #(32, 1) m_Jump_MemtoReg_Mux(.s(Jump), .y(writeData), .d0(tempWriteData), .d1(nextPC), .d2(32'b0), .d3(32'b0), .d4(32'b0), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//TargetPC
	TargetPC m_TargetPC(.clk(clk), .nextPC(nextPC), .target(Instruction[25:0]), .targetPC(targetPC));
	
	//BranchPC
	wire [31:0] branchPC;
	BranchPC m_BranchPC(.nextPC(nextPC), .extendedOffset(extendedOffset), .branchPC(branchPC));
	
	//BranchSignal
	wire branchSignal;
	BranchSignal m_BranchSignal(.Branch(Branch), .Zero(Zero), .branchSignal(branchSignal));
	
	//Branch_Mux
	wire [31:0] selectedPC1;
	Mux #(32, 1) m_Branch_Mux(.s(branchSignal), .y(selectedPC1), .d0(nextPC), .d1(branchPC), .d2(32'b0), .d3(32'b0), .d4(32'b0), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
	
	//Jump_Mux
	Mux #(32, 1) m_Jump_Mux(.s(Jump), .y(PC_i), .d0(selectedPC1), .d1(targetPC), .d2(32'b0), .d3(32'b0), .d4(32'b0), .d5(32'b0), .d6(32'b0), .d7(32'b0), .d8(32'b0), .d9(32'b0), .d10(32'b0), .d11(32'b0), .d12(32'b0), .d13(32'b0), .d14(32'b0), .d15(32'b0));
endmodule