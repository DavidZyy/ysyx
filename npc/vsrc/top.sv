// soc(system on chip)
module top(
//   input clk,
//   input rst,
// 
//   output [`Vec(`ImmWidth)] pc_IF,
//   output [`Vec(`ImmWidth)] next_pc,
//   output [7:0]	seg0,
//   output [7:0]	seg1,
//   output [7:0]	seg2,
//   output [7:0]	seg3,
//   output [7:0]	seg4,
//   output [7:0]	seg5,
//   output [7:0]	seg6,
//   output [7:0]	seg7,
//   output flush_WB,
//   output [`Vec(`ImmWidth)] pc_WB
	input	sysclk_p,
	input	sysclk_n,
	input 	rstn,

	output  SEGCLK,
    output  SEGCLR,
    /* DT = data ? */
    output  SEGDT,
    output  SEGEN
);

wire    clk200m;
wire	[`Vec(`ImmWidth)] pc_WB;

reg [19:0]  clkdiv;
always@(posedge clk200m)
    clkdiv<=clkdiv+1;

IBUFDS  inst_clk(
	.I(sysclk_p),
	.IB(sysclk_n),

	.O(clk200m)
);

// wire [`Vec(`InstWidth)]	inst;
// 
cpu u_cpu(
	//ports
	.clk        		( clkdiv[1]			),
	.rst        		( rstn        		),

	// .pc_IF 					( pc_IF 		),
	// .next_pc    		( next_pc    		),
  	// .inst           ( inst ),
	// // .flush_ID					(flush_ID),
	// .flush_WB				( flush_WB),
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

wire [7:0]	seg0;
wire [7:0]	seg1;
wire [7:0]	seg2;
wire [7:0]	seg3;
wire [7:0]	seg4;
wire [7:0]	seg5;
wire [7:0]	seg6;
wire [7:0]	seg7;

wire [63:0]	seg = {seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7 };

seg u_seg(
	//ports
	.display_data 		( pc_WB[31:0]		),

	.seg0         		( seg0         		),
	.seg1         		( seg1         		),
	.seg2         		( seg2         		),
	.seg3         		( seg3         		),
	.seg4         		( seg4         		),
	.seg5         		( seg5         		),
	.seg6         		( seg6         		),
	.seg7         		( seg7         		)
);

SEG7P2S #(
	.DATA_BITS(64),//data length
	.DATA_COUNT_BITS(6),//data shift bits
	.DIR(0)//Shift direction
)
inst_7seg(
	.clk(clkdiv[1]),//parallel to serial
	.rst(1'b0),
	.Start(clkdiv[16]),
	.PData(seg),

	.s_clk(SEGCLK),
	.s_clrn(SEGCLR),
	.sout(SEGDT),
	.EN(SEGEN)
);

endmodule //top
