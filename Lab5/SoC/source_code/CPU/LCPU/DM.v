
module dm(dout_o,addr_i,din_i,DMWr,clk);
	input [11:2] addr_i;
	input [31:0] din_i;
	input 		 DMWr;
	input 		 clk;

	output[31:0] dout_o;
	
	reg [31:0]  DMem[1023:0];
	
	always@(posedge clk)
	begin
		if(DMWr)
			DMem[addr_i] <= din_i;
	end
	assign dout_o = DMem[addr_i];
endmodule