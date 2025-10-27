Of course\! Here are the complete Verilog codes and their corresponding testbenches for the "Additional Exercises" from each lab.

---

### \#\# **Lab 1: Introduction to Verilog**

This exercise is to implement two Boolean functions and use a testbench to verify they are functionally equivalent.

#### **Verilog Code: `lab1_equiv.v`**

```verilog
// Implements functions f1 and f2 for comparison
module lab1_equiv (
    input wire a, b, c,
    output wire f1,
    output wire f2
);
    // f1 = a'c' + bc + b'c'
    assign f1 = (~a & ~c) | (b & c) | (~b & ~c);

    // f2 = (a + b' + c)(a + b + c')(a' + b + c')
    assign f2 = (a | ~b | c) & (a | b | ~c) & (~a | b | c);

endmodule
```

#### **Testbench: `tb_lab1_equiv.v`**

This testbench iterates through all 8 possible input combinations of `a`, `b`, and `c` and displays the outputs `f1` and `f2`, allowing you to see that they are always identical.

```verilog
`timescale 1ns/1ps
module tb_lab1_equiv;
    reg a, b, c;
    wire f1, f2;

    lab1_equiv uut (a, b, c, f1, f2);

    initial begin
        $dumpfile("lab1_equiv.vcd");
        $dumpvars(0, tb_lab1_equiv);

        $display("a b c | f1 | f2 | Equivalent?");
        // Test all 8 possible input combinations
        for (integer i = 0; i < 8; i = i + 1) begin
            {a, b, c} = i;
            #10;
            $display("%b %b %b | %b  | %b  | %s", a, b, c, f1, f2, (f1 === f2) ? "Yes" : "No");
        end

        $finish;
    end
endmodule
```

---

### \#\# **Lab 3: Multilevel Synthesis**

This exercise implements a simplified function using **only NAND gates**.

#### **Verilog Code: `lab3_nand_only.v`**

```verilog
// Structural model of f = A'B + BD' + B'C'D using only NAND gates
module lab3_nand_only (
    input wire A, B, C, D,
    output wire f
);
    wire w1, w2, w3, A_n, D_n, B_n, C_n;

    // Use inverters made from NAND gates for clarity
    nand(A_n, A, A);
    nand(D_n, D, D);
    nand(B_n, B, B);
    nand(C_n, C, C);

    // First level of NAND gates for each product term
    nand n1 (w1, A_n, B);        // (A'B)'
    nand n2 (w2, B, D_n);        // (BD')'
    nand n3 (w3, B_n, C_n, D);   // (B'C'D)'

    // Final output NAND gate to OR the terms
    nand n4 (f, w1, w2, w3);

endmodule
```

#### **Testbench: `tb_lab3_nand_only.v`**

This testbench iterates through all 16 input combinations to verify the NAND-only circuit against the original Boolean expression.

```verilog
`timescale 1ns/1ps
module tb_lab3_nand_only;
    reg A, B, C, D;
    wire f_structural;
    wire f_behavioral;

    lab3_nand_only uut (A, B, C, D, f_structural);

    // Behavioral model for verification
    assign f_behavioral = (~A & B) | (B & ~D) | (~B & ~C & D);

    initial begin
        $dumpfile("lab3_nand_only.vcd");
        $dumpvars(0, tb_lab3_nand_only);

        for (integer i = 0; i < 16; i = i + 1) begin
            {A, B, C, D} = i;
            #10;
        end
        $finish;
    end
endmodule
```

---

### \#\# **Lab 4: Arithmetic Circuits**

This exercise implements a **2-digit BCD adder** by connecting two 1-digit BCD adders hierarchically.

#### **Verilog Code: `bcd_2digit_adder.v`**

```verilog
// This file should contain both modules

// Module for a single-digit BCD adder
module bcd_1digit_adder (
    input wire [3:0] A, input wire [3:0] B, input wire Cin,
    output wire Cout, output wire [3:0] S
);
    wire [4:0] Z;
    assign Z = A + B + Cin;
    assign Cout = (Z > 9);
    assign S = (Z > 9) ? Z[3:0] + 4'd6 : Z[3:0];
endmodule

// Hierarchical module for the 2-digit BCD adder
module bcd_2digit_adder (
    input wire [7:0] A, input wire [7:0] B,
    output wire Cout, output wire [7:0] S
);
    wire c_intermediate;

    // Instantiate adder for the units digit (LSB)
    bcd_1digit_adder units_adder (.A(A[3:0]), .B(B[3:0]), .Cin(1'b0),
                                  .Cout(c_intermediate), .S(S[3:0]));

    // Instantiate adder for the tens digit (MSB)
    bcd_1digit_adder tens_adder (.A(A[7:4]), .B(B[7:4]), .Cin(c_intermediate),
                                 .Cout(Cout), .S(S[7:4]));
endmodule
```

