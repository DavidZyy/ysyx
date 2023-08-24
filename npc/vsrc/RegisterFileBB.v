/* general registers */

`define REG_OP_WIDTH 5
`define DATA_WIDTH 32
`define RegCnt     32

import "DPI-C" function void set_gpr_ptr(input logic [`DATA_WIDTH:0] a []);

module RegisterFileBB (
  input clock,
  input reset,
  input [`DATA_WIDTH-1:0] wdata,
  input [`REG_OP_WIDTH-1:0] rd,
  input reg_wen,
  input [`REG_OP_WIDTH-1:0] rs1,
  input [`REG_OP_WIDTH-1:0] rs2,

  output [`DATA_WIDTH-1:0] rdata1,
  output [`DATA_WIDTH-1:0] rdata2
);

  reg [`DATA_WIDTH-1:0] regs [`RegCnt-1:0];

  initial set_gpr_ptr(regs);  // rf为通用寄存器的二维数组变量

  always @(posedge clock) begin
    if(reset)
      regs[0] <= 0;
    /* do not write reg0, remain it to zero */
    if (reg_wen && (rd != 0)) regs[rd] <= wdata;
    else ;
  end

  assign rdata1 = regs[rs1];
  assign rdata2 = regs[rs2];
endmodule
