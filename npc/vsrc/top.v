module top (
    // input clk,
    // input rst,
    // output reg [15:0] led
    input a,
    input b,
    output f
);
    assign f = a ^ b;
// water_light light1 (
//     .clk(clk),
//     .rst(rst),
//     .led(led)
// );

endmodule
