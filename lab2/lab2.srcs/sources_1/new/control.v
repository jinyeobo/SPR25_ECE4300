`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:33:24 PM
// Design Name: 
// Module Name: control
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


module control(
    input [5:0] opcode,
    output reg [8:0] control_out
);

    always @(*) begin
        case (opcode)
            6'b000000: begin // R-type
                control_out = 9'b1_10_0_0_0_0_1_0;
                // RegDst=1, ALUOp=10, ALUSrc=0, Branch=0
                // MemRead=0, MemWrite=0, RegWrite=1, MemtoReg=0
            end
            6'b100011: begin // lw
                control_out = 9'b0_00_1_0_1_0_1_1;
                // RegDst=0, ALUOp=00, ALUSrc=1, Branch=0
                // MemRead=1, MemWrite=0, RegWrite=1, MemtoReg=1
            end
            6'b101011: begin // sw
                control_out = 9'b0_00_1_0_0_1_0_0;
                // RegDst=X, ALUOp=00, ALUSrc=1, Branch=0
                // MemRead=0, MemWrite=1, RegWrite=0, MemtoReg=X
            end
            6'b000100: begin // beq
                control_out = 9'b0_01_0_1_0_0_0_0;
                // RegDst=X, ALUOp=01, ALUSrc=0, Branch=1
                // MemRead=0, MemWrite=0, RegWrite=0, MemtoReg=X
            end
            default: begin // NOP or unknown (all zeros)
                control_out = 9'b0_00_0_0_0_0_0_0;
            end
        endcase
    end

endmodule
