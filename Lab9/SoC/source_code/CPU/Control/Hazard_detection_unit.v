`include "../Define/Fragment_Define.v"
`timescale 1ns/100ps
module Hazard_detection_unit(reset, branch_Or_Jump, ID_EX_MemRead, ID_EX_Rt, IF_ID_Rs, IF_ID_Rt, IF_ID_Stall, PC_Write, PC_Mux_select, IF_ID_Flush, ID_EX_Flush, EPC_Selected);
	input reset;
	input [1:0] branch_Or_Jump;
	input ID_EX_MemRead;
	input [4:0] ID_EX_Rt;
	input [4:0] IF_ID_Rs;
	input [4:0] IF_ID_Rt;
	output reg IF_ID_Stall;
	output reg PC_Write;
	output reg [1:0] PC_Mux_select;
	output reg IF_ID_Flush;
	output reg ID_EX_Flush;
	input EPC_Selected;
	
	always@(*)
		begin
		if(!reset)
			begin
			IF_ID_Stall = `DISABLE;
			PC_Write = 1'b1;
			PC_Mux_select = 2'b00;
			IF_ID_Flush = `DISABLE;
			ID_EX_Flush = `DISABLE;
			end
		else if(ID_EX_MemRead && ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt)))
			begin
			PC_Write = EPC_Selected ? 1'b1 : 1'b0;
			IF_ID_Stall = `ENABLE;
			ID_EX_Flush = `ENABLE;
			end
		else
			begin
			case(branch_Or_Jump)
				`Sequence:
					begin
					PC_Write = 1'b1;
					IF_ID_Stall = `DISABLE;
					PC_Mux_select = 2'b00;
					IF_ID_Flush = `DISABLE;
					ID_EX_Flush = `DISABLE;
					end
				`Branch:
					begin
					PC_Write = 1'b1;
					IF_ID_Stall = `DISABLE;
					PC_Mux_select = 2'b00;
					IF_ID_Flush = `DISABLE;
					ID_EX_Flush = `DISABLE;
					end
				`NotBranch:
					begin
					PC_Write = 1'b1;
					IF_ID_Stall = `DISABLE;
					PC_Mux_select = 2'b01;
					IF_ID_Flush = `ENABLE;
					ID_EX_Flush = `ENABLE;
					end
				`Jump:
					begin
					PC_Write = 1'b1;
					IF_ID_Stall = `DISABLE;
					PC_Mux_select = 2'b10;
					IF_ID_Flush = `ENABLE;
					ID_EX_Flush = `ENABLE;
					end
				default:
					begin
					PC_Write = 1'b0;
					IF_ID_Stall = `ENABLE;
					PC_Mux_select = 2'b00;
					IF_ID_Flush = `DISABLE;
					ID_EX_Flush = `DISABLE;
					end
			endcase
			end
		end
endmodule