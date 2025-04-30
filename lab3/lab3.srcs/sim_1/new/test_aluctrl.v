`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:28:19 PM
// Design Name: 
// Module Name: test_aluctrl
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


module test_aluctrl();

    // wire ports
    wire [2:0] select;
    
    // reg declarations
    reg [1:0] alu_op;
    reg [5:0] funct;
    
    alu_control uut(.select(select), .alu_op(alu_op), .funct(funct));
    
    initial begin
        alu_op = 2'b00;
        funct = 6'b100000;
        $monitor("ALUOp = %b\tFunct = %b\tselect = %b", alu_op, funct, select);
        
        #1
        alu_op = 2'b01;
        funct = 6'b100000;
        
        #1
        alu_op = 2'b10;
        funct = 6'b100000;
        
        #1
        funct = 6'b100010;
        
        #1
        funct = 6'b100100;
        
        #1
        funct = 6'b100101;
        
        #1
        funct = 6'b101010;
        
        #1
        $finish;
    end

endmodule
