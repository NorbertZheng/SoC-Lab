`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:06:17 06/07/2015 
// Design Name: 
// Module Name:    ROM 
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
module  ROM(input [2:0]addr,
				output[31:0]Dout
				);

reg[7:0][31:0]data;

	always@* begin
		data[0]=32'h557EF7E0;
		data[1]=32'hD7BDFBD9;
		data[2]=32'hD7DBFDB9;
		data[3]=32'hDFCFFCFB;
		data[4]=32'hDFCFBFFF;
		data[5]=32'hF7F3DFFF;
		data[6]=32'hFFFFDF3D;
		data[7]=32'hFFFF9DB9;
	end	
	
	assign Dout = data[addr];
	
endmodule
