import "DPI-C" function void exit_code();
import "DPI-C" function void not_ipl_exception();

`include "./include/defines.v"

/* assemble all cpu moudules into top moudule */
module top(
  input clk,
  input rst,
  input [`Vec(`InstWidth)] inst,

  output [`Vec(`ImmWidth)] pc
);


/* decode instructionn stage */
wire [`Vec(`RegIdWidth)]	rd;
wire [`Vec(`RegIdWidth)]	rs1;
wire [`Vec(`RegIdWidth)]	rs2;
wire [`Vec(`ImmWidth)]	imm;
wire 	need_imm;
wire 	alu_add;
wire  is_ebreak;
wire  inst_not_ipl;

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
  .inst_not_ipl ( inst_not_ipl)
);

always @(*) begin
  if (inst_not_ipl) begin
    not_ipl_exception();
  end
  else begin
    ;
  end
end


/* execute stage */
  
wire [`Vec(`ImmWidth)]	wdata = result;
wire wen = 1'b1;

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
  .wdata   (wdata   ),
  .rd      (rd      ),
  .wen     (wen     ),
  .rs1     (rs1 ),
  .rs2     (rs2 ),

  .rdata_1 (rdata_1 ),
  .rdata_2 (rdata_2 )
);

  /* input */
wire [`Vec(`ImmWidth)]	operator_2 = need_imm ? imm : rdata_2;
  /* output */
wire [`Vec(`ImmWidth)]	result;

Alu u_Alu(
	//ports
	.operator_1 		( rdata_1),
	.operator_2 		( operator_2 		),
	.alu_add    		( alu_add    		),

	.result     		( result     		)
);

always @(*) begin
  if (is_ebreak) begin
    exit_code();
  end
  else begin
    ;
  end
end

PC u_PC(
	//ports
	.clk        		( clk        		),
	.rst        		( rst        		),

	.current_pc 		( pc )
);


endmodule
