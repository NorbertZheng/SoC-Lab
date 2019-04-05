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

wire V5=1;
wire N0=0;
wire[15:0]SW_OK;
wire[31:0]clkdiv;
wire[31:0]Div;
wire[31:0]Disp_num;
wire[63:0]Div_1={Div[31:0],Div[31:0]};
wire[31:0]Ai;
wire[31:0]Bi;
wire[7:0] LE_out;
wire[7:0] point_out;
wire[31:0] DIsp_num;
wire[31:0] spo;
wire[31:0] inst;
wire count0_out;
wire[31:0] PC;
wire mem_w;
wire[31:0] Addr_out;
wire[31:0] Data_in;
wire[31:0] Data_out;

SCPU U1(
	.clk(Clk_CPU),
	.reset(rst),
	.inst_in(inst[31:0]),
	.INT(count0_out),
	.PC_out(PC[31:0]),
	.mem_w(mem_w),
	.Addr_out(Addr_out[31:0]),
	.Data_in(Data_in[31:0]),
	.Data_out(Data_out[31:0]),
	.CPU_MIO(),
	.MIO_ready()
);

ROM_B U2(
	.a(PC[11:2]),
	.spo(inst[31:0])
);

wire[31:0] ram_data_in;
wire[9:0] ram_addr;
wire[31:0] ram_data_out;
wire[31:0] data_ram_we;

RAM_B U3(
	.addra(ram_addr[9:0]),
	.wea(data_ram_we),
	.dina(ram_data_in[31:0]),
	.clka(~clk_100mhz),
	.douta(ram_data_out[31:0])
);

wire[3:0]BTN_OK;
wire[31:0] CPU2IO;
wire GPIOe0000000_we;
wire GPIOF0;
wire[15:0] LED_out;
wire[31:0] Counter_out;
wire counter2_out;
wire counter1_out;
wire counter0_out;
wire counter_we;
wire[31:0] addr_bus;
MIO_BUS U4(
	.clk(clk_100mhz),
	.rst(rst),
	.BTN(BTN_OK[3:0]),
	.SW(SW_OK[15:0]),
	.mem_w(mem_w),
	.addr_bus(addr_bus[31:0]),
	.Cpu_data4bus(Data_in[31:0]),
	.Cpu_data2bus(Data_out[31:0]),
	.ram_data_in(ram_data_in[31:0]),
	.data_ram_we(data_ram_we),
	.ram_addr(ram_addr[9:0]),
	.ram_data_out(ram_data_out[31:0]),
	.Peripheral_in(CPU2IO[31:0]),
	.GPIOe0000000_we(GPIOe0000000_we),
	.GPIOf0000000_we(GPIOF0),
	.led_out(LED_out[15:0]),
	.counter2_out(counter2_out),
	.counter1_out(counter1_out),
	.counter0_out(counter0_out),
	.counter_we(counter_we)
);

Multi_8CH32 U5 (
  .clk(~Clk_CPU),  
  .rst(rst),  
  .EN(GPIOe0000000_we),  
  .Test(SW_OK[7:5]),  
  .point_in(Div_1),
  .LES({64{1'b0}}),  
  .Data0(CPU2IO),  
  .data1({N0,N0,PC[31:2]}),  
  .data2(inst[31:0]),  
  .data3(Counter_out[31:0]),
  .data4(Addr_out[31:0]),  
  .data5(Data_out[31:0]),  
  .data6(Data_in[31:0]),  
  .data7(PC[31:0]),  
  .point_out(point_out[7:0]),
  .LE_out(LE_out[7:0]),  
  .Disp_num(Disp_num[31:0])  
);


SSeg7_Dev U6(.clk(clk_100mhz),
             .rst(rst),
				.Start(Div[20]),
				.SW0(SW_OK[0]),
				.flash(Div[25]),
				.Hexs(Disp_num[31:0]),
	         .point(point_out[7:0]),
				.LES(LE_out[7:0]),
				.seg_clk(seg_clk),
				.seg_sout(seg_sout),
				.SEG_PEN(SEG_PEN),
				.seg_clrn(seg_clrn)
				);



wire[7:0]blink;	
wire key_ready;
wire[4:0] key_out;					
SEnter_2_32 M4(
		.clk(clk_100mhz),
		.BTN(BTN_OK[2:0]),  
		.Ctrl({SW_OK[7:5],SW_OK[15],SW_OK[0]}), 
		.D_ready(key_ready), 
		.Din(key_out[4:0]),  
		.readn(readn),
		.Ai(Ai[31:0]),
		.Bi(Bi[31:0]),
		.blink(blink[7:0])
		);
	 
	 

wire[3:0]Pulse;
SAnti_jitter U9(.clk(clk_100mhz),
					.RSTN(RSTN),
					.readn(readn),
					.Key_y(BTN_y[3:0]),
					.Key_x(BTN_x[4:0]),
					.SW(SW[15:0]),
					.Key_out(key_out[4:0]),
					.Key_ready(key_ready),
					.pulse_out(Pulse[3:0]),
					.BTN_OK(BTN_OK[3:0]),
					.SW_OK(SW_OK[15:0]),
					.CR(CR),
					.rst(rst)
				);


wire[31:0]P_Data;
wire[1:0]counter_set;
wire[13:0]GPIOf0;
SPIO U7(
    .clk(~Clk_CPU),
    .rst(rst),
    .EN(GPIOF0),
    .Start(Div[20]),
    .P_Data(CPU2IO[31:0]),
    .counter_set(counter_set[1:0]),
    .LED_out(LED_out[15:0]),
    .GPIOf0(GPIOf0[13:0]),
    .led_clk(led_clk),
    .led_sout(led_sout),
    .LED_PEN(LED_PEN),
    .led_clrn(led_clrn)    
);


clk_div U8(
	.clk(clk_100mhz),
	.rst(rst),
	.SW2(SW_OK[2]),
	.clkdiv(Div[31:0]),
	.Clk_CPU(Clk_CPU)
	);
	
Counter_x U10(
	.clk(~Clk_CPU),
	.rst(rst),
	.clk0(Div[6]),
	.clk1(Div[9]),
	.clk2(Div[11]),
	.counter_we(counter_we),
	.counter_val(CPU2IO[31:0]),
	.counter_ch(counter_set[1:0]),
	.counter0_OUT(counter0_out),
	.counter1_OUT(counter1_out),
	.counter2_OUT(counter2_out),
	.counter_out(Counter_out[31:0])
);


endmodule