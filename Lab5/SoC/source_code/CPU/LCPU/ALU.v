

module alu(aluout_o,zero_o,src0_i,src1_i,aluop_i);

	input  [31:0] 		src0_i;		//运算数据1
	input  [31:0]		src1_i;		//运算数据2
	input  [1:0]		aluop_i;		//运算器控制信号
	
	output reg[31:0]		aluout_o;		//运算器输出结果
	output reg				zero_o;			//结果是否为零
	
	initial								//初始化数据
	begin
		zero_o = 0;
		aluout_o = 0;
	end	
	
	always@(src0_i or src1_i or aluop_i)
	begin
		case(aluop_i)
		3'b000:
			aluout_o = src0_i+src1_i;
		3'b001:
			aluout_o = src0_i-src1_i;
		3'b010:
			aluout_o = src0_i|src1_i;
		3'b011:
			aluout_o = src0_i&src1_i;
		3'b100:
		    aluout_o = src0_i<src1_i?1:0;
		3'b101:
			aluout_o = ~(src0_i|src1_i);
		endcase
		
		
		if(aluout_o == 0)
			zero_o = 1;
		else
			zero_o = 0;
	end

endmodule