`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:20:36 PM
// Design Name: 
// Module Name: test_alu
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


module test_alu();

    // reg declarations
    reg [31:0] a, b;
    reg [2:0] control;
    
    // wire ports
    wire [31:0] result;
    wire zero;
    
    initial begin
        a <= 'b1010;
        b <= 'b0111;
        control <= 3'b011;
        
        $display("A = %b, B = %b", a, b);
        $monitor("ALUOp = %b\tResult = %b", control, result);
        
        #1
        control <= 3'b100;
        
        #1
        control <= 3'b010;
        
        #1
        control <= 3'b111;
        
        #1
        control <= 3'b011;
        
        #1 
        control <= 3'b110;
        
        #1
        control <= 3'b001;
        
        #1
        control <= 3'b000;
        
        #1
        $finish;
    end
    
    alu uut(.result(result), .zero(zero), .a(a), .b(b), .control(control));
        
    
endmodule
