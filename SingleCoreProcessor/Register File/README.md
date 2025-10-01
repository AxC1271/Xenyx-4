# Register File

Welcome to the Register File module of the Xenyx-4 processor project. This component allows for the storage and access of data during CPU operations. Below, you'll find an overview of the register file's functionality, development process, and theoretical background. This is a modified version of the original RISC-V processor register file in Verilog but with additional naming conventions.

## 🧠 Overview
The register file is a key element in the CPU architecture, consisting of 32 registers, each 32 bits wide. It serves as a fast-access storage area for the CPU, allowing efficient data manipulation and retrieval during instruction execution.

## ⚙️ Functionality
- Registers: 32 registers, each 32 bits wide, for storing data
- Addressing: Utilizes a 5-bit standard logic vector to index the registers
- Two read addresses for accessing register values
- A write enable input to control data writing
- A write address to specify the target register for data storage
- A 32-bit wide read value for data retrieval

## ✍ Development Process

### Design
<div style="max-width: 800px; overflow-x: auto;">
    
```Verilog
`timescale 1ns / 1ps

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
```
</div>


### Testing
Here's the testbench that we are using to validate the behavior of the register file module.

```Verilog

```

Here are the waveforms on Vivado to show proof of correctness.
<p align="center">
    <img src="./Waveform.png" />
</p>
<p align="center">
    <em>Figure 1: As expected the register file works with correct reads and writes..</em>
</p>


## 💡 Theoretical Background

### Purpose
The register file acts as a temporary storage area for the CPU, allowing quick access to frequently used data. It plays a vital role in executing instructions efficiently by minimizing memory access delays.
### Operations
- Read: retrieve data from specified registers using read addresses
- Write: store data into a specified register when write enable is active

## 🔑 Importance
Efficient register file design is crucial for optimizing CPU performance, as it directly impacts the speed and efficiency of instruction execution.
