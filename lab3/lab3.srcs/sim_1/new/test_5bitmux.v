`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:07:49 PM
// Design Name: 
// Module Name: test_5bitmux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testing the 5bit_mux module of the EX stage of the pipeline
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_5bitmux();
    // wire ports
    wire [4:0] y;
    
    // reg declarations
    reg [4:0] a, b;
    reg sel;
    
    // instantiate the mux
    mux5bit uut(.y(y), .a(a), .b(b), .sel(sel));
    
    initial begin
        a = 5'b01010;
        b = 5'b10101;
        sel = 1'b1; // A
        
        #10
        a = 5'b00000;
        
        #10
        sel = 1'b1; // A
        
        #10
        b = 5'b11111;
        
        #5
        a = 5'b00101;
        
        #5
        sel = 1'b0; // B
        
        #5
        sel = 1'bx;
    end 
    
    always @ (a or b or sel)
        #1 $display("At t = %0d sel = %b, A = %b, B = %b, Y = %b", $time, sel, a, b, y);  

endmodule
