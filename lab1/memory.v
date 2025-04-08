module instruction_memory(addr, data, clk);
    input [31:0] addr;
    output reg [31:0] data;
    input clk;
    
    reg [31:0] mem [0:1023];
    
    initial begin
        mem[0] = 32'hA00000AA; 
        mem[4] = 32'h10000011; 
        mem[8] = 32'h20000022; 
        mem[12] = 32'h30000033; 
        mem[16] = 32'h40000044;
        mem[20] = 32'h50000055;
        mem[24] = 32'h60000066;
        mem[28] = 32'h70000077;
        mem[32] = 32'h80000088;
        mem[36] = 32'h90000099;
    end
    
    always @(posedge clk) begin     
        data <= mem[addr];
    end
     
endmodule