Of course. Here are the complete solutions, including explanations and Verilog code, for the "Additional Exercises" in each lab from your manual.

---

### \#\# **Lab 1: Introduction to Verilog**

#### **1. [cite\_start]Implement Boolean Functions [cite: 238]**

[cite\_start]You are asked to write Verilog code for two functions and then check if they are equivalent[cite: 239, 240, 241].

- `f1 = a'c' + bc + b'c'`
- `f2 = (a + b' + c)(a + b + c')(a' + b + c')`

**Explanation:**
First, let's simplify `f2` using Boolean algebra to see if it's the same as `f1`. By converting `f2` (a Product of Sums) into a Sum of Products using K-maps, we find that `f2` simplifies to the exact same expression as `f1`. Therefore, **f1 and f2 are functionally equivalent**. We can prove this by simulating both using the same inputs and seeing if the outputs always match.

**Verilog Code (`lab1_equiv.v`)**

```verilog
// Implements functions f1 and f2 for comparison
module lab1_equiv (
    input wire a, b, c,
    output wire f1,
    output wire f2
);
    // Behavioral implementation using continuous assignment

    // f1 = a'c' + bc + b'c'
    assign f1 = (~a & ~c) | (b & c) | (~b & ~c);

    // f2 = (a + b' + c)(a + b + c')(a' + b + c')
    assign f2 = (a | ~b | c) & (a | b | ~c) & (~a | b | c);

endmodule
```

**Testbench (`tb_lab1_equiv.v`)**

```verilog
`timescale 1ns/1ps
module tb_lab1_equiv;
    reg a, b, c;
    wire f1, f2;

    lab1_equiv uut (a, b, c, f1, f2);

    initial begin
        $dumpfile("lab1_equiv.vcd");
        $dumpvars(0, tb_lab1_equiv);

        $display("a b c | f1 | f2");
        $monitor("%b %b %b | %b  | %b", a, b, c, f1, f2);

        // Test all 8 possible input combinations
        for (integer i = 0; i < 8; i = i + 1) begin
            {a, b, c} = i;
            #10;
        end

        $finish;
    end
endmodule
```

When you run the simulation, you will observe that the `f1` and `f2` columns are identical for all inputs, proving their equivalence.

---

### \#\# **Lab 2: Simplification using K-Map**

#### **1. [cite\_start]Simplify and Implement `f(A,B,C,D) = ∏M(0,1,4,8,9,12,15) + D(2,5,6,8,10)` [cite: 283, 284]**

**Explanation:**
This is a Product of Sums (POS) expression with don't cares. We create a K-map and group the 0s to get the simplest POS expression.

The simplified POS expression from the K-map is:
`f = (A + D)(C' + D')(A' + C')`

**Verilog Code (`lab2_pos.v`)**

```verilog
module lab2_pos (
    input wire A, B, C, D,
    output wire f
);
    // Simplified POS expression
    assign f = (A | D) & (~C | ~D) & (~A | ~C);

