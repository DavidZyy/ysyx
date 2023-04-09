/* code style: the name of variable use snake style, 
  the name of macro use camel style. */

import "DPI-C" function void exit_code();
import "DPI-C" function void not_ipl_exception();

`include "./include/defines.v"

/* assemble all cpu moudules into top moudule */
module cpu(
  input clk,
  input rst,

  output [`Vec(`ImmWidth)] pc_IF,
  output [`Vec(`ImmWidth)] next_pc,
  output [`Vec(`InstWidth)]	inst,
  output flush,

  output [`Vec(`ImmWidth)] IF_ID_pc
);


wire [`Vec(`AddrWidth)] waddr = alu_result;
wire [`Vec(`RegWidth)] mem_wdata = rdata_2;
wire [`Vec(`RegWidth)] mem_rdata;

/* IF, instructions fetch stage, rom. */
rom inst_rom (
  .pc (pc_IF),

  .inst (inst)
);


/* verilator lint_off UNUSEDSIGNAL */
wire [`Vec(`InstWidth)]	IF_ID_inst;
wire [`Vec(`InstWidth)]	din_inst; 

assign flush = (sig_op_ID[`SIG_OP_is_jal]  | 
                sig_op_ID[`SIG_OP_is_jalr] | 
                (sig_op_ID[`SIG_OP_is_branch] && (alu_result == 1))) ? 
                1 : 0;

assign din_inst = flush ? `NOP : inst;

/* registers between if and id stage */
IF_ID u_IF_ID (
  .clk (clk),
  .rst (rst),
  .pc_IF (pc_IF),
  .din_inst (din_inst),

  .IF_ID_pc (IF_ID_pc),
  .IF_ID_inst (IF_ID_inst)
);

/* decode instructionn stage */
wire [`Vec(`RegIdWidth)]	rd;
wire [`Vec(`RegIdWidth)]	rs1;
wire [`Vec(`RegIdWidth)]	rs2;
wire [`Vec(`ImmWidth)]	imm;

/* signals */
wire  [`Vec(`AluopWidth)] alu_op_ID;
wire  [`Vec(`WdtTypeCnt)] wdt_op_ID;
wire  [`Vec(`SigOpWidth)] sig_op_ID;

decoder u_decoder(
	//ports
	.inst     		    ( IF_ID_inst ),

	.rd       		    ( rd       		),
	.rs1      		    ( rs1      		),
	.rs2      		    ( rs2      		),
	.imm      		    ( imm      		),
  .alu_op_ID        ( alu_op_ID      ),
  .wdt_op_ID        ( wdt_op_ID),
  .sig_op_ID        ( sig_op_ID )

);

/* execute stage */
wire [`Vec(`ImmWidth)]	reg_wdata = (sig_op_ID[`SIG_OP_is_jal] | sig_op_ID[`SIG_OP_is_jalr]) ? 
                                    (IF_ID_pc + 4) : 
                                    (sig_op_ID[`SIG_OP_is_load] ? extended_data : alu_result);

wire [`Vec(`ImmWidth)]	rdata_1;
wire [`Vec(`ImmWidth)]	rdata_2;

  /* in execute state, read register, in WB state, write back registers */
RegisterFile 
#(
  .ADDR_WIDTH (`RegIdWidth),
  .DATA_WIDTH (`RegWidth)
)
u_RegisterFile(
  .clk        ( clk     ),
  .reg_wdata  ( reg_wdata   ),
  .rd         ( rd      ),
  .reg_wen    ( sig_op_ID[`SIG_OP_reg_wen]     ),
  .rs1        ( rs1 ),
  .rs2        ( rs2 ),

  .rdata_1    ( rdata_1 ),
  .rdata_2    ( rdata_2 )
);


/* ram */
memory u_memory (
	//ports
	.clk  		  ( clk  		),
  .mem_raddr  ( alu_result),
  .waddr      ( waddr ),
  .mem_wdata  ( mem_wdata),
  .mem_wen    ( sig_op_ID[`SIG_OP_mem_wen]),
  .mem_ren    ( sig_op_ID[`SIG_OP_is_load]),
  .wdt_op_ID     ( wdt_op_ID),

  .mem_rdata  ( mem_rdata)
);


wire [`Vec(`ImmWidth)] extended_data;

load_extend u_load_extend (
	//ports
	.mem_rdata 		    ( mem_rdata 		),
	.wdt_op_ID        		( wdt_op_ID        		),
	.is_unsigned   		( sig_op_ID[`SIG_OP_is_unsigned]   		),

	.extended_data 		( extended_data 		)
);



/*suppose one cycle is begin with the negtive cycle. 
  can not use negedge, because when in the edge of 
  neg, the pc and instructions update, but the update
  moment inst_not_ipl represent the old value, the
  new value of it is delayed. But in the posedge, 
  in the middle of the cycle, the inst_not_ipl signal
  is been updated. */
always @(posedge clk) begin
  if (sig_op_ID[`SIG_OP_inst_not_ipl]) begin
    not_ipl_exception();
    // $display("instructions not implemented!");
    ;
  end
  else begin
    ;
  end
end

always @(posedge clk) begin
  if (sig_op_ID[`SIG_OP_is_ebreak]) begin
    exit_code();
    // $display("exit code");
  end
  else begin
    ;
  end
end

// always @(*) begin
    // $display("pc: %x inst: %x", pc_IF, inst);
// end



  /* input */
wire [`Vec(`ImmWidth)]  operator_1 = (sig_op_ID[`SIG_OP_is_auipc] | sig_op_ID[`SIG_OP_is_jal]) ? 
                                      IF_ID_pc: rdata_1;

wire [`Vec(`ImmWidth)]	operator_2 = sig_op_ID[`SIG_OP_need_imm] ? 
                                      imm : rdata_2;
  /* output */
wire [`Vec(`ImmWidth)]	alu_result;

Alu u_Alu(
	.operator_1 		( operator_1    ),
	.operator_2 		( operator_2 		),
	.alu_op_ID    		  ( alu_op_ID    		),

	.alu_result     ( alu_result   	)
);


/* only jalr should clean the least-significant bit, but clean jal
  have no incluence, for code simplicity, we clean it as well. */
wire [`Vec(`ImmWidth)] next_pc_temp;
assign next_pc_temp = (sig_op_ID[`SIG_OP_is_branch] && (alu_result == 1)) ? 
                      (IF_ID_pc + imm) : (pc_IF + 4);

assign next_pc = (sig_op_ID[`SIG_OP_is_jal] | sig_op_ID[`SIG_OP_is_jalr]) ? 
                  (alu_result & ~1) : next_pc_temp;

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

  .dout (pc_IF)
 );


endmodule
