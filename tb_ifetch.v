`timescale 1ns / 1ps
module I_FETCHTB();

    reg clk_tb;
    reg reset_tb;
    reg EX_MEM_PCsrc_tb;
    reg [31:0] EX_MEM_NPC_tb;
    wire [31:0] IF_ID_instr_tb;
    wire [31:0] IF_ID_npc_tb;

    i_fetch DUT(
        .clk(clk_tb),
        .reset(reset_tb),
        .IF_ID_instr(IF_ID_instr_tb),
        .IF_ID_npc(IF_ID_npc_tb),
        .EX_MEM_PCsrc(EX_MEM_PCsrc_tb),
        .EX_MEM_NPC(EX_MEM_NPC_tb)
    );

    initial clk_tb = 0;
    always #5 clk_tb = ~clk_tb; // Increase clock period

    initial begin
        $display("Time \t PC \t npc \t dataout of MEM \t IF_ID_instr \t IF_ID_npc");
        $monitor("%0d\t %h\t %h\t %h\t %h\t %h", $time, DUT.PC, DUT.npc, DUT.dataout, IF_ID_instr_tb, IF_ID_npc_tb);

        reset_tb = 1;
        
        // Test case 1: No branch (PC increments normally)
        EX_MEM_PCsrc_tb = 0; // No branch
        EX_MEM_NPC_tb = 32'h00000000; // Default NPC value
        #10;
        
        reset_tb = 0;
        
        #20;
        // Test case 2: Branch taken (PC = EX_MEM_NPC)
        EX_MEM_PCsrc_tb = 1; // Branch taken
        EX_MEM_NPC_tb = 32'h00000010; // Branch target address
        #10;

        // Test case 3: No branch (PC increments normally)
        EX_MEM_PCsrc_tb = 0; // No branch
        #10;

        // End simulation
        #10 $finish;
    end

endmodule