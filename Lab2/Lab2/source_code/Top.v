`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:47:22 03/19/2019 
// Design Name: 
// Module Name:    Top 
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
module Top(clk_100mhz, RSTN, led_clk, led_clrn, led_sout, LED_PEN, seg_clk, seg_clrn, seg_sout, SEG_PEN, RDY, readn, CR, BTN_x, BTN_y, SW);
	input clk_100mhz;
	input RSTN;
	output led_clk;
	output led_clrn;
	output led_sout;
	output LED_PEN;
	output seg_clk;
	output seg_clrn;
	output seg_sout;
	output SEG_PEN;
	output RDY;
	output readn;
	output CR;
	output[4:0] BTN_x;
	input[3:0] BTN_y;
	input[15:0] SW;
	
	/********************************/
	/*    SAnti_jitter   U9         */
	/********************************/
	wire[4:0] XLXN_444;
	wire RDY;
	wire[3:0] Pulse;
	wire[3:0] BTN_OK;
	wire[15:0] SW_OK;
	wire rst;
	SAnti_jitter U9(
		.clk(clk_100mhz), 
		.RSTN(RSTN),
		.readn(readn),
		.Key_y(BTN_y),
		.Key_x(BTN_x),
		.SW(SW), 
		.Key_out(XLXN_444),
		.Key_ready(RDY),
		.pulse_out(Pulse),
		.BTN_OK(BTN_OK),
		.SW_OK(SW_OK),
		.CR(CR),
		.rst(rst)
	);
	
	/********************************/
	/*       clk_div    U8          */
	/********************************/
	wire[31:0] Div;
	wire Clk_CPU;
	clk_div U8(
		.clk(clk_100mhz),
		.rst(rst),
		.SW2(SW_OK[2]),
		.clkdiv(Div),
		.Clk_CPU(Clk_CPU)
	);
	
	/********************************/
	/*      SEnter_2_32   M4        */
	/********************************/
	wire[31:0] Ai;
	wire[31:0] Bi;
	wire[7:0] blink;
	SEnter_2_32 M4(
		.clk(clk_100mhz),
		.BTN(BTN_OK[2:0]),
		.Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}),
		.D_ready(RDY),
		.Din(XLXN_444),
		.readn(readn),
		.Ai(Ai),
		.Bi(Bi),
		.blink(blink)
	);
	
	/********************************/
	/*      SSeg7_Dev   U6          */
	/********************************/
	wire[7:0] LE_out;
	wire[7:0] point_out;
	wire[31:0] Disp_num;
	SSeg7_Dev U6(
		.clk(clk_100mhz),
		.rst(rst),
		.Start(Div[20]),
		.SW0(SW_OK[0]),
		.flash(Div[25]),
		.Hexs(Disp_num),
		.point(point_out),
		.LES(LE_out),
		.seg_clk(seg_clk),
		.seg_sout(seg_sout),
		.SEG_PEN(SEG_PEN),
		.seg_clrn(seg_clrn)
	);
	
	/********************************/
	/*        ROM_D     U2          */
	/********************************/
	wire[31:0] XLXN_449;
	ROM_D U2(
		.a({5'b0, SW[3], Div[27:24]}),
		.spo(XLXN_449)
	);
	
	/********************************/
	/*        RAM_B     U3          */
	/********************************/
	wire[31:0] XLXN_469;
	RAM_B U3(
		.clka(~clk_100mhz),
		.wea(SW_OK[4]),
		.addra({5'b0, SW[3], Div[27:24]}),
		.dina(XLXN_449),
		.douta(XLXN_469)
	);
	
	/********************************/
	/*   Multi_8CH32     U5         */
	/********************************/
	Multi_8CH32 U5(
		.clk(clk_100mhz),
		.rst(rst),
		.EN(1'b1),
		.Test(SW_OK[7:5]),
		.point_in({Div[31:0], Div[31:0]}),
		.LES({12'b0, blink[3:0], 32'b0, blink[7:0], blink[7:0]}),
		.Data0(Ai),	
		.data1(Bi),
		.data2(Div),
		.data3(32'b0),
		.data4(32'b0),
		.data5(32'b0),
		.data6(XLXN_449),
		.data7(XLXN_469),
		.point_out(point_out),
		.LE_out(LE_out),
		.Disp_num(Disp_num)
	);
	
	/********************************/
	/*         SPIO      U7         */
	/********************************/
	SPIO U7(
		.clk(clk_100mhz),
		.rst(rst),
		.Start(Div[20]),
		.EN(1'b1),
		.P_Data({SW[13:0], SW_OK[15:0], 2'b0}),
		.counter_set(),
		.LED_out(),
		.led_clk(led_clk),
		.led_sout(led_sout),
		.led_clrn(led_clrn),
		.LED_PEN(LED_PEN),
		.GPIOf0()		 
	);

endmodule
