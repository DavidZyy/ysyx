// module divider(clk, clk_N);
module divider #(parameter N = 1) (
    input clk,
    input rst,

    output reg clk_N
);

  reg [31:0] counter;

  always @(posedge clk)  begin
    if(rst) begin
        counter <= 0;
        clk_N <= 0;
    end
    else begin
        counter <= counter + 1;
        if (counter == N-1) begin
          clk_N   <= ~clk_N;
          counter <= 0;
        end
        else begin
          clk_N <= clk_N;
        end
    end
  end
endmodule
