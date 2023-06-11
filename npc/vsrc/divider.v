// module divider(clk, clk_N);
/* verilator lint_off TIMESCALEMOD */
module divider #(parameter N = 1) (
    input clk,
    input rst,

    output reg clk_N
);

  reg [31:0] counter;

//   always @(posedge clk or negedge clk)  begin
  always @(posedge clk)  begin
    if(rst) begin
        counter <= 0;
        clk_N <= 0;
    end
    else begin
        if (counter == N/2-1) begin
          clk_N   <= ~clk_N;
          counter <= 0;
        end
        else begin
            counter <= counter + 1;
        //   clk_N <= clk_N;
        end
    end
  end
endmodule

// N       : 2, 4, 8
// N/2 - 1 : 0, 1, 3