Of course. Here is a comprehensive set of Verilog codes for the most important exercises from your lab manual that are likely to appear in your evaluation. I've focused on providing clean, well-commented code for the main design and its testbench.

---

### \#\# **Lab 5: Comparators and Multiplexers**

#### **1. 4-bit Comparator**

This circuit compares two 4-bit numbers (A and B) and outputs whether A is greater than, equal to, or less than B.

**Verilog Code (`comparator_4bit.v`)**

```verilog
// Behavioral model for a 4-bit comparator
module comparator_4bit (
    input wire [3:0] A,    // 4-bit input A
    input wire [3:0] B,    // 4-bit input B
    output reg A_gt_B, // Output for A > B
    output reg A_eq_B, // Output for A = B
    output reg A_lt_B  // Output for A < B
);

    // Use an always block to describe the combinational logic
    always @(*) begin
        if (A > B) begin
            A_gt_B = 1'b1;
            A_eq_B = 1'b0;
            A_lt_B = 1'b0;
        end else if (A < B) begin
            A_gt_B = 1'b0;
            A_eq_B = 1'b0;
            A_lt_B = 1'b1;
        end else begin // A must be equal to B
            A_gt_B = 1'b0;
            A_eq_B = 1'b1;
            A_lt_B = 1'b0;
        end
    end
endmodule
```

**Testbench (`tb_comparator_4bit.v`)**

```verilog
`timescale 1ns/1ps
module tb_comparator_4bit;
    reg [3:0] A, B;
    wire A_gt_B, A_eq_B, A_lt_B;

    comparator_4bit uut (A, B, A_gt_B, A_eq_B, A_lt_B);

    initial begin
        $dumpfile("comparator_4bit.vcd");
        $dumpvars(0, tb_comparator_4bit);

        // Test Case 1: A > B
        A = 4'd10; B = 4'd5; #20;

        // Test Case 2: A < B
        A = 4'd3; B = 4'd7; #20;

        // Test Case 3: A = B
        A = 4'd12; B = 4'd12; #20;

        $finish;
    end
endmodule
```

---

#### **2. 4-to-1 Multiplexer using `case` statement**

A multiplexer (MUX) selects one of several input lines and forwards it to a single output line. The `case` statement is a clean way to implement this.

**Verilog Code (`mux_4to1.v`)**

```verilog
// Behavioral model for a 4-to-1 multiplexer using a case statement
module mux_4to1 (
    input wire [3:0] D,    // 4 data inputs (D3, D2, D1, D0)
    input wire [1:0] S,    // 2 select lines
    output reg F           // 1 output
);

    // This combinational block is sensitive to any change in inputs
    always @(*) begin
        case (S)
            2'b00: F = D[0];
            2'b01: F = D[1];
            2'b10: F = D[2];
            2'b11: F = D[3];
            default: F = 1'bx; // Assign unknown if select is unknown
        endcase
    end
endmodule
```

**Testbench (`tb_mux_4to1.v`)**

```verilog
`timescale 1ns/1ps
module tb_mux_4to1;
    reg [3:0] D;
    reg [1:0] S;
    wire F;

    mux_4to1 uut (D, S, F);

    initial begin
        $dumpfile("mux_4to1.vcd");
        $dumpvars(0, tb_mux_4to1);

        D = 4'b1011; // D3=1, D2=0, D1=1, D0=1

        // Cycle through all select line combinations
        S = 2'b00; #20; // F should be D[0] (1)
        S = 2'b01; #20; // F should be D[1] (1)
        S = 2'b10; #20; // F should be D[2] (0)
        S = 2'b11; #20; // F should be D[3] (1)

        $finish;
    end
endmodule
```

---

### \#\# **Lab 6: Decoders and Encoders**

#### **1. 3-to-8 Decoder (Hierarchical Design)**

This design shows how to build a larger decoder from smaller ones, a key concept called **hierarchical design**. We'll build a 3-to-8 decoder using two 2-to-4 decoders.

**Verilog Code (`decoder_3to8.v`)**

```verilog
// File: decoder_3to8.v
// This file must contain both modules.

// First, define the 2-to-4 decoder building block
module decoder_2to4 (
    input wire [1:0] W,
    input wire En,
    output reg [3:0] Y
);
    always @(*) begin
        if (!En) begin
            Y = 4'b0000;
        end else begin
            case (W)
                2'b00: Y = 4'b0001;
                2'b01: Y = 4'b0010;
                2'b10: Y = 4'b0100;
                2'b11: Y = 4'b1000;
                default: Y = 4'b0000;
            endcase
        end
    end
endmodule

// Now, build the 3-to-8 decoder using two 2-to-4 decoders
module decoder_3to8 (
    input wire [2:0] W,
    input wire En,
    output wire [7:0] Y
);
    wire en0, en1;

    // The most significant bit (W[2]) enables one of the two decoders
    assign en0 = En & (~W[2]);
    assign en1 = En & W[2];

    // Instantiate the two decoders
    // First decoder handles outputs Y[3:0]
    decoder_2to4 d0 (.W(W[1:0]), .En(en0), .Y(Y[3:0]));

    // Second decoder handles outputs Y[7:4]
    decoder_2to4 d1 (.W(W[1:0]), .En(en1), .Y(Y[7:4]));
endmodule
```

