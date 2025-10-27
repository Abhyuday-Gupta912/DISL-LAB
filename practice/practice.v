



// 2-to-4 Decoder with enable
module dec2to4(W, En, Y);
    input [1:0] W;
    input En;
    output reg [3:0] Y;

    always @(*) begin
        if (En) begin
            case (W)
                2'b00: Y = 4'b0001;
                2'b01: Y = 4'b0010;
                2'b10: Y = 4'b0100;
                2'b11: Y = 4'b1000;
            endcase
        end
        else
            Y = 4'b0000;
    end
endmodule
`timescale 1ns/1ns
`include "dec2to4.v"

module dec2to4_tb();
    reg [1:0] W;
    reg En;
    wire [3:0] Y;

    dec2to4 d1(W, En, Y);

    initial begin
        $dumpfile("dec2to4_tb.vcd");
        $dumpvars(0, dec2to4_tb);

        En = 1; W = 2'b00; #10;
        W = 2'b01; #10;
        W = 2'b10; #10;
        W = 2'b11; #10;

        En = 0; W = 2'b10; #10;

        $display("Decoder test complete");
    end
endmodule


// 3-to-8 Decoder with enable
module dec3to8(W, En, Y);
    input [2:0] W;
    input En;
    output reg [7:0] Y;
    integer i;

    always @(*) begin
        if (En) begin
            Y = 8'b00000000;
            for (i = 0; i < 8; i = i+1)
                if (W == i) Y[i] = 1;
        end
        else
            Y = 8'b00000000;
    end
endmodule

`timescale 1ns/1ns
`include "dec3to8.v"

module dec3to8_tb();
    reg [2:0] W;
    reg En;
    wire [7:0] Y;

    dec3to8 d2(W, En, Y);

    initial begin
        $dumpfile("dec3to8_tb.vcd");
        $dumpvars(0, dec3to8_tb);

        En = 1;
        W=3'b000; #10;
        W=3'b001; #10;
        W=3'b010; #10;
        W=3'b011; #10;
        W=3'b100; #10;
        W=3'b101; #10;
        W=3'b110; #10;
        W=3'b111; #10;

        En = 0; W=3'b101; #10;

        $display("Decoder 3:8 test complete");
    end
endmodule



// 4-to-2 Priority Encoder
module prienc4to2(W, Y, z);
    input [3:0] W;  // Inputs
    output reg [1:0] Y; // Encoded output
    output reg z;   // Valid output flag

    always @(*) begin
        casex (W)
            4'b1xxx: begin Y=2'b11; z=1; end // Highest priority
            4'b01xx: begin Y=2'b10; z=1; end
            4'b001x: begin Y=2'b01; z=1; end
            4'b0001: begin Y=2'b00; z=1; end
            default: begin Y=2'b00; z=0; end
        endcase
    end
endmodule

`timescale 1ns/1ns
`include "prienc4to2.v"

module prienc4to2_tb();
    reg [3:0] W;
    wire [1:0] Y;
    wire z;

    prienc4to2 e1(W, Y, z);

    initial begin
        $dumpfile("prienc4to2_tb.vcd");
        $dumpvars(0, prienc4to2_tb);

        W=4'b0000; #10;
        W=4'b0001; #10;
        W=4'b0010; #10;
        W=4'b0100; #10;
        W=4'b1000; #10;
        W=4'b1100; #10; // Priority check

        $display("Priority Encoder test complete");
    end
endmodule



// 16-to-4 Priority Encoder
module prienc16to4(W, Y, z);
    input [15:0] W;
    output reg [3:0] Y;
    output reg z;
    integer i;

    always @(*) begin
        z = 0;
        Y = 4'b0000;
        for (i = 15; i >= 0; i = i - 1) begin
            if (W[i]) begin
                Y = i[3:0];
                z = 1;
                disable for;
            end
        end
    end
endmodule

`timescale 1ns/1ns
`include "prienc16to4.v"

