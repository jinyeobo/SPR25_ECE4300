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
    output reg [1:0] alu_op,
    output reg reg_dst,
    output reg alu_src,
    output reg branch,
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg mem_to_reg
);

always @(*) begin
    case (opcode)
        6'b000000: begin // R-type
            reg_dst = 1;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 1;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b10;
        end
        6'b100011: begin // lw
            reg_dst = 0;
            alu_src = 1;
            mem_to_reg = 1;
            reg_write = 1;
            mem_read = 1;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b00;
        end
        6'b101011: begin // sw
            alu_src = 1;
            reg_write = 0;
            mem_read = 0;
            mem_write = 1;
            branch = 0;
            alu_op = 2'b00;
            // Don't care:
            reg_dst = 1'bx;
            mem_to_reg = 1'bx;
        end
        6'b000100: begin // beq
            alu_src = 0;
            reg_write = 0;
            mem_read = 0;
            mem_write = 0;
            branch = 1;
            alu_op = 2'b01;
            // Don't care:
            reg_dst = 1'bx;
            mem_to_reg = 1'bx;
        end
        default: begin // NOP or unknown
            reg_dst = 0;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 0;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b00;
        end
    endcase
end

endmodule
