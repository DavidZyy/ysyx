// soc(system on chip)
module top(
  input clk,
  input rst,

  output [`Vec(`ImmWidth)] current_pc,
  output [`Vec(`ImmWidth)] next_pc,
  output [7:0]	seg0,
  output [7:0]	seg1,
  output [7:0]	seg2,
  output [7:0]	seg3,
  output [7:0]	seg4,
  output [7:0]	seg5,
  output [7:0]	seg6,
  output [7:0]	seg7,
	output flush,
  output [`Vec(`ImmWidth)] IF_ID_pc
);

// wire [`Vec(`ImmWidth)]	current_pc;
// wire [`Vec(`ImmWidth)]	next_pc;
wire [`Vec(`InstWidth)]	inst;

cpu u_cpu(
	//ports
	.clk        		( clk        		),
	.rst        		( rst        		),

	.current_pc 		( current_pc 		),
	.next_pc    		( next_pc    		),
  .inst           (inst ),
	.flush					(flush),
	.IF_ID_pc	(IF_ID_pc)
);

// wire [7:0]	seg0;
// wire [7:0]	seg1;

// seg u_seg(
// 	//ports
// 	.display_data 		( current_pc[31:0] 		),
// 
// 	.seg0         		( seg0         		),
// 	.seg1         		( seg1         		)
// );
seg u_seg(
	//ports
	// .display_data 		( current_pc[31:0]),
	.display_data 		( inst ),

	.seg0         		( seg0         		),
	.seg1         		( seg1         		),
	.seg2         		( seg2         		),
	.seg3         		( seg3         		),
	.seg4         		( seg4         		),
	.seg5         		( seg5         		),
	.seg6         		( seg6         		),
	.seg7         		( seg7         		)
);


endmodule //top
