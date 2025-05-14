module instruction_memory(addr, data, clk);
    input [31:0] addr;
    output reg [31:0] data;
    input clk;
    
    reg [31:0] mem [0:1023];
    
    initial begin
        $readmemb("risc.txt", mem);
        for (integer i = 0; i < 24; i = i + 1)
            $display(mem[i]);
    end
    
    always @(posedge clk) begin     
        data <= mem[addr];
    end
     
endmodule