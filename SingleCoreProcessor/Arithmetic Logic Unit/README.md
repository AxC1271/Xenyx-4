# Arithmetic Logic Unit (ALU)

Welcome to the ALU module of this Xenyx-4 multicore processor project. This component is responsible for performing arithmetic and logical operations as specified by the instruction set. Below, you'll find an overview of the ALU's functionality, development process, and theoretical background.

## 🧠 Overview
The ALU is a fundamental component of the CPU architecture, executing operations on data as directed by the control unit. It supports a variety of operations, including addition, subtraction, logical operations, and shifts, which are essential for instruction execution.

## ⚙️ Functionality
- **Operands:** Accepts two 32-bit operands (`op1` and `op2`) for processing.
- **Operation Selector:** Uses a 3-bit `opcode` to determine the operation to perform.
- **Result Output:** Produces a 32-bit result (`res`) based on the selected operation.
- **Zero Flag:** Outputs a `zero_flag` signal, indicating if the result is zero, useful for branch decisions.

## ✍ Development Process

### Design
<div style="max-width: 800px; overflow-x: auto;">
    
```Verilog

```

### Testing
Here's the test bench for my ALU to ensure that everything's working the way I expect.

```Verilog

```

Here is the waveform for proof of correctness:
<p align="center">
    <img src="./ALUWaveform.png" />
</p>

<p align="center">
    <em>Insert caption here.</em>
</p>

## 💡 Theoretical Background

### Purpose
The ALU is essential for executing arithmetic and logical operations within the CPU. By processing operands based on the control unit's instructions, it enables the CPU to perform calculations and make decisions.

### Operations
- Arithmetic: Performs addition and subtraction.
- Logical: Executes AND, OR, XOR operations.
- Comparison: Evaluates less-than conditions.
- Shifts: Performs left and right shifts.

## 🔑 Importance
An efficient ALU design is crucial for optimizing CPU performance, as it directly impacts the speed and accuracy of instruction execution. 
This README provides a structured overview of the ALU component, highlighting its role and functionality within the CPU architecture. 

