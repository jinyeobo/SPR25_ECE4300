`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:12:32 PM
// Design Name: 
// Module Name: latch
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


module id_latch(
    // ctrl input
    input [8:0] control_in,
    // data input
    input [31:0] npc_in, reg_rs_in, reg_rt_in, sign_ext_in,
    // npc, readdat1, readdat2, signext_out
    input [4:0] rt_in, rd_in,
    // instr_2016, instr_1511
    
    // ctrl outputs
    output reg [8:0] control_out,
    // data outputs
    output reg [31:0] npc_out, reg_rs_out, reg_rt_out, sign_ext_out,
    output reg [4:0] rt_out, rd_out
    );
    
    always @(*) begin
        control_out <= control_in;
        npc_out <= npc_in;
        reg_rs_out <= reg_rs_in;
        reg_rt_out <= reg_rt_in;
        sign_ext_out <= sign_ext_in;
        rt_out <= rt_in;
        rd_out <= rd_in;
    end
    
endmodule
