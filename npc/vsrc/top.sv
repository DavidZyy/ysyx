/* code style: the name of variable use snake style, 
  the name of macro use camel style. */

import "DPI-C" function void exit_code();
import "DPI-C" function void not_ipl_exception();

`include "./include/defines.v"

/* assemble all cpu moudules into top moudule */
module top(
  input clk,
  input rst,

  output [`Vec(`ImmWidth)] current_pc,
  // output [`Vec(`ImmWidth)] cur_inst_pc,
  // output reg [`Vec(`ImmWidth)] next_pc
  output [`Vec(`ImmWidth)] next_pc
);


/* verilator lint_off UNOPTFLAT */
wire [`Vec(`InstWidth)]	inst;
wire [`Vec(`AddrWidth)] waddr = alu_result;
wire [`Vec(`RegWidth)] mem_wdata = rdata_2;
wire [`Vec(`RegWidth)] mem_raddr;

memory u_memory(
	//ports
	.clk  		( clk  		),
	.pc   		( current_pc ),
  .raddr    (alu_result),
	// .pc   		( next_pc   		),
  .waddr    ( waddr ),
  .mem_wdata (mem_wdata),
  .wmask    (wmask),
  .mem_wen  (mem_wen),

	.inst ( inst 		),
  .mem_raddr(mem_raddr)
);


/* decode instructionn stage */
wire [`Vec(`RegIdWidth)]	rd;
wire [`Vec(`RegIdWidth)]	rs1;
wire [`Vec(`RegIdWidth)]	rs2;
wire [`Vec(`ImmWidth)]	imm;
/* signals */
wire 	need_imm;
wire 	alu_add;
wire  is_ebreak;
wire  is_auipc;
wire  inst_not_ipl;
wire  is_jal;
wire  is_jalr;
wire  reg_wen;
wire  mem_wen;
wire [7:0] wmask;
wire  is_load;

decoder u_decoder(
	//ports
	.inst     		( inst     		),

	.rd       		( rd       		),
	.rs1      		( rs1      		),
	.rs2      		( rs2      		),
	.imm      		( imm      		),
	.need_imm 		( need_imm 		),
	.alu_add  		( alu_add  		),
  .is_ebreak    ( is_ebreak   ),
  .is_auipc     ( is_auipc    ),
  .inst_not_ipl ( inst_not_ipl),
  .is_jal       ( is_jal ),
  .is_jalr       ( is_jalr ),
  .reg_wen  (reg_wen),
  .mem_wen  (mem_wen),
  .wmask    (wmask),
  .is_load  (is_load)
);

/*suppose one cycle is begin with the negtive cycle. 
  can not use negedge, because when in the edge of 
  neg, the pc and instructions update, but the update
  moment inst_not_ipl represent the old value, the
  new value of it is delayed. But in the posedge, 
  in the middle of the cycle, the inst_not_ipl signal
  is been updated. */
always @(posedge clk) begin
// always @(*) begin
  if (inst_not_ipl) begin
    not_ipl_exception();
    ;
  end
  else begin
    ;
  end
end

always @(posedge clk) begin
// always @(*) begin
  if (is_ebreak) begin
    exit_code();
    // assign rd = 2;
    // assign reg_wdata = 64'h80009008;
  end
  else begin
    ;
  end
end

/* execute stage */
wire [`Vec(`ImmWidth)]	reg_wdata = (is_jal | is_jalr) ? (current_pc + 4) : (is_load ? mem_raddr : alu_result);
// wire [`Vec(`ImmWidth)]	reg_wdata = is_jal ? (cur_inst_pc + 4) : alu_result;

wire [`Vec(`ImmWidth)]	rdata_1;
wire [`Vec(`ImmWidth)]	rdata_2;

  /* in execute state, read register, in WB state, write back registers */
RegisterFile 
#(
  .ADDR_WIDTH (`RegIdWidth),
  .DATA_WIDTH (`RegWidth)
)
u_RegisterFile(
  .clk     (clk     ),
  .reg_wdata   (reg_wdata   ),
  .rd      (rd      ),
  .reg_wen     (reg_wen     ),
  .rs1     (rs1 ),
  .rs2     (rs2 ),

  .rdata_1 (rdata_1 ),
  .rdata_2 (rdata_2 )
);

  /* input */
wire [`Vec(`ImmWidth)]  operator_1 = is_auipc ? current_pc: rdata_1;
// wire [`Vec(`ImmWidth)]  operator_1 = is_auipc ? cur_inst_pc : rdata_1;
wire [`Vec(`ImmWidth)]	operator_2 = need_imm ? imm : rdata_2;
  /* output */
wire [`Vec(`ImmWidth)]	alu_result;

Alu u_Alu(
	.operator_1 		( operator_1    ),
	.operator_2 		( operator_2 		),
	.alu_add    		( alu_add    		),

	.alu_result     ( alu_result     		)
);

/* rst should not used on an wire !*/
// two multiplexer
// assign next_pc = is_jal ? (current_pc + imm) : (current_pc + 4);
// assign next_pc = rst | is_jal ? `PcRst : next_pc;
// assign next_pc = is_jal ? `PcRst  : 0;

/* 在rst为0的一瞬间，next_pc为4了？ */
// assign next_pc = rst ? `PcRst : (is_jal ? (current_pc + imm) : (current_pc + 4));
// initial next_pc = `PcRst;
// wire [`Vec(`ImmWidth)] next_pc;
/* 初始化之后马上又被改了 */
// assign next_pc = (is_jal ? (cur_inst_pc + imm) : (current_pc + 4));
assign next_pc = is_jal ? (current_pc + imm) : (is_jalr ? alu_result : current_pc + 4);
// assign next_pc = (is_jal ? (current_pc + imm) : (next_pc + 4));

/* current instruction pc */
 Reg 
 #(
  .WIDTH     (`RegWidth),
  .RESET_VAL (`PcRst)
 )
 Pc_Reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (next_pc),
  .wen  (1'b1),

  .dout (current_pc)
 );

// wire [`Vec(`ImmWidth)] cur_inst_pc;
//  Reg 
//  #(
//   .WIDTH     (`RegWidth),
//   .RESET_VAL (0)
//  )
//  cur_inst_pc_reg(
//   .clk  (clk  ),
//   .rst  (rst  ),
//   .din  (current_pc),
//   .wen  (1'b1),
// 
//   .dout (cur_inst_pc)
//  );
endmodule
