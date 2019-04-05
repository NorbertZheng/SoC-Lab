`include "ctrl_encode_def.v"
module ctrl(clk,rst_n,OP,Funct,Zero,BSel,WDSel,RFWr,DMWr,NPCOp,
  EXTOp,ALUOp,PCWr,IRWr,GPRSel);
  input clk;
  input rst_n;
  input wire [5:0] OP;
  input wire [5:0] Funct;
  input wire Zero;
  output reg BSel;
  output reg [1:0] WDSel;
  output reg RFWr;
  output reg DMWr;
  output reg [1:0] NPCOp;
  output reg [1:0] EXTOp;
  output reg [1:0] ALUOp;
  output reg PCWr;
  output reg IRWr;
  output reg [1:0] GPRSel;
  
  initial
  begin
    BSel=0;
    WDSel=0;
    RFWr=0;
    DMWr=0;
    NPCOp=0;
    EXTOp=0;
    ALUOp=0;
    PCWr=0;
    IRWr=0;
    GPRSel=0;
  end
  
  
  always @(*)
  begin
    
    //signals of ALU
    case(OP)
      `CTRL_OP_RTYPE:
      begin
        BSel=0;
        RFWr=1;
        GPRSel=1;
        DMWr=0;
        WDSel=0;
        NPCOp=0;
        PCWr=1;
        IRWr=1;
		case(Funct)
		`CTRL_FUNCT_ADDU:
			ALUOp=`ALUOP_ADDU;
		`CTRL_FUNCT_SUBU:
			ALUOp=`ALUOP_SUBU;
		`CTRL_FUNCT_SLT:
			ALUOp=`ALUOP_SLT;
		`CTRL_FUNCT_AND:
			ALUOp=`ALUOP_AND;
		`CTRL_FUNCT_OR:
			ALUOp = `ALUOP_ORI;
		`CTRL_FUNCT_NOR:
			ALUOp = `ALUOP_NOR;
		endcase
      end
      
      //signals of ior
      `CTRL_OP_ORI:
      begin
        ALUOp = `ALUOP_ORI;
        BSel=1;
        WDSel=0;
        RFWr=1;
        DMWr=0;
        NPCOp=0;
        EXTOp=2;
        PCWr=1;
        IRWr=1;
        GPRSel=0;
        EXTOp=2;
      end
      
      //signals of lw
      `CTRL_OP_LW:
      begin
        ALUOp=0;
        BSel=1;
        WDSel=1;
        RFWr=1;
        DMWr=0;
        NPCOp=0;
        EXTOp=2;
        PCWr=1;
        IRWr=1;
        GPRSel=0;
        EXTOp=1;
      end
      
      //signals of sw
      `CTRL_OP_SW:
      begin
        ALUOp=0;
        BSel=1;
        RFWr=0;
        DMWr=1;
        NPCOp=0;
        EXTOp=2;
        PCWr=1;
        GPRSel=0;
        IRWr=1;
        EXTOp=1;
      end
      
      //signals of beq
      `CTRL_OP_BEQ:
      begin
        BSel=0;
        RFWr=0;
        DMWr=0;
        if(Zero==1)
          NPCOp=1;
        else
          NPCOp=0;
        EXTOp=1;
        ALUOp=`ALUOP_SUBU;
        PCWr=1;
        IRWr=1;
        GPRSel=0;
      end
      
      //signals of jal
      `CTRL_OP_JAL:
      begin
        BSel=1;
        GPRSel=2;
        RFWr=1;
        DMWr=0;
        NPCOp=2;
        EXTOp=2;
        PCWr=1;
        IRWr=1;
      end
	  
	  `CTRL_OP_J:
      begin
        BSel=1;
        GPRSel=2;
        RFWr=0;
        DMWr=0;
        NPCOp=2;
        EXTOp=2;
        PCWr=1;
        IRWr=1;
      end
    endcase
    

      
  end
endmodule
      
      