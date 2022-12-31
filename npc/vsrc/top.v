module top (
    input clk,
    input rst,
    output reg [15:0] led
);
    // assign f = a ^ b;
water_light light1 (
    .clk(clk),
    .rst(rst),
    .led(led)
);

endmodule
