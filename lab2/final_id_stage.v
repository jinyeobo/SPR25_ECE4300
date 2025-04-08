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
wire [1:0] alu_op;
wire reg_dst, alu_src, branch, mem_read, mem_write, mem_to_reg;

// Instantiate control unit
control ctrl(
    .opcode(instr[31:26]),
    .alu_op(alu_op),
    .reg_dst(reg_dst),
    .alu_src(alu_src),
    .branch(branch),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .reg_write(reg_write),
    .mem_to_reg(mem_to_reg)
);

// Combine control bits
assign control_bits = {reg_dst, alu_src, mem_to_reg, reg_write, 
                      mem_read, mem_write, branch, alu_op};

// Instantiate register file
register reg_file(
    .clk(clk),
    .regwrite(reg_write),
    .rs(instr[25:21]),
    .rt(instr[20:16]),
    .rd(write_reg),
    .writedata(write_data),
    .read_data1(reg_rs),
    .read_data2(reg_rt)
);

// Instantiate sign extension unit
sign_extend sign_extd(
    .immediate(instr[15:0]),
    .sign_extended(sign_ext)
);

// Pass through NPC
assign npc_out = npc;

// Pass through rt and rd fields
assign rt = instr[20:16];
assign rd = instr[15:11];

endmodule
