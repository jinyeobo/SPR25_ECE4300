`timescale 1ns / 1ps

module mux5bit(
    output [4:0] y,
    input [4:0] a,
    input [4:0] b,
    input sel
);
    assign y = sel ? a : b;
endmodule
