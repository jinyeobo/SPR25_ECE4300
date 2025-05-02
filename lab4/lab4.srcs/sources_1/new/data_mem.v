`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2025 04:34:57 PM
// Design Name: 
// Module Name: data_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module data_mem(
    input memread, memwrite,
    input [31:0] addr, write_data,
    
    output reg [31:0] read_data 
    );

    // Memory array (256 words as specified in Lab 4)
    reg [31:0] memory [0:255];

    // Memory read operation (combinational)
    always @(*) begin
        if (memread) begin
            // Check for valid address range
            if (addr[31:8] == 24'b0) begin  // Only use 8 LSBs (256 words)
                read_data = memory[addr[7:0]];
            end else begin
                read_data = 32'hxxxxxxxx;  // Undefined for out-of-range addresses
            end
        end else begin
            read_data = 32'hzzzzzzzz;  // High impedance when not reading
        end
    end

    // Memory write operation (combinational)
    always @(*) begin
        if (memwrite) begin
            // Check for valid address range
            if (addr[31:8] == 24'b0) begin  // Only use 8 LSBs (256 words)
                memory[addr[7:0]] = write_data;
            end
            // Note: Writes to out-of-range addresses are ignored
        end
    end
endmodule