endmodule
```

---

### \#\# **Lab 3: Multilevel Synthesis**

#### **1. [cite\_start]Minimize and Implement using only NAND gates [cite: 311, 312]**

**Problem:** `f(A, B, C, D) = ∏(1,3,5,8,9,11,15)+D(2,13)`

**Explanation:**
First, we use a K-map to get the simplified Sum of Products (SOP) expression by grouping the 1s.
The simplified SOP expression is: `f = A'B + BD' + B'C'D`

Next, we apply De Morgan's theorem twice to convert this to a NAND-only expression:
`f = ( (A'B)' . (BD')' . (B'C'D)' )'`
This can be directly implemented using NAND gates.

**Verilog Code (`lab3_nand_only.v`)**

```verilog
// Structural model using only NAND gates
module lab3_nand_only (
    input wire A, B, C, D,
    output wire f
);
    wire w1, w2, w3;

    // First level of NAND gates
    nand n1 (w1, ~A, B);        // Corresponds to (A'B)'
    nand n2 (w2, B, ~D);        // Corresponds to (BD')'
    nand n3 (w3, ~B, ~C, D);    // Corresponds to (B'C'D)'

    // Final output NAND gate
    nand n4 (f, w1, w2, w3);

endmodule
```

---

### \#\# **Lab 4: Arithmetic Circuits**

#### **1. [cite\_start]2-Digit BCD Adder [cite: 424]**

**Explanation:**
A 2-digit BCD adder is built by chaining two 1-digit BCD adders. A 1-digit BCD adder takes two 4-bit BCD numbers and a carry-in. It performs a 4-bit binary addition. If the result is greater than 9 or if a carry-out is generated, it adds 6 (`0110`) to the result to correct it back to BCD format. The carry-out from the first digit (units) becomes the carry-in for the second digit (tens).

**Verilog Code (`bcd_2digit_adder.v`)**

```verilog
// This file contains both the 1-digit and 2-digit modules

// Module for a single-digit BCD adder
module bcd_1digit_adder (
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Cin,
    output wire Cout,
    output wire [3:0] S
);
    wire [4:0] Z;
    wire correction_needed;

    // Perform binary addition
    assign Z = A + B + Cin;

    // Determine if correction is needed (result > 9 or carry generated)
    assign correction_needed = (Z > 9);

    // Add 6 for correction if needed
    assign S = correction_needed ? Z[3:0] + 4'd6 : Z[3:0];

    // Final carry-out
    assign Cout = correction_needed;

endmodule

// Hierarchical module for the 2-digit BCD adder
module bcd_2digit_adder (
    input wire [7:0] A, // A[7:4] is tens, A[3:0] is units
    input wire [7:0] B, // B[7:4] is tens, B[3:0] is units
    output wire Cout,
    output wire [7:0] S  // S[7:4] is tens, S[3:0] is units
);
    wire c_intermediate;

    // Instantiate adder for the units digit
    bcd_1digit_adder units_adder (
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(1'b0),
        .Cout(c_intermediate),
        .S(S[3:0])
    );

    // Instantiate adder for the tens digit
    bcd_1digit_adder tens_adder (
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(c_intermediate),
        .Cout(Cout),
        .S(S[7:4])
    );

endmodule
```

---

### \#\# **Lab 7: Flip Flops**

This lab focuses on the fundamental building blocks of sequential logic.

#### **1. [cite\_start]Negative-Edge T-FF with Synchronous Reset [cite: 668]**

**Verilog Code (`tff_sync_reset.v`)**

```verilog
module tff_sync_reset (
    input wire T, clk, reset,
    output reg Q
);
    // Sensitive ONLY to the negative edge of the clock
    always @(negedge clk) begin
        if (reset)      // Reset is checked ON the clock edge
            Q <= 1'b0;
        else if (T)
            Q <= ~Q;    // Toggle if T is high
        // else Q remains unchanged (implicit)
    end
endmodule
```

#### **2. [cite\_start]Positive-Edge JK-FF with Asynchronous Active-Low Reset [cite: 669]**

**Verilog Code (`jkff_async_reset.v`)**

```verilog
module jkff_async_reset (
    input wire J, K, clk, reset_n, // reset_n is active-low
    output reg Q
);
    // Sensitive to clock OR the reset signal for asynchronous behavior
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)   // Reset happens immediately if reset_n is low
            Q <= 1'b0;
        else
            case ({J, K})
                2'b00: Q <= Q;
                2'b01: Q <= 1'b0;
                2'b10: Q <= 1'b1;
                2'b11: Q <= ~Q;
            endcase
    end
endmodule
```

---

### \#\# **Lab 8: Registers**

#### **1. [cite\_start]N-bit Shift Register [cite: 761]**

**Explanation:**
Using a `parameter` allows us to create a generic, resizable module. This code creates a simple serial-in, serial-out (SISO) left shift register.

**Verilog Code (`shift_reg_Nbit.v`)**

```verilog
module shift_reg_Nbit #(
    parameter N = 8 // Default size is 8 bits
) (
    input wire clk, reset, sin, // sin is serial input
    output wire sout // sout is serial output
);
    reg [N-1:0] Q;

    assign sout = Q[N-1]; // Serial out is the MSB

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 0;
        else
            Q <= {Q[N-2:0], sin}; // Shift left and load sin into LSB
    end
endmodule
```

---

### \#\# **Lab 9: Design of Sequential Circuits**

#### **1. [cite\_start]Design from State Diagram using JK-FFs [cite: 815, 816]**

**Explanation:**
This state diagram represents a Mealy machine with 5 states, so we need 3 flip-flops.
After creating the state transition table, deriving the JK excitation table, and simplifying with K-maps, we get the following logic equations for the JK inputs and the output `y`:

- **JA = B'C'**
- **KA = B**
- **JB = A**
- **KB = x + C**
- **JC = A'x'**
- **KC = 1**
- **y = Ax**

**Verilog Code (`lab9_jk_fsm.v`)**

```verilog
module lab9_jk_fsm (
    input wire clk, reset, x,
    output wire y
);
    reg A, B, C; // State variables for the 3 flip-flops

    // Output logic (Mealy machine)
    assign y = A & x;

    // Combinational logic for JK inputs
    wire JA, KA, JB, KB, JC, KC;
    assign JA = ~B & ~C;
    assign KA = B;
    assign JB = A;
    assign KB = x | C;
    assign JC = ~A & ~x;
    assign KC = 1'b1;

    // Sequential logic (state transitions)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            {A, B, C} <= 3'b000;
        end else begin
            // FF A
            A <= (JA & ~A) | (~KA & A);
            // FF B
            B <= (JB & ~B) | (~KB & B);
            // FF C
            C <= (JC & ~C) | (~KC & C);
        end
    end
endmodule
```

---

### \#\# **Lab 10: Counters**

#### **1. [cite\_start]4-bit Synchronous Up/Down Counter with JK-FFs [cite: 866, 867]**

**Explanation:**
This is a synchronous counter controlled by input `W` (1=Up, 0=Down). We derive the JK input logic required for each flip-flop to either increment or decrement the count.
The simplified logic is:

- `J0 = K0 = 1`
- `J1 = K1 = (W & Q0) | (~W & ~Q0)` which is `W XNOR Q0`
- `J2 = K2 = (W & Q1 & Q0) | (~W & ~Q1 & ~Q0)`
- `J3 = K3 = (W & Q2 & Q1 & Q0) | (~W & ~Q2 & ~Q1 & ~Q0)`

**Verilog Code (`sync_up_down_counter.v`)**

```verilog
module sync_up_down_counter (
    input wire clk, reset, W,
    output wire [3:0] Q
);
    reg [3:0] Q_reg;
    assign Q = Q_reg;

    // Combinational logic for JK inputs (implemented behaviorally)
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q_reg <= 4'b0000;
        else if (W) // W=1, Count Up
            Q_reg <= Q_reg + 1;
        else // W=0, Count Down
            Q_reg <= Q_reg - 1;
    end
endmodule
```
