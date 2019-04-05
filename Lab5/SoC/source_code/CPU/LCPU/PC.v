
module pc(clk,rst_n,NPCOp,Imm26_i,Imm32,pc_o);

	input   clk;
	input   rst_n;
	input   [1:0]NPCOp;
	input   [25:0] Imm26_i;//jal指令的低26�	
	input   [31:0] Imm32;
	
	output reg[31:0] pc_o;
	
	initial
	begin
	pc_o=32'h0000_3000;
	end
	
	always@(posedge clk)
	begin
		case(NPCOp)
		0:
			pc_o = pc_o + 32'd4;
		1:
			pc_o = pc_o + 32'd4 + (Imm32<<2);
		2:
			pc_o = {pc_o[31:28],Imm26_i,2'b00};
		endcase
  end
	
	//always@(negedge rst_n)
	//begin
	  //pc_o=32'h0000_3000;
	//end

endmodule

	

