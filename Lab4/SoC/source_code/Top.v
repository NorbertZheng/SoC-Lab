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
	/*        ROM_B     U2          */
	/********************************/
	wire[31:0] inst;
	wire[31:0] PC;
	ROM_B U2(
		.a(PC[11:2]),
		.spo(inst)
	);
	
	/********************************/
	/*        RAM_B     U3          */
	/********************************/
	wire XLXN_455 = ~clk_100mhz;
	wire[31:0] XLXN_559;
	wire[9:0] XLXN_558;
	wire[0:0] XLXN_557;
	wire[31:0] XLXN_556;

	RAM_B U3(
		.clka(XLXN_455),
		.wea(XLXN_557),
		.addra(XLXN_558),
		.dina(XLXN_556),
		.douta(XLXN_559)
	);
	
	/********************************/
	/*   Multi_8CH32     U5         */
	/********************************/
	wire[31:0] CPU2IO;
	wire IO_clk = ~Clk_CPU;
	wire[31:0] Addr_out;
	wire[31:0] Data_in;
	wire[31:0] Data_out;
	wire XLXN_541;
	wire[31:0] Counter_out;

	Multi_8CH32 U5(
		.clk(IO_clk),
		.rst(rst),
		.EN(XLXN_541),
		.Test(SW_OK[7:5]),
		.point_in({Div[31:0], Div[31:0]}),
		.LES(64'b0),
		.Data0(CPU2IO),	
		.data1({2'b0, PC[31:2]}),
		.data2(inst),
		.data3(Counter_out),
		.data4(Addr_out),
		.data5(Data_out),
		.data6(Data_in),
		.data7(PC),
		.point_out(point_out),
		.LE_out(LE_out),
		.Disp_num(Disp_num)
	);
	
	/********************************/
	/*         SPIO      U7         */
	/********************************/
	wire[15:0] LED_out;
	wire[1:0] XLXN_219;
	wire GPIOF0;

	SPIO U7(
		.clk(IO_clk),
		.rst(rst),
		.Start(Div[20]),
		.EN(GPIOF0),
		.P_Data(CPU2IO),
		.counter_set(XLXN_219),
		.LED_out(LED_out),
		.led_clk(led_clk),
		.led_sout(led_sout),
		.led_clrn(led_clrn),
		.LED_PEN(LED_PEN),
		.GPIOf0()		 
	);

	/********************************/
	/*         SCPU      U1         */
	/********************************/
	wire XLXN_544;
	wire XLXN_579;

	SCPU U1(
		.clk(Clk_CPU),
		.reset(rst),
		.MIO_ready(),
		.inst_in(inst),
		.Data_in(Data_in),	
		.mem_w(XLXN_544),
		.PC_out(PC),
		.Addr_out(Addr_out),
		.Data_out(Data_out), 
		.CPU_MIO(),
		.INT(XLXN_579)
	);

	/********************************/
	/*      MIO_BUS      U4         */
	/********************************/
	wire XLXN_153;
	wire XLXN_154;
	wire XLXN_560;

	MIO_BUS U4(
		.clk(clk_100mhz),
		.rst(rst),
		.BTN(BTN_OK),
		.SW(SW_OK),
		.mem_w(XLXN_544),
		.Cpu_data2bus(Data_out),
		.addr_bus(Addr_out),
		.ram_data_out(XLXN_559),
		.led_out(LED_out),
		.counter_out(Counter_out),
		.counter0_out(XLXN_579),
		.counter1_out(XLXN_153),
		.counter2_out(XLXN_154),
		.Cpu_data4bus(Data_in),
		.ram_data_in(XLXN_556),
		.ram_addr(XLXN_558),
		.data_ram_we(XLXN_557),
		.GPIOf0000000_we(GPIOF0),
		.GPIOe0000000_we(XLXN_541),
		.counter_we(XLXN_560),
		.Peripheral_in(CPU2IO)
	);

	/********************************/
	/*      Counter_x   U10         */
	/********************************/
	Counter_x U10(
		.clk(IO_clk),
		.rst(rst),
		.clk0(Div[6]),
		.clk1(Div[9]),
		.clk2(Div[11]),
		.counter_we(XLXN_560),
		.counter_val(CPU2IO),
		.counter_ch(XLXN_219),
		.counter0_OUT(XLXN_579),
		.counter1_OUT(XLXN_153),
		.counter2_OUT(XLXN_154),
		.counter_out(Counter_out)
	);
endmodule
