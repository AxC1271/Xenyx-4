`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andrew Chen
// 
// Create Date: 10/1/2025 06:23:17 PM
// Design Name: Control Unit
// Module Name: control_unit
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

module control_unit (
    input  wire [6:0]  opcode,    // bits [6:0]
    input  wire [2:0]  funct3,    // bits [14:12]
    input  wire [6:0]  funct7,    // bits [31:25]
    
    output reg         regwrite,  
    output reg         memread,   
    output reg         memwrite,  
    output reg         brancheq,  
    output reg         memtoreg,  
    output reg         alusrc,   
    output reg [2:0]   alucont,  
    output reg         jmp,      
    output reg         print     
);

    // defined opcode constants
    localparam OP_R_TYPE   = 7'b0110011;
    localparam OP_I_ARITH  = 7'b0010011;
    localparam OP_LOAD     = 7'b0000011;
    localparam OP_STORE    = 7'b0100011;
    localparam OP_BRANCH   = 7'b1100011;
    localparam OP_JAL      = 7'b1101111;
    localparam OP_JALR     = 7'b1100111;
    localparam OP_PRINT    = 7'b1111111;

    // funct3 constants
    localparam F3_ADD_SUB = 3'b000;
    localparam F3_AND     = 3'b111;
    localparam F3_OR      = 3'b110;
    localparam F3_XOR     = 3'b100;
    localparam F3_BEQ     = 3'b000;

    // funct7 constants
    localparam F7_ADD     = 7'b0000000;
    localparam F7_SUB     = 7'b0100000;

    always @(*) begin
        // Default outputs
        regwrite = 0;
        memread  = 0;
        memwrite = 0;
        brancheq = 0;
        memtoreg = 0;
        alusrc   = 0;
        alucont  = 3'b000;
        jmp      = 0;
        print    = 0;

        case (opcode)
            OP_R_TYPE: begin
                regwrite = 1;
                alusrc = 0; // second operand is register

                case (funct3)
                    F3_ADD_SUB: begin
                        if (funct7 == F7_ADD)
                            alucont = 3'b000; // ADD
                        else if (funct7 == F7_SUB)
                            alucont = 3'b001; // SUB
                    end
                    F3_AND: alucont = 3'b010;
                    F3_OR : alucont = 3'b011;
                    F3_XOR: alucont = 3'b100;
                    default: alucont = 3'b000; // default ADD
                endcase
            end

            OP_I_ARITH: begin
                regwrite = 1;
                alusrc = 1; // second operand is immediate

                case (funct3)
                    F3_ADD_SUB: alucont = 3'b000; // ADDI
                    default: alucont = 3'b000;
                endcase
            end

            OP_LOAD: begin
                regwrite = 1;
                memread = 1;
                memtoreg = 1;
                alusrc = 1;
                alucont = 3'b000;
            end

            OP_STORE: begin
                memwrite = 1;
                alusrc = 1;
                alucont = 3'b000;
            end

            OP_BRANCH: begin
                brancheq = 1;
                alusrc = 0;
                alucont  = 3'b001; // SUB for comparison
            end

            OP_JAL: begin
                regwrite = 1;
                jmp      = 1;
                alusrc   = 1;
            end

            OP_JALR: begin
                regwrite = 1;
                jmp      = 1;
                alusrc   = 1;
            end

            OP_PRINT: print = 1;

            default: ; // do nothing
        endcase
    end

endmodule
