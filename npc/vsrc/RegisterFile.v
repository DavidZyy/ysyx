/* general registers */

`include "./include/defines.v"

module RegisterFile #(ADDR_WIDTH = `RegCnt, DATA_WIDTH = `RegWidth) (
  input clk,
  input [DATA_WIDTH-1:0] wdata,
  input [ADDR_WIDTH-1:0] rd,
  input wen,
  input [ADDR_WIDTH-1:0] rs1,
  input [ADDR_WIDTH-1:0] rs2,

  output [DATA_WIDTH-1:0] rdata_1,
  output [DATA_WIDTH-1:0] rdata_2
);

  reg [DATA_WIDTH-1:0] rf [ADDR_WIDTH-1:0];
  always @(posedge clk) begin
    if (wen) rf[rd] <= wdata;
  end

  assign rdata_1 = rf[rs1];
  assign rdata_2 = rf[rs2];
endmodule
