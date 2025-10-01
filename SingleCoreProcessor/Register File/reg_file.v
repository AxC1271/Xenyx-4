`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andrew Chen
// 
// Create Date: 10/1/2025 05:24:17 PM
// Design Name: Register File
// Module Name: reg_file
// Project Name: Xenyx-4 Multicore Processor
// Target Devices: 
// Tool Versions: Xilinx Vivado 2024.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// 32 registers, 32 bits each
// x0 = 0 (zero)
// x1 = return address (ra)
// x2 = stack pointer (sp)
// x3 = global pointer (gp)
// x4 = thread pointer (tp)
// x5-x7 = temp (t0-t2)
// x8 = saved reg/frame pointer (s0 / fp)
// x9 = saved reg (s1)
// x10-x11 = func arguments/return values (a0-a1)
// x12-x17 = func arguments (a2-a7)
// x18-x27 = saved regs (s2-s11)
// x28-x31 = temporaries (t3-t6)

module reg_file (
    input  wire        clk,
    input  wire        rst,
    input  wire [4:0]  read_addr1,   // rs1
    input  wire [4:0]  read_addr2,   // rs2
    input  wire [4:0]  write_addr,   // rd
    input  wire [31:0] write_data,   // data to write
    input  wire        reg_write,    // write enable
    output wire [31:0] read_data1,   // rs1 output
    output wire [31:0] read_data2    // rs2 output
);

  reg [4:0] registers [31:0];  // 32 registers

    // zero register constant
    localparam [4:0] ZERO_REG = 5'b00000;

    integer i;

    // reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end else if (reg_write && write_addr != ZERO_REG) begin
            registers[write_addr] <= write_data;
        end
    end

    // read with write-forwarding
    assign read_data1 = (read_addr1 == ZERO_REG) ? 32'b0 :
                        (reg_write && read_addr1 == write_addr) ? write_data :
                        registers[read_addr1];

    assign read_data2 = (read_addr2 == ZERO_REG) ? 32'b0 :
                        (reg_write && read_addr2 == write_addr) ? write_data :
                        registers[read_addr2];

endmodule
