

module im(addr_i,dout_o);
	input [11:2] addr_i;
	
	output [31:0]  dout_o;
	
	reg[31:0] dout_o;
	reg[31:0] dout_o1;
	reg [31:0]  IMem[1023:0];
	
	always@(*)
	begin
		dout_o1 = IMem[addr_i];	
	assign dout_o = dout_o1;
	end
endmodule