module prienc16to4_tb();
    reg [15:0] W;
    wire [3:0] Y;
    wire z;

    prienc16to4 e2(W, Y, z);

    initial begin
        $dumpfile("prienc16to4_tb.vcd");
        $dumpvars(0, prienc16to4_tb);

        W=16'h0000; #10;
        W=16'h0001; #10;
        W=16'h0080; #10;
        W=16'h4000; #10;
        W=16'hF000; #10;

        $display("16-to-4 Priority Encoder test complete");
    end
endmodule


// Positive edge-triggered D Flip-Flop with async active high reset
module dff_async(D, clk, reset, Q);
    input D, clk, reset;
    output reg Q;

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 0;
        else
            Q <= D;
    end
endmodule

`timescale 1ns/1ns
`include "dff_async.v"

module dff_async_tb();
    reg D, clk, reset;
    wire Q;

    dff_async d1(D, clk, reset, Q);

    always #10 clk = ~clk;  // clock generation

    initial begin
        $dumpfile("dff_async_tb.vcd");
        $dumpvars(0, dff_async_tb);

        clk=0; reset=0; D=0;
        #15 reset=1; #10 reset=0; // reset pulse
        D=1; #20;
        D=0; #20;
        D=1; #20;

        $display("D FF async test complete");
        $finish;
    end
endmodule


// Negative edge-triggered T Flip-Flop with async active low reset
module tff_async(T, clk, resetn, Q);
    input T, clk, resetn;
    output reg Q;

    always @(negedge clk or negedge resetn) begin
        if (!resetn)
            Q <= 0;
        else if (T)
            Q <= ~Q;
    end
endmodule

`timescale 1ns/1ns
`include "tff_async.v"

module tff_async_tb();
    reg T, clk, resetn;
    wire Q;

    tff_async t1(T, clk, resetn, Q);

    always #10 clk = ~clk;

    initial begin
        $dumpfile("tff_async_tb.vcd");
        $dumpvars(0, tff_async_tb);

        clk=0; resetn=0; T=0;
        #15 resetn=1;
        T=1; #40;
        T=0; #20;
        T=1; #40;

        $display("T FF async test complete");
        $finish;
    end
endmodule



// Positive edge-triggered JK Flip-Flop with sync active high reset
module jkff_sync(J, K, clk, reset, Q);
    input J, K, clk, reset;
    output reg Q;

    always @(posedge clk) begin
        if (reset)
            Q <= 0;
        else begin
            case ({J,K})
                2'b00: Q <= Q;       // hold
                2'b01: Q <= 0;       // reset
                2'b10: Q <= 1;       // set
                2'b11: Q <= ~Q;      // toggle
            endcase
        end
    end
endmodule

`timescale 1ns/1ns
`include "jkff_sync.v"

module jkff_sync_tb();
    reg J, K, clk, reset;
    wire Q;

    jkff_sync jk1(J, K, clk, reset, Q);

    always #10 clk = ~clk;

    initial begin
        $dumpfile("jkff_sync_tb.vcd");
        $dumpvars(0, jkff_sync_tb);

        clk=0; reset=1; J=0; K=0;
        #15 reset=0;
        J=1; K=0; #20; // Set
        J=0; K=1; #20; // Reset
        J=1; K=1; #40; // Toggle

        $display("JK FF sync test complete");
        $finish;
    end
endmodule


// Negative edge-triggered SR Flip-Flop with sync active low reset
module srff_sync(S, R, clk, resetn, Q);
    input S, R, clk, resetn;
    output reg Q;

    always @(negedge clk) begin
        if (!resetn)
            Q <= 0;
        else begin
            case ({S,R})
                2'b00: Q <= Q;   // hold
                2'b01: Q <= 0;   // reset
                2'b10: Q <= 1;   // set
                2'b11: Q <= 1'bx; // invalid
            endcase
        end
    end
endmodule

