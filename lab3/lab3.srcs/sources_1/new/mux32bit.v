`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:01:15 PM
// Design Name: 
// Module Name: mux32bit
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


module mux32bit(
    output [31:0] y,
    input [31:0] a,
    input [31:0] b,
    input sel
);
    assign y = sel ? a : b;
endmodule