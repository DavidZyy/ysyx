/* general registers */

`include "./include/defines.v"
import "DPI-C" function void set_gpr_ptr(input logic [63:0] a []);

module RegisterFile #(ADDR_WIDTH = `RegIdWidth, DATA_WIDTH = `RegWidth) (
  input clk,
  input [DATA_WIDTH-1:0] reg_wdata,
  input [ADDR_WIDTH-1:0] rd,
  input wen,
  input [ADDR_WIDTH-1:0] rs1,
  input [ADDR_WIDTH-1:0] rs2,

  output [DATA_WIDTH-1:0] rdata_1,
  output [DATA_WIDTH-1:0] rdata_2
);

  reg [DATA_WIDTH-1:0] rf [`RegCnt-1:0];

  initial set_gpr_ptr(rf);  // rf为通用寄存器的二维数组变量

  // always @(posedge clk) begin
  always @(negedge clk) begin
    if (wen) rf[rd] <= reg_wdata;
  end

  assign rdata_1 = rf[rs1];
  assign rdata_2 = rf[rs2];
endmodule
