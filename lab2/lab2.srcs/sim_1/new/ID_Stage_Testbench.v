`timescale 1ns/1ps

module ID_Stage_Testbench;

    // Inputs
    reg clk;
    reg [31:0] instr;
    reg [31:0] npc;
    reg [4:0] write_reg;
    reg [31:0] write_data;
    reg reg_write;
    
    // Outputs
    wire [8:0] control_bits;    
    wire [31:0] npc_out, reg_rs_out, reg_rt_out, sign_ext_out;
    wire [4:0] rt_out, rd_out;
    
    // Instantiate the ID stage
    final_ID_stage uut (
        .clk(clk),
        .instr(instr),
        .npc(npc),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(reg_write),
        .control_bits(control_bits),
        .npc_out(npc_out),
        .reg_rs(reg_rs_out),
        .reg_rt(reg_rt_out),
        .sign_ext(sign_ext_out),
        .rt(rt_out),
        .rd(rd_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test cases
    initial begin
        // Initialize inputs
        npc = 0;
        write_reg = 0;
        write_data = 0;
        reg_write = 0;
        
        
        $display("Time\tInstr\t\tControl\tNPC\tRegRs\tRegRt\tSignExt\tRt\tRd");
        $display("------------------------------------------------------------------");
        
        // Test case 1: 002300AA
        #10;
//        instr = 32'h002300AA;
        instr = 32'h00a41020;
        npc = 32'h00000004;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 2: 10654321
        #10;
        instr = 32'h10654321;
        npc = 32'h00000008;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 3: 00100022
        #10;
        instr = 32'h00100022;
        npc = 32'h0000000C;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 4: 8C123456
        #10;
        instr = 32'h8C123456;
        npc = 32'h00000010;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 5: 8F123456
        #10;
        instr = 32'h8F123456;
        npc = 32'h00000014;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 6: AD654321
        #10;
        instr = 32'hAD654321;
        npc = 32'h00000018;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 7: 13012345
        #10;
        instr = 32'h13012345;
        npc = 32'h0000001C;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 8: AC654321
        #10;
        instr = 32'hAC654321;
        npc = 32'h00000020;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Test case 9: 12012345
        #10;
        instr = 32'h12012345;
        npc = 32'h00000024;
        #10;
        $display("%0t\t%h\t%b\t%h\t%h\t%h\t%h\t%h\t%h", 
                $time, instr, control_bits, npc_out, reg_rs_out, reg_rt_out, sign_ext_out, rt_out, rd_out);
        
        // Finish simulation
        #10;
        $finish;
    end
    
endmodule