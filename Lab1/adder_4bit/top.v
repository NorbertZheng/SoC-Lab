`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:22 03/12/2019 
// Design Name: 
// Module Name:    top 
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
module top(input[3:0] a, input[3:0] b, input clk, input reset, output led_clk, output led_do, output led_clr, output led_pen);
	wire [3:0] s;
	wire co;
	wire [4:0] sum;
	
	assign sum = {co, s};
	
	adder_4bit U1(.a(a), .b(b), .ci(1'b0), .s(s), .co(co));
	LED_ctrl U2(.sw({11'b0, sum}), .clk(clk), .reset(reset), .led_do(led_do), .led_pen(led_pen), .led_clk(led_clk), .led_clr(led_clr));
endmodule
