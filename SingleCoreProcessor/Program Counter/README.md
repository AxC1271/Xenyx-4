# Program Counter

Welcome to the Program Counter module of this Xenyx-5 multicore processor project. This component is responsible for tracking the current instruction address during CPU operations. Below, you'll find an overview of the program counter's functionality, development process, and theoretical background.

## 🧠 Overview
The program counter is a crucial element in the CPU architecture, responsible for maintaining the address of the current instruction being executed. It ensures the sequential flow of instruction execution by incrementing the address after each instruction cycle.

## ⚙️ Functionality
- **Address Storage:** Holds the address of the current instruction in bytes.
- **Increment:** Automatically increments by 4 after each instruction, pointing to the next instruction.
- **Reset:** Can be reset to a specific address, typically the start of the program.

## ✍ Development Process

### Design
<div style="max-width: 800px; overflow-x: auto;">
    
```Verilog

```
</div>
Generally speaking, the increment for a program counter is always 4 bytes since every instruction is 32 bits long. However, since the instruction memory module uses an array with each entry being a reg[4:0] with a width of 32 bits, this is not necessary but useful to keep in mind.

### Testing
Here's the test bench for our program ocunter to ensure correctness and ideal behavior.

```Verilog

```

Here are the waveforms on Vivado to show proof of correctness.
<p align="center">
    <img src="./PCWaveform.png" />
</p>

<p align="center">
  <em>
    Figure 1: Simulation waveform showing that the program counter behaves as expected — 
    the PC updates to pc_src on rising clock edges and resets correctly when rst is high. 
  </em>  
</p>

## 💡 Theoretical Background

### Purpose
The program counter is essential for controlling the flow of instruction execution in the CPU. By maintaining and updating the instruction address, it ensures that the CPU processes instructions in the correct sequence.

### Operations
- Increment: Automatically advances to the next instruction address after each cycle.
- Reset: Can be set to a specific address to start execution from a new point, useful for program initialization or branching.

## 🔑 Importance
An efficient program counter design is crucial for optimizing CPU performance, as it directly impacts the control flow and execution speed of instructions.


