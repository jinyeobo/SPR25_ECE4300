// Implementation of the multiplexer in the
// IF stage as a combinational circuit
module mux32(a, b, sel, y);
    input [31:0] a, b;
    input sel;
    output [31:0] y;
    
    assign y = sel ? a: b;

endmodule