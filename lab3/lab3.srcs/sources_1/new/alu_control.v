`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 03:53:44 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control (
    output reg [2:0] select,
    input [1:0] alu_op,
    input [5:0] funct
);
    always @(*) begin
        case (alu_op)
            2'b00: select = 3'b010; // load or store word
            2'b01: select = 3'b110; // branch equal
            2'b10: begin
                case (funct)
                    6'b100000: select = 3'b010; // add
                    6'b100010: select = 3'b110; // sub
                    6'b100100: select = 3'b000; // and
                    6'b100101: select = 3'b001; // or
                    6'b101010: select = 3'b111; // slt
                    default: select = 3'bxxx;
                endcase
            end
            default: select = 3'bxxx;
        endcase
    end
endmodule

