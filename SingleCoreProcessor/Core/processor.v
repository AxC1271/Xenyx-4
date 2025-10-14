`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andrew Chen
// 
// Create Date: 10/14/2025 01:19:20 PM
// Design Name: Processor
// Module Name: processor
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

module processor (
  input clk,
  input rst
);

//=============== Define Module Instances ===============/
  
  program_counter pc (
    
  );

  reg_file regs (
    
  );

  instruction_rom rom (
    
  );

  immediate_generator imm_gen (
    
  );

  control_unit cu (
    
  );

  alu alu (
    
  );

  data_memory data_mem (

  );

endmodule
