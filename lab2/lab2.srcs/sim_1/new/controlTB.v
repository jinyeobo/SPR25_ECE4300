`timescale 1ns/1ps

module controlTB;

    // Inputs
    reg [5:0] opcode;
    reg clk;
    
    // Outputs
    wire [1:0] alu_op;
    wire reg_dst;
    wire alu_src;
    wire branch;
    wire mem_read;
    wire mem_write;
    wire reg_write;
    wire mem_to_reg;
    
    // Instantiate the Unit Under Test (UUT)
    control uut (
        .clk(clk),
        .opcode(opcode),
        .alu_op(alu_op),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .branch(branch),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .mem_to_reg(mem_to_reg)
    );
        // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        // Initialize Inputs
        opcode = 0;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        // Add stimulus here
        $display("Time\tOpcode\t\tRegDst\tALUSrc\tMemtoReg\tRegWrite\tMemRead\tMemWrite\tBranch\tALUOp");
        $display("------------------------------------------------------------------------------------------");
        
        // Test R-type instruction
        opcode = 6'b000000;
        #10;
        $display("%0t\t%h (R-type)\t%b\t%b\t%b\t\t%b\t\t%b\t%b\t\t%b\t%b", 
                $time, opcode, reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op);
        
        // Test lw instruction
        opcode = 6'b100011;
        #10;
        $display("%0t\t%h (lw)\t%b\t%b\t%b\t\t%b\t\t%b\t%b\t\t%b\t%b", 
                $time, opcode, reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op);
        
        // Test sw instruction
        opcode = 6'b101011;
        #10;
        $display("%0t\t%h (sw)\t%b\t%b\t%b\t\t%b\t\t%b\t%b\t\t%b\t%b", 
                $time, opcode, reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op);
        
        // Test beq instruction
        opcode = 6'b000100;
        #10;
        $display("%0t\t%h (beq)\t%b\t%b\t%b\t\t%b\t\t%b\t%b\t\t%b\t%b", 
                $time, opcode, reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op);
        
        // Test unknown instruction
        opcode = 6'b111111;
        #10;
        $display("%0t\t%h (unknown)\t%b\t%b\t%b\t\t%b\t\t%b\t%b\t\t%b\t%b", 
                $time, opcode, reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op);
        
        // Finish simulation
        #10;
        $finish;
    end
    
    // Optional: Create VCD file for waveform viewing
    initial begin
        $dumpfile("control_waveform.vcd");
        $dumpvars(0, controlTB);
    end
    
endmodule