#### **Testbench: `tb_bcd_2digit_adder.v`**

This testbench provides three cases to check the BCD adder: one without a carry between digits, one with a carry, and one with a final carry out.

```verilog
`timescale 1ns/1ps
module tb_bcd_2digit_adder;
    reg [7:0] A, B;
    wire Cout;
    wire [7:0] S;

    bcd_2digit_adder uut (A, B, Cout, S);

    initial begin
        $dumpfile("bcd_2digit_adder.vcd");
        $dumpvars(0, tb_bcd_2digit_adder);

        // Case 1: 12 + 23 = 35 (No carries)
        A = 8'h12; B = 8'h23; #20;

        // Case 2: 28 + 39 = 67 (Carry from units to tens)
        A = 8'h28; B = 8'h39; #20;

        // Case 3: 91 + 18 = 109 (Final carry out)
        A = 8'h91; B = 8'h18; #20;

        $finish;
    end
endmodule
```

---

### \#\# **Lab 7: Flip Flops**

#### **1. Negative-Edge T-FF with Synchronous Reset**

**Verilog Code: `tff_sync_reset.v`**

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
    end
endmodule
```

**Testbench: `tb_tff_sync_reset.v`**
This testbench first verifies that the reset only occurs on a negative clock edge, then checks the toggle and hold functionality.

```verilog
`timescale 1ns/1ps
module tb_tff_sync_reset;
    reg T, clk, reset;
    wire Q;

    tff_sync_reset uut (T, clk, reset, Q);
    initial begin clk = 0; forever #10 clk=~clk; end

    initial begin
        $dumpfile("tff_sync_reset.vcd");
        $dumpvars(0, tb_tff_sync_reset);

        // 1. Test synchronous reset
        reset = 1; T = 1; #25; // Reset should activate on the second negedge

        // 2. De-assert reset and test toggle
        reset = 0; T = 1; #40; // Should toggle twice

        // 3. Test hold
        T = 0; #40; // Should hold its value

        $finish;
    end
endmodule
```

#### **2. Positive-Edge JK-FF with Asynchronous Active-Low Reset**

**Verilog Code: `jkff_async_reset.v`**

```verilog
module jkff_async_reset (
    input wire J, K, clk, reset_n, // reset_n is active-low
    output reg Q
);
    // Sensitive to clock OR the reset for asynchronous behavior
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

**Testbench: `tb_jkff_async_reset.v`**
This testbench verifies that the reset happens immediately when `reset_n` goes low, and then cycles through the standard JK operations.

```verilog
`timescale 1ns/1ps
module tb_jkff_async_reset;
    reg J, K, clk, reset_n;
    wire Q;

    jkff_async_reset uut (J, K, clk, reset_n, Q);
    initial begin clk=0; forever #10 clk=~clk; end

    initial begin
        $dumpfile("jkff_async_reset.vcd");
        $dumpvars(0, tb_jkff_async_reset);

        // 1. Test asynchronous reset
        reset_n = 0; J = 1; K = 1; #15; // Should reset immediately

        // 2. De-assert reset and test JK functions
        reset_n = 1; #10;
        J = 1; K = 0; #20; // Set
        J = 1; K = 1; #20; // Toggle
        J = 0; K = 1; #20; // Reset
        J = 0; K = 0; #20; // Hold

        $finish;
    end
endmodule
```

---

### \#\# **Lab 10: Counters**

#### **1. 4-bit Synchronous Up/Down Counter**

**Verilog Code: `sync_up_down_counter.v`**

```verilog
// Behavioral model of a 4-bit synchronous counter
module sync_up_down_counter (
    input wire clk, reset, W, // W=1 for UP, W=0 for DOWN
    output reg [3:0] Q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 4'b0000;
        else if (W) // If W is high, count up
            Q <= Q + 1;
        else // If W is low, count down
            Q <= Q - 1;
    end
endmodule
```

#### **Testbench: `tb_sync_up_down_counter.v`**

This testbench verifies the reset, then counts up for a few cycles, and finally switches to counting down.

```verilog
`timescale 1ns/1ps
module tb_sync_up_down_counter;
    reg clk, reset, W;
    wire [3:0] Q;

    sync_up_down_counter uut (clk, reset, W, Q);
    initial begin clk=0; forever #10 clk=~clk; end

    initial begin
        $dumpfile("sync_up_down_counter.vcd");
        $dumpvars(0, tb_sync_up_down_counter);

        // 1. Reset
        reset = 1; W = 0; #25;
        reset = 0;

        // 2. Count UP
        W = 1; #80; // Count up for 4 cycles (0->1->2->3->4)

        // 3. Count DOWN
        W = 0; #100; // Count down for 5 cycles (4->3->2->1->0->15)

        $finish;
    end
endmodule
```
