module i_fetch(
    input clk,
    input reset,
    output wire [31:0] IF_ID_instr,
    output wire [31:0] IF_ID_npc,
    input wire EX_MEM_PCsrc,
    input wire [31:0] EX_MEM_NPC
);
    wire [31:0] PC; // Declare as wire
    wire [31:0] dataout; // Declare as wire
    wire [31:0] npc, npc_mux; // Declare as wire

    mux mux1(.a(EX_MEM_NPC), .b(npc), .sel(EX_MEM_PCsrc), .y(npc_mux));

    program_counter program_counter1(.clk(clk), .reset(reset), .PC(PC), .npc(npc_mux)); // Fix port names

    instruction_memory memory1(.addr(PC), .data(dataout), .clk(clk));

    if_id if_id1(.clk(clk), .instr(dataout), .npc(npc), .instrout(IF_ID_instr), .npcout(IF_ID_npc));

    adder adder1(.pc(PC), .next_pc(npc)); // Correct port connections

endmodule