`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2025 04:53:46 PM
// Design Name: 
// Module Name: memory
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


module memory(
    input clk,
    input [31:0] ALUResult,
    input [31:0] WriteData,
    input [4:0] WriteReg,
    input [1:0] WBControl,
    input MemWrite,
    input MemRead,
    input Branch,
    input Zero,
    output [31:0] ReadData,
    output [31:0] ALUResult_out,
    output [4:0] WriteReg_out,
    output [1:0] WBControl_out,
    output PCSrc
    );
    
    wire [31:0] DataMemReadData;
    
    logic_and and_gate(
    .m_ctl(Branch),
    .zero(Zero),
    .and_out(PCSrc)
    );
    
    data_mem uut(
    .memread(MemRead),
    .memwrite(MemWrite),
    .addr(ALUResult),
    .write_data(WriteData),
    .read_data(DataMemReadData)
    );
    
    dmem_latch mem_latch(
    .clk(clk),
    .aluresult_in(ALUResult),
    .readdata_in(DataMemReadData),
    .writereg_in(WriteReg),
    .wb_ctrl(WBControl),
    .aluresult_out(ALUResult_out),
    .readdata_out(ReadData),
    .writereg_out(WriteReg_out),
    .wb_ctrl_out(WBControl_out)
    );
endmodule
