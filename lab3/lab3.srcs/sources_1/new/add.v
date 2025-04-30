module add(
    output [31:0] out,
    input [31:0] add_in1,
    input [31:0] add_in2
);
    assign out = add_in1 + add_in2;
endmodule
