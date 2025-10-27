// File: async_counter_4bit.v
// 4-bit asynchronous (ripple) up-counter.

module async_counter_4bit (
    input wire clk,    // Main system clock
    input wire reset,  // Asynchronous reset for all FFs
    output wire [3:0] Q  // 4-bit counter output
);

    // We tie the T input of all FFs to '1' to make them toggle
    wire t_enable = 1'b1;

    // Instantiate the 4 T-Flip Flops
    
    // FF 0 (LSB): Clocked by the main system clock
    t_ff_negedge ff0 (
        .T(t_enable), 
        .clk(clk), 
        .reset(reset), 
        .Q(Q[0])
    );

    // FF 1: Clocked by the output of FF 0 (Q[0])
    t_ff_negedge ff1 (
        .T(t_enable), 
        .clk(Q[0]), 
        .reset(reset), 
        .Q(Q[1])
    );

    // FF 2: Clocked by the output of FF 1 (Q[1])
    t_ff_negedge ff2 (
        .T(t_enable), 
        .clk(Q[1]), 
        .reset(reset), 
        .Q(Q[2])
    );

    // FF 3 (MSB): Clocked by the output of FF 2 (Q[2])
    t_ff_negedge ff3 (
        .T(t_enable), 
        .clk(Q[2]), 
        .reset(reset), 
        .Q(Q[3])
    );

endmodule