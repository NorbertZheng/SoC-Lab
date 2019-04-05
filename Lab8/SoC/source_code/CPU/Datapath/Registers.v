`include "../Define/DEBUG_Define.v"
module Registers(clk, reset, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2, CPU_MIO, DEBUG_SW32, DEBUG_BTN, DEBUG_RFINFO);
	parameter width = 32, AddrWidth = 5, num = 32;
	
	input clk;
	input reset;
	input RegWrite;
	input [AddrWidth - 1:0] Read_register1;
	input [AddrWidth - 1:0] Read_register2;
	input [AddrWidth - 1:0] Write_register;
	input [width - 1:0] Write_data;
	output [width - 1:0] Read_data1;
	output [width - 1:0] Read_data2;
	output [31:0] CPU_MIO;
	input[1:0] DEBUG_SW32;
	input[3:0] DEBUG_BTN;
	output[width - 1:0] DEBUG_RFINFO;
	
	reg [width - 1:0] registers[num - 1:0];
	integer i;
	
	assign Read_data1 = registers[Read_register1];
	assign Read_data2 = registers[Read_register2];
	
	always@(posedge clk or negedge reset)
		begin
		if(!reset)
			begin
			for(i = 0;i < num;i = i + 1)
				registers[i] <= 0;
			registers[28] <= 32'h00001800;
			registers[29] <= 32'h00002ffe;
			end
		else if(RegWrite)
			begin
			registers[Write_register] = (Write_register != 0) ? Write_data : 0;
			end
		end
		
	assign CPU_MIO = registers[17] + 32'h00000020;
	assign DEBUG_RFINFO = DEBUG_SW32[1] ? registers[{DEBUG_SW32[0], DEBUG_BTN}][31:16] : registers[{DEBUG_SW32[0], DEBUG_BTN}][15:0];
endmodule