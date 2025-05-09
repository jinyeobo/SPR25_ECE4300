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
    input clk,
    input regwrite,
    
    // inputs
    input [4:0] rs,  // read reg1
    input [4:0] rt,  // read reg2
    input [4:0] rd,  // write reg
    
    // input write data
    input [31:0] writedata, 
    
    // outputs
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);
    
    reg [31:0] reg_file [0:31];
    
    initial begin
        // Initialize all registers to 0
        for (integer i = 0; i < 32; i = i + 1)
            reg_file[i] = 32'b0;
            
        // Initialize some registers with test values from Lab 2
        // Note: These are just examples - use actual test values from your lab
        reg_file[1] = 32'h002300AA;
        reg_file[2] = 32'h10654321;
        reg_file[3] = 32'h00100022;
        // ... add other initialization values as needed
    end
    
    // Combinational read operations
    always @(*) begin
        // Register 0 is always zero
        read_data1 = (rs == 5'b0) ? 32'b0 : reg_file[rs];
        read_data2 = (rt == 5'b0) ? 32'b0 : reg_file[rt];
    end
    
    // Synchronous write operation
    always @(posedge clk) begin
        if (regwrite && rd != 5'b0) begin  // Can't write to register 0
            reg_file[rd] <= writedata;
        end
    end
endmodule