`timescale 1ns/1ns
`include "srff_sync.v"

module srff_sync_tb();
    reg S, R, clk, resetn;
    wire Q;

    srff_sync sr1(S, R, clk, resetn, Q);

    always #10 clk = ~clk;

    initial begin
        $dumpfile("srff_sync_tb.vcd");
        $dumpvars(0, srff_sync_tb);

        clk=0; resetn=0; S=0; R=0;
        #15 resetn=1;
        S=1; R=0; #20;
        S=0; R=1; #20;
        S=1; R=1; #20; // invalid
        S=0; R=0; #20;

        $display("SR FF sync test complete");
        $finish;
    end
endmodule


// 6-bit shift register (right shift)
module shiftreg6(clk, reset, SI, Q);
    input clk, reset, SI;       // SI = Serial Input
    output reg [5:0] Q;         // 6-bit register

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 6'b000000;
        else
            Q <= {SI, Q[5:1]};  // shift right
    end
endmodule

`timescale 1ns/1ns
`include "shiftreg6.v"

module shiftreg6_tb();
    reg clk, reset, SI;
    wire [5:0] Q;

    shiftreg6 s1(clk, reset, SI, Q);

    always #10 clk = ~clk;

    initial begin
        $dumpfile("shiftreg6_tb.vcd");
        $dumpvars(0, shiftreg6_tb);

        clk=0; reset=1; SI=0;
        #15 reset=0;
        SI=1; #20;
        SI=0; #20;
        SI=1; #20;
        SI=1; #20;
        SI=0; #20;

        $display("6-bit Shift Register test complete");
        $finish;
    end
endmodule


// N-bit Register (parameterized)
module regN #(parameter N=8) (clk, reset, D, Q);
    input clk, reset;
    input [N-1:0] D;
    output reg [N-1:0] Q;

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= {N{1'b0}};
        else
            Q <= D;
    end
endmodule
`timescale 1ns/1ns
`include "regN.v"

module regN_tb();
    reg clk, reset;
    reg [7:0] D;
    wire [7:0] Q;

    regN #(8) r1(clk, reset, D, Q);

    always #10 clk = ~clk;

    initial begin
        $dumpfile("regN_tb.vcd");
        $dumpvars(0, regN_tb);

        clk=0; reset=1; D=8'h00;
        #15 reset=0;
        D=8'hA5; #20;
        D=8'h3C; #20;
        D=8'hFF; #20;

        $display("N-bit Register test complete");
        $finish;
    end
endmodule


// 4-bit Shift Register with Parallel Load
module shiftreg4_parallel(clk, reset, shift, load, SI, D, Q);
    input clk, reset, shift, load, SI;
    input [3:0] D;       // Parallel input
    output reg [3:0] Q;  // Register contents

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 4'b0000;
        else begin
            case ({shift, load})
                2'b00: Q <= {Q[2:0], SI}; // Shift left
                2'b01: Q <= D;            // Parallel load
                2'b1x: Q <= Q;            // No change
            endcase
        end
    end
endmodule
`timescale 1ns/1ns
`include "shiftreg4_parallel.v"

module shiftreg4_parallel_tb();
    reg clk, reset, shift, load, SI;
    reg [3:0] D;
    wire [3:0] Q;

    shiftreg4_parallel sr(clk, reset, shift, load, SI, D, Q);

    always #10 clk = ~clk;

    initial begin
        $dumpfile("shiftreg4_parallel_tb.vcd");
        $dumpvars(0, shiftreg4_parallel_tb);

        clk=0; reset=1; shift=0; load=0; SI=0; D=4'b0000;
        #15 reset=0;

        // Parallel load
        load=1; D=4'b1010; #20; load=0;

        // Shift left
        shift=0; SI=1; #20;
        SI=0; #20;

        // Hold state
        shift=1; #20;

        $display("Shift Register with Parallel Load test complete");
        $finish;
    end
endmodule

