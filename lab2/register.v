`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:22:34 PM
// Design Name: 
// Module Name: register
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


module register(
    input clk, regwrite,
    
    // inputs
    input [4:0] rs, // read reg1
    input [4:0] rt, // read reg2
    input [4:0] rd, // write reg
    
    // input write data
    input [31:0] writedata, 
    
    //outputs
    output [31:0] read_data1, read_data2
    );
    
    reg [31:0] reg_file [0:31];
    
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            reg_file[i] = 0;
    end
    
    //read operations (async)
    assign read_data1 = reg_file[rs];
    assign read_data2 = reg_file[rt];
    
    //write operation (sync)
    always @(posedge clk) begin
        if (regwrite && rd != 0) begin
            reg_file[rd] <= writedata;
        end
    end 
           
endmodule
