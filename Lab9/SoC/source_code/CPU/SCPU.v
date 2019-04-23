module SCPU(clk, reset, MIO_ready, inst_in, Data_in, mem_w, PC_out, Addr_out, Data_out, CPU_MIO, INT, DEBUG_INFO);
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
	output[31:0] DEBUG_INFO;
	
	Mips m_Mips(
		.clk(clk),
		.reset(!reset),
		.MIO_ready(MIO_ready), 
		.inst_in(inst_in),
		.Data_in(Data_in),
		.mem_w(mem_w),
		.PC_out(PC_out),
		.Addr_out(Addr_out),
		.Data_out(Data_out),
		.CPU_MIO(CPU_MIO),
		.INT(INT),
		.DEBUG_INFO(DEBUG_INFO)
	);
	/*MIPS m_MIPS(
		.clk(clk),
		.rst_n(rst_n),
		.MIO_ready(MIO_ready),
		.INT(INT),
		.inst_in(inst_in), 
		.Data_in(Data_in),
		.MemWrite(mem_w),
		.PC(PC_out), 
		.aluout(Addr_out),
		.Write_data(Data_out),
		.CPU_MIO(CPU_MIO)
	);*/
endmodule
