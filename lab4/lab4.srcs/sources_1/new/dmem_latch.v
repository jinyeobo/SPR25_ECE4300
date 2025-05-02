`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2025 04:41:09 PM
// Design Name: 
// Module Name: dmem_latch
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


module dmem_latch(
    input clk,
    input [31:0] aluresult_in, readdata_in,
    input [4:0] writereg_in,
    input [1:0] wb_ctrl,
    
    output reg [31:0] aluresult_out, readdata_out,
    output reg [4:0] writereg_out,
    output reg [1:0] wb_ctrl_out
    );
    
    always @(posedge clk) begin
        aluresult_out <= aluresult_in;
        readdata_out <= readdata_in;
        writereg_out <= writereg_in;
        wb_ctrl_out <= wb_ctrl;
    end
    
endmodule
