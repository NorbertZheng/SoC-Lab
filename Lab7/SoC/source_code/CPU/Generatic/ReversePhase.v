module ReversedPhase(Reverse, din, dout);
	input Reverse;
	input din;
	output dout;
	
	assign dout = (Reverse) ? ~din : din;
endmodule