**Testbench (`tb_decoder_3to8.v`)**

```verilog
`timescale 1ns/1ps
module tb_decoder_3to8;
    reg [2:0] W;
    reg En;
    wire [7:0] Y;

    decoder_3to8 uut (W, En, Y);

    initial begin
        $dumpfile("decoder_3to8.vcd");
        $dumpvars(0, tb_decoder_3to8);

        En = 1;
        // Cycle through all possible inputs
        for (integer i = 0; i < 8; i = i + 1) begin
            W = i;
            #20;
        end

        // Test disable
        En = 0;
        W = 3'b101; #20;

        $finish;
    end
endmodule
```

---

#### **2. 4-to-2 Priority Encoder**

In a priority encoder, if multiple inputs are high, the one with the highest priority (usually the highest index) wins. The `casex` statement is perfect for this, as it treats 'x' as a don't-care.

**Verilog Code (`priority_encoder_4to2.v`)**

```verilog
// Behavioral model for a 4-to-2 priority encoder
module priority_encoder_4to2 (
    input wire [3:0] W, // Inputs W[3] (highest priority) to W[0]
    output reg [1:0] Y, // Encoded output
    output reg z        // Valid output indicator (1 if any input is high)
);

    always @(*) begin
        z = 1'b1; // Assume valid output by default
        casex (W) // casex treats 'x' as a don't-care
            4'b1xxx: Y = 2'b11; // If W[3] is high, others don't matter
            4'b01xx: Y = 2'b10; // If W[3]=0 and W[2]=1
            4'b001x: Y = 2'b01; // etc.
            4'b0001: Y = 2'b00;
            default: begin
                Y = 2'bxx; // Output is don't-care
                z = 1'b0;  // No valid input is high
            end
        endcase
    end
endmodule
```

**Testbench (`tb_priority_encoder_4to2.v`)**

```verilog
`timescale 1ns/1ps
module tb_priority_encoder_4to2;
    reg [3:0] W;
    wire [1:0] Y;
    wire z;

    priority_encoder_4to2 uut (W, Y, z);

    initial begin
        $dumpfile("priority_encoder_4to2.vcd");
        $dumpvars(0, tb_priority_encoder_4to2);

        W = 4'b0000; #20; // z=0
        W = 4'b0001; #20; // Y=00
        W = 4'b0100; #20; // Y=10
        W = 4'b1010; #20; // Test priority: W[3] wins, Y=11
        W = 4'b0111; #20; // Test priority: W[2] wins, Y=10

        $finish;
    end
endmodule
```

---

### \#\# **Lab 8: Registers**

#### **Universal Shift Register**

This is a versatile 4-bit register that can **hold**, **shift left**, **shift right**, and **parallel load** based on two control inputs (`S1`, `S0`).

**Verilog Code (`universal_shift_reg.v`)**

```verilog
// 4-bit Universal Shift Register
module universal_shift_reg (
    input wire clk, reset,
    input wire [1:0] S,          // Mode select S1,S0
    input wire [3:0] P_in,       // Parallel data in
    input wire SL_in, SR_in,     // Serial Left/Right inputs
    output reg [3:0] Q           // Register output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 4'b0000;
        end else begin
            case (S)
                2'b00: Q <= Q;                         // Hold state
                2'b01: Q <= {Q[2:0], SR_in};            // Shift Right
                2'b10: Q <= {SL_in, Q[3:1]};            // Shift Left
                2'b11: Q <= P_in;                      // Parallel Load
                default: Q <= Q;
            endcase
        end
    end
endmodule
```

**Testbench (`tb_universal_shift_reg.v`)**

```verilog
`timescale 1ns/1ps
module tb_universal_shift_reg;
    reg clk, reset, SL_in, SR_in;
    reg [1:0] S;
    reg [3:0] P_in;
    wire [3:0] Q;

    universal_shift_reg uut (clk, reset, S, P_in, SL_in, SR_in, Q);

    initial begin clk=0; forever #10 clk=~clk; end

    initial begin
        $dumpfile("universal_shift_reg.vcd");
        $dumpvars(0, tb_universal_shift_reg);

        // 1. Reset
        reset = 1; #25;
        reset = 0;

        // 2. Parallel Load
        S = 2'b11; P_in = 4'b1101; #20;

        // 3. Shift Right (SR_in = 0)
        S = 2'b01; SR_in = 0; #20; // Q should be 0110
        #20;                      // Q should be 0011

        // 4. Shift Left (SL_in = 1)
        S = 2'b10; SL_in = 1; #20; // Q should be 0111
        #20;                      // Q should be 1111

        // 5. Hold
        S = 2'b00; #40;

        $finish;
    end
endmodule
```

### \#\# **Commands to Run Any Simulation**

Use the same commands for all examples. Just replace the filenames. For the Universal Shift Register:

1.  **Compile**: `iverilog -o shift_sim universal_shift_reg.v tb_universal_shift_reg.v`
2.  **Run**: `vvp shift_sim`
3.  **View**: `gtkwave universal_shift_reg.vcd`
