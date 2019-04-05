`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:24 05/26/2014 
// Design Name: 
// Module Name:    Data_path 
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
module Data_path( input clk,						//¼Ä´æÆ÷Ê±ÖÓ
						input rst,						//¼Ä´æÆ÷¸´Î»
						input[25:0]inst_field,		//Ö¸ÁîÊý¾ÝÓò
						input RegDst,
						input ALUSrc_B,
						input MemtoReg,
						input Jump,
						input Branch,
						input RegWrite,
						input[31:0]Data_in,
						input[2:0]ALU_Control,
						
						output[31:0]ALU_out,
						output[31:0]Data_out,
						output[31:0]PC_out
						);
						
endmodule
