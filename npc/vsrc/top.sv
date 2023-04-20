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
	input	clk,
	input	sysclk_n,
	input 	rst,

	output  SEGCLK,
    output  SEGCLR,
    /* DT = data ? */
    output  SEGDT,
    output  SEGEN,
	output [`Vec(`ImmWidth)] pc_WB
);

wire    clk200m;
/* verilator lint_off UNUSEDSIGNAL */
// wire	[`Vec(`ImmWidth)] pc_WB;

reg [31:0]  clkdiv;
always@(posedge clk200m)
    clkdiv<=clkdiv+1;

IBUFDS  inst_clk(
	.I(clk),
	.IB(sysclk_n),

	.O(clk200m)
);

// wire [`Vec(`InstWidth)]	inst;
cpu u_cpu(
	//ports
	.clk        		( clkdiv[27]		), // 200 0000 / (2^27)
	.rst        		( rstn        		),

  	// .inst           ( inst ),

	.pc_WB				( pc_WB				)
);

wire [31:0] num	=	pc_WB[31:0];
 
wire [7:0] dot;
assign  dot=8'b0;
wire [63:0] seg;

hex2seg inst_7seg7(num[31:28],dot[7],seg[63:56]);
hex2seg inst_7seg6(num[27:24],dot[6],seg[55:48]);
hex2seg inst_7seg5(num[23:20],dot[5],seg[47:40]);
hex2seg inst_7seg4(num[19:16],dot[4],seg[39:32]);

hex2seg inst_7seg3(num[15:12],dot[3],seg[31:24]);
hex2seg inst_7seg2(num[11:8],dot[2],seg[23:16]);
hex2seg inst_7seg1(num[7:4],dot[1],seg[15:8]);
hex2seg inst_7seg0(num[3:0],dot[0],seg[7:0]);

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
