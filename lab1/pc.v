// pc.v
module program_counter(
    input clk,
    input reset, // Add reset signal
    output reg [31:0] PC,
    input [31:0] npc
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'h00000000; // Initialize PC to 0 on reset
        else
            PC <= npc; // Update PC on clock edge
    end

endmodule