`include "./include/defines.v"

/* assemble all cpu moudules into top moudule */
module top(
  input clk,
  input rst,
  input [`InstWidth-1:0] inst,

  output [`ImmWidth-1:0] pc
);

// wire [`RegIdWidth-1:0]	rd;
// wire [`RegIdWidth-1:0]	rs1;
// wire [`RegIdWidth-1:0]	rs2;
// wire [`ImmWidth-1:0]	imm;
// 
// decoder u_decoder(
// 	//ports
// 	.inst 		( inst 		),
// 
// 	.rd   		( rd   		),
// 	.rs1  		( rs1  		),
// 	.rs2  		( rs2  		),
// 	.imm  		( imm  		)
// );




endmodule
