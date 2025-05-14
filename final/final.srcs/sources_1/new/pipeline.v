`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2025 09:17:02 PM
// Design Name: 
// Module Name: pipeline
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline(
    input clk,
    input reset
    );
    
    // IF STAGE INPUTS
    wire EX_MEM_PCsrc;
    wire [31:0] EX_MEM_NPC;
    
    // IF STAGE OUTPUTS
    wire [31:0] IF_ID_instr, IF_ID_npc;
    
    i_fetch if_stage(
        .clk(clk),
        .reset(reset),
        .IF_ID_instr(IF_ID_instr),
        .IF_ID_npc(IF_ID_npc),
        .EX_MEM_PCsrc(EX_MEM_PCsrc),
        .EX_MEM_NPC(EX_MEM_NPC)
    );
    
    // ID STAGE INPUTS
    wire [4:0] MEMWB_ID_write_reg;
    wire [31:0] MEMREG_ID_write_data;
    wire WB_ID_reg_write;
    
    // ID STAGE OUTPUTS
    wire [8:0] ID_EX_control_bits;
    wire [31:0] ID_EX_npc_out, ID_EX_reg_rs, ID_EX_reg_rt, ID_EX_sign_ext;
    wire [4:0] ID_EX_rt, ID_EX_rd;
    
    final_ID_stage id_stage(
        .clk(clk),
        .instr(IF_ID_instr),
        .npc(IF_ID_npc),
        .write_reg(MEMWB_ID_write_reg),
        .write_data(MEMREG_ID_write_data),
        .reg_write(WB_ID_reg_write),
        .control_bits(ID_EX_control_bits),
        .npc_out(ID_EX_npc_out),
        .reg_rs(ID_EX_reg_rs),
        .reg_rt(ID_EX_reg_rt),
        .sign_ext(ID_EX_sign_ext),
        .rt(ID_EX_rt),
        .rd(ID_EX_rd)
    );
    
    // EX STAGE INPUTS
    wire [1:0] ctlwb_in, alu_op;
    wire [2:0] ctlm_in;
    wire [5:0] funct;
    wire alusrc, regdst;
    
    assign ctlwb_in = ID_EX_control_bits[1:0];
    assign alu_op = ID_EX_control_bits[7:6];
    assign ctlm_in = ID_EX_control_bits[4:2];
    assign funct = ID_EX_sign_ext[5:0];
    assign alusrc = ID_EX_control_bits[5];
    assign regdst = ID_EX_control_bits[8];
    
    // EX STAGE OUTPUTS
    wire [1:0] EX_MEM_ctlwb;
    wire [2:0] EX_MEM_ctlm;
    wire [31:0] EX_MEM_adder_out, EX_MEM_alu_result_out, EX_MEM_rdata2out;
    wire [4:0] EX_MEM_muxout;
    wire EX_MEM_aluzero;
  
    final_ex ex_stage(
        .clk(clk),
        .ctlwb_in(ctlwb_in),
        .ctlm_in(ctlm_in),
        .npc(ID_EX_npc_out),
        .rdata1(ID_EX_reg_rs),
        .rdata2(ID_EX_reg_rt),
        .s_extend(ID_EX_sign_ext),
        .instr_2016(ID_EX_rd),
        .instr_1511(ID_EX_rt),
        .alu_op(alu_op),
        .funct(funct),
        .alusrc(alusrc),
        .regdst(regdst),
        .ctlwb_out(EX_MEM_ctlwb),
        .ctlm_out(EX_MEM_ctlm),
        .adder_out(EX_MEM_adder_out),
        .alu_result_out(EX_MEM_alu_result_out),
        .rdata2out(EX_MEM_rdata2_out),
        .muxout_out(EX_MEM_muxout),
        .aluzero_out(EX_MEM_aluzero)
    );
    
    // MEM STAGE INPUTS
    wire MemWrite, MemRead, Branch;
    
    assign MemWrite = EX_MEM_ctlm[0];
    assign MemRead = EX_MEM_ctlm[1];
    assign Branch = EX_MEM_ctlm[2];
    
    // MEM STAGE OUTPUTS
    wire [31:0] MEM_WB_readdata, MEM_WB_alu_result;
    wire [4:0] MEM_WB_writereg;
    wire [1:0] MEM_WB_control;
    
    memory mem_stage(
        .clk(clk),
        .ALUResult(EX_MEM_alu_result_out),
        .WriteData(EX_MEM_rdata2_out),
        .WriteReg(EX_MEM_muxout),
        .WBControl(EX_MEM_ctlwb),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .Zero(EX_MEM_aluzero),
        .ReadData(MEM_WB_readdata),
        .ALUResult_out(MEM_WB_alu_result),
        .WriteReg_out(MEM_WB_writereg),
        .WBControl_out(MEM_WB_control),
        .PCSrc(EX_MEM_PCsrc)
    );
    
    // WB STAGE INPUTS
    wire MemtoReg;
    
    assign MemtoReg = MEM_WB_control[0];
    
    mux32 wb_stage(
        .a(MEM_WB_readdata),
        .b(MEM_WB_alu_result),
        .sel(MemtoReg),
        .y(MEMREG_ID_write_data)
    );
    
endmodule
