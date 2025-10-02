`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andrew Chen
// 
// Create Date: 10/2/2025 01:25:22 PM
// Design Name: Immediate Generator
// Module Name: immediate_generator
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

module immediate_generator (
  input  wire[31:0]  instruction,
  output reg[31:0]  immediate
);

  // define switch case for every scenario
  always @(*) begin
    case instruction[6:0]
      0010011: // I-type
        immediate = instruction[31:20];  
      0100011: // S-type
        immediate = {instruction[31:25]; instruction[11:7]}; 
      1100011: // B-type
        immediate = {{19{instruction[31]}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};

      // two different types of U-type instructions
      0110111: // Load Upper Immediate
        immediate = {instruction[31:12], 12'b0};
      0010111: // Add Upper Immediate to PC
        immediate = instruction[31:12];

      // two different types of J-type instructions
      1101111: // jalr
        immediate = instruction[31:20];
      1111111: // jal
        immediate = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
      default:
        immediate = 32'b0;
    endcase
  end

endmodule
