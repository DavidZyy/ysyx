// soc(system on chip)
module top(
  input clk,
  input rst,

  output [`Vec(`ImmWidth)] pc_IF,
  output [`Vec(`ImmWidth)] next_pc,
  output [7:0]	seg0,
  output [7:0]	seg1,
  output [7:0]	seg2,
  output [7:0]	seg3,
  output [7:0]	seg4,
  output [7:0]	seg5,
  output [7:0]	seg6,
  output [7:0]	seg7,
	// output flush_ID,
	output flush_WB,
	// output flush,
  output [`Vec(`ImmWidth)] pc_WB
);

// wire [`Vec(`ImmWidth)]	pc_IF;
// wire [`Vec(`ImmWidth)]	next_pc;
wire [`Vec(`InstWidth)]	inst;

cpu u_cpu(
	//ports
	.clk        		( clk        		),
	.rst        		( rst        		),

	.pc_IF 					( pc_IF 		),
	.next_pc    		( next_pc    		),
  .inst           ( inst ),
	// .flush_ID					(flush_ID),
	.flush_WB				( flush_WB),
	// .flush	(flush),
	.pc_WB					( pc_WB)
);

// wire [7:0]	seg0;
// wire [7:0]	seg1;

// seg u_seg(
// 	//ports
// 	.display_data 		( pc_IF[31:0] 		),
// 
// 	.seg0         		( seg0         		),
// 	.seg1         		( seg1         		)
// );
seg u_seg(
	//ports
	// .display_data 		( pc_IF[31:0]),
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
