// module divider(clk, clk_N);
module divider #(parameter N = 1) (
    input clk,
    input rst,

    output reg clk_N
);

//   input clk;                          // 系统时钟
//   output reg clk_N;                   // 分频后的时钟
  reg [31:0] counter;

//    parameter N = 500_000_00;
//   initial begin
//     counter = 0;
//     clk_N = 0;
//   end
  always @(posedge clk)  begin    // 时钟上升沿
    if(rst) begin
        counter <= 0;
        clk_N <= 0;
    end
    else begin
        counter = counter + 1;
        if (counter == N) begin
          clk_N   <= ~clk_N;
          counter <= 0;
        end
        else begin
          clk_N = clk_N;
        end   
    end
  end
endmodule
