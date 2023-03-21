// 触发器模板
module Reg #(parameter WIDTH = 1, parameter RESET_VAL = 0) (
  input clk,
  input rst,
  input [WIDTH-1:0] din,
  input wen,

  output reg [WIDTH-1:0] dout
);
  /* Trigger at negedge */
  // always @(negedge clk) begin
  always @(negedge clk) begin
    if (rst) dout <= RESET_VAL;
    else if (wen) dout <= din;
    // if (wen) dout <= din;
  end
endmodule
