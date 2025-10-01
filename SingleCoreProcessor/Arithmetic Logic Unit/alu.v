`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andrew Chen
// 
// Create Date: 10/1/2025 06:05:23 PM
// Design Name: Arithmetic Logic Unit
// Module Name: alu
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

module alu (
    input  wire [31:0] op1,       // first operand
    input  wire [31:0] op2,       // second operand
    input  wire [2:0]  opcode,    // 3-bit operation selector
    output reg  [31:0] res,       // result output
    output reg         zero_flag  // zero flag for branches
);

    always @(*) begin
        case (opcode)
            3'b000: res = op1 + op2;                     // ADD
            3'b001: res = op1 - op2;                     // SUB
            3'b010: res = op1 & op2;                     // AND
            3'b011: res = op1 | op2;                     // OR
            3'b100: res = op1 ^ op2;                     // XOR
            3'b101: res = (op1 < op2) ? 32'b1 : 32'b0;   // SLT (unsigned)
            3'b110: res = op1 << op2[4:0];               // SLL
            3'b111: res = op1 >> op2[4:0];               // SRL (logical right shift)
            default: res = 32'b0;
        endcase

        zero_flag = (res == 32'b0) ? 1'b1 : 1'b0;
    end

endmodule
