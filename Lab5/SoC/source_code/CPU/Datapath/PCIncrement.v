module PCIncrement(currentPC, nextPC);
	input [31:0] currentPC;
	output [31:0] nextPC;
	
	reg [31:0] nextPC_r;
	always@(*)
		begin
		nextPC_r = currentPC + 4;
		end
	assign nextPC = nextPC_r;
endmodule