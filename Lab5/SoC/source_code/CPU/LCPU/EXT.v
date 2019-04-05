module EXT(Imm16, EXTOp, Imm32);
  input wire[15:0] Imm16;
  input wire[1:0] EXTOp;
  output reg[31:0] Imm32;
  
  always@(Imm16 or EXTOp)
    case(EXTOp)
      0:Imm32<={{16{1'b0}},Imm16};
      1:Imm32<={{16{Imm16[15]}},Imm16};
      2:Imm32<={{16{1'b0}},Imm16};
      default:;
    endcase
endmodule
    
