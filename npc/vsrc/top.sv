import "DPI-C" function void exit_code();
`include "./include/defines.v"

/* assemble all cpu moudules into top moudule */
module top(
  input clk,
  input rst,
  input [`InstWidth-1:0] inst,

  output [`ImmWidth-1:0] pc
);


/* decode instructionn stage */
wire [`RegIdWidth-1:0]	rd;
wire [`RegIdWidth-1:0]	rs1;
wire [`RegIdWidth-1:0]	rs2;
wire [`ImmWidth-1:0]	imm;
wire 	need_imm;
wire 	alu_add;
wire  is_ebreak;

decoder u_decoder(
	//ports
	.inst     		( inst     		),

	.rd       		( rd       		),
	.rs1      		( rs1      		),
	.rs2      		( rs2      		),
	.imm      		( imm      		),
	.need_imm 		( need_imm 		),
	.alu_add  		( alu_add  		),
  .is_ebreak    ( is_ebreak   )
);

/* execute stage */
  
wire [`ImmWidth-1:0]	wdata = result;
wire wen = 1'b1;

wire [`ImmWidth-1:0]	rdata_1;
wire [`ImmWidth-1:0]	rdata_2;

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
wire [`ImmWidth-1:0]	operator_2 = need_imm ? imm : rdata_2;
  /* output */
wire [`ImmWidth-1:0]	result;

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
