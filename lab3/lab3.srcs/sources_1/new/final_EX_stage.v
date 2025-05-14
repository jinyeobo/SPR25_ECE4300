module final_ex(
    input clk,
    input [1:0] ctlwb_in,
    input [2:0] ctlm_in,
    input [31:0] npc, rdata1, rdata2, s_extend,
    input [4:0] instr_2016, instr_1511,
    input [1:0] alu_op,
    input [5:0] funct,
    input alusrc, regdst,

    output [1:0] ctlwb_out,
    output [2:0] ctlm_out,
    output [31:0] adder_out, alu_result_out, rdata2out,
    output [4:0] muxout_out,
    output aluzero_out
);
    // wires to connect internal modules
    wire [31:0] adder_result, alu_in2, alu_result;
    wire [2:0] alu_ctrl;
    wire aluzero;
    wire [4:0] regdst_muxout;
    
    // module instances and connections
    add adder_inst(
        .out(adder_result),
        .add_in1(rdata1),
        .add_in2(rdata2)
    );
    
    mux32bit mux32_inst(
        .y(alu_in2),
        .a(rdata2),
        .b(s_extend),
        .sel(alusrc)
    );
    
    alu_control alu_ctrl_inst(
        .select(alu_ctrl),  // Changed from .select(alusrc)
        .alu_op(alu_op),
        .funct(funct)
    );
    
    alu alu_inst(
        .result(alu_result),
        .zero(aluzero),
        .a(rdata1),
        .b(alu_in2),
        .control(alu_ctrl)
    );
    
    mux5bit mux5_inst(
        .y(regdst_muxout),
        .a(instr_2016),
        .b(instr_1511),
        .sel(regdst)
    );
    
    latch latch_inst(
        .clk(clk),
        .ctlwb_out(ctlwb_in),      // Added missing input
        .ctlm_out(ctlm_in),        // Added missing input
        .adder_out(adder_result),
        .aluout(alu_result),      // Changed from undeclared 'aluout'
        .readdat2(rdata2),
        .aluzero(aluzero),
        .muxout(regdst_muxout),   // Changed to use internal wire
        .wb_ctlout(ctlwb_out),
        .m_ctlout(ctlm_out),
        .addresult(adder_out),
        .alu_result(alu_result_out),
        .rdata2out(rdata2out),
        .five_bit_muxout(muxout_out),
        .aluzero_out(aluzero_out)
    );
    
endmodule