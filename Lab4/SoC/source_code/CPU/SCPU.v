`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:43 04/28/2009 
// Design Name: 
// Module Name:    single_cycle_Cpu_9 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SCPU(clk, reset, MIO_ready, inst_in, Data_in, mem_w, PC_out, Addr_out, Data_out, CPU_MIO, INT);
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
	
	/********************************/
	/*     SCPU_ctrl   Controller   */
	/********************************/
	wire RegDst;
	wire ALUSrc_B;
	wire MemtoReg;
	wire Jump;
	wire Branch;
	wire RegWrite;
	wire[2:0] ALU_Control;
	SCPU_ctrl Controller(
		.OPcode(inst_in[31:26]),
		.Fun(inst_in[5:0]),
		.MIO_ready(MIO_ready),
		.RegDst(RegDst),
		.ALUSrc_B(ALUSrc_B),
		.MemtoReg(MemtoReg),
		.Jump(Jump),
		.Branch(Branch),
		.RegWrite(RegWrite),
		.mem_w(mem_w),
		.ALU_Control(ALU_Control),
		.CPU_MIO(CPU_MIO)
	);
	
	/********************************/
	/*     Data_path    DataPath    */
	/********************************/
	Data_path DataPath(
		.clk(clk),
		.rst(reset),
		.inst_field(inst_in[25:0]),
		.RegDst(RegDst),
		.ALUSrc_B(ALUSrc_B),
		.MemtoReg(MemtoReg),
		.Jump(Jump),
		.Branch(Branch),
		.RegWrite(RegWrite),
		.Data_in(Data_in),
		.ALU_Control(ALU_Control),
		.ALU_out(Addr_out),
		.Data_out(Data_out),
		.PC_out(PC_out)
	);
endmodule
