//`include "ctrl_encode_def.v"
//`include "IM.v"
//`include "ctrl.v"
//`include "mux.v"
//`include "flopr.v"
//`include "IM.v"
//`include "DM.v"
//`include "NPC.v"
//`include "EXT.v"
//`include "ALU.v"
//`include "IR.v"
//`include "PC.v"
//`include "RF.v"

module mips(
    input wire clk,
    input wire rst_n,
    input [31:0] inst_in,
    input MIO_ready,
    input [31:0] Data_in,
    input INT,
    output mem_w,
    output [31:0] PC_out,
    output [31:0] Addr_out,
    output [31:0] Data_out,
    output CPU_MIO
);
 
    
    // RF
    wire[31:0]    rf_read_data1;
    wire[31:0]    rf_read_data2;
    wire[4:0]    write_addr;
    wire[4:0]    final_write_addr;
    wire[31:0]    ext_output;
    // ALU
    wire[31:0]    alu_num_1;
    wire[31:0]    alu_num_2;
    wire    Zero;
    // Data memory
    wire[31:0]    alu_result;
    wire[31:0] mem2reg_data;
    wire[31:0] final_mem2reg_data;

    // Signals
    wire BSel;
    wire [1:0] WDSel;
    wire RFWr;
    wire mem_w;
    wire [1:0] NPCOp;
    wire [1:0] EXTOp;
    wire [1:0] ALUOp;
    wire PCWr;
    wire IRWr;
    wire [1:0] GPRSel;
    
    //extend
    wire[15:0] imme=inst_in[15:0];
    
    EXT EXT(
    .Imm16(imme), 
    .EXTOp(EXTOp), 
    .Imm32(ext_output)
    );


    // PC
    pc pc(
        .clk(clk),
        .rst_n(rst_n),
        .NPCOp(NPCOp),
        .Imm26_i(inst_in[25:0]),
		  .pc_o(PC_out),
        .Imm32(ext_output)
    );
  
    
    
  
    // Instruction Memory
    //im im(
        //.addr_i(PC_out[11:2]),
        //.dout_o(inst_in)
    //);
    // Control unit
    ctrl ctrl(
        .clk(clk),
        .rst_n(rst_n),
        .OP(inst_in[31:26]),
        .Funct(inst_in[5:0]),
        .ALUOp(ALUOp),
        .BSel(BSel),
        .RFWr(RFWr),
        .GPRSel(GPRSel),
        .DMWr(mem_w),
        .WDSel(WDSel),
        .NPCOp(NPCOp),
        .EXTOp(EXTOp),
        .PCWr(PCWr),
        .IRWr(IRWr),
        .Zero(Zero)
    );
    
     // Write addr mux
    mux2 write_addr_mux(
        // Input
        .d0(inst_in[20:16]),
        .d1(inst_in[15:11]),
        .d2(5'd31),
        // Signal
        .s(GPRSel),
        // Output
        .y(write_addr)
    );   
    
    // Register file
    RF rf(
        // Input
    .clk(clk),
    .ra0_i(inst_in[25:21]),
    .ra1_i(inst_in[20:16]),
    .wa_i(write_addr),
    .wd_i(mem2reg_data),
        // Output
    .rd0_o(rf_read_data1),
    .rd1_o(rf_read_data2),
        // Signal
    .we(RFWr)
    );
    // ALUSrc and ALUSrc mux
    assign alu_num_1 = rf_read_data1;
    mux1 alu_src_mux(
        .d0(rf_read_data2),
        .d1(ext_output),
        .s(BSel),
        .y(alu_num_2)
    );
    // ALU
    alu alu(
        // Input
        .src0_i(alu_num_1),
        .src1_i(alu_num_2),
        .aluop_i(ALUOp),
        // Output
        .zero_o(Zero),
        .aluout_o(alu_result)
    );
	 assign Addr_out=alu_result;
    //// Data memory
    //assign dm_write_data = rf_read_data2;
    //dm dm(
      //  .clk(clk),
      //  .addr_i(alu_result),
      //  .din_i(dm_write_data),
      // .DMWr(mem_w),

        // Output
      //  .dout_o(dm_read_data)
    //);
    // Memory to register file mux
    mux2 mem2reg_mux(
        .d0(alu_result),
        .d1(dm_read_data),
        .d2(PC_out),
        .s(WDSel),
        .y(mem2reg_data)
    );


endmodule