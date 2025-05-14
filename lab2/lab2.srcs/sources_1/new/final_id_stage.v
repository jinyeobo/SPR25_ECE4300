`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:43:00 PM
// Design Name: 
// Module Name: final_id_stage
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


module final_ID_stage(
    input clk,
    // From IF/ID pipeline register
    input [31:0] instr,
    input [31:0] npc,
    // From WB stage
    input [4:0] write_reg,
    input [31:0] write_data,
    input reg_write,
    
    // To ID/EX pipeline register
    output [8:0] control_bits,
    output [31:0] npc_out,
    output [31:0] reg_rs,
    output [31:0] reg_rt,
    output [31:0] sign_ext,
    output [4:0] rt,
    output [4:0] rd
);

// Control unit wires
wire [8:0] control_out;
wire [31:0] reg_rs_in, reg_rt_in, sign_ext_in;
reg [4:0] rt_in, rd_in;

always @(instr) begin
    rt_in <= instr[15:11];
    rd_in <= instr[20:16];
end

// Instantiate control unit
control ctrl(
    .opcode(instr[31:26]),
    .control_out(control_out)
);

// Instantiate register file
register reg_file(
    .clk(clk),
    .regwrite(reg_write),
    .rs(rd_in),
    .rt(rt_in),
    .rd(write_reg),
    .writedata(write_data),
    .read_data1(reg_rs_in),
    .read_data2(reg_rt_in)
);

// Instantiate sign extension unit
sign_extend sign_extd(
    .immediate(instr[15:0]),
    .sign_extended(sign_ext_in)
);

// Instatiate latch
id_latch id_uut(
    .control_in(control_out),
    .npc_in(npc),
    .reg_rs_in(reg_rs_in),
    .reg_rt_in(reg_rt_in),
    .sign_ext_in(sign_ext_in),
    .rt_in(rt_in),
    .rd_in(rd_in),
    .control_out(control_bits),
    .npc_out(npc_out),
    .reg_rs_out(reg_rs),
    .reg_rt_out(reg_rt),
    .sign_ext_out(sign_ext),
    .rt_out(rt),
    .rd_out(rd)
);

endmodule
