`timescale 1ns / 1ps

module if_id(
    input clk,
    input [31:0] instr,
    input [31:0] npc,
    output reg [31:0] instrout,
    output reg [31:0] npcout
);

    always @(posedge clk) begin
        instrout <= instr;
        npcout <= npc;
    end

endmodule
