/* verilator lint_off TIMESCALEMOD */
`timescale 1us/1ns

module test ();

reg clk;
reg sysclk_n;
reg rst;
reg [7:0] swt;

wire  [7:0]	leds;
wire 	SEGCLK;
wire 	SEGCLR;
wire 	SEGDT;
wire 	SEGEN;

top u_top(
	//ports
	.clk      		( clk      		),
	.sysclk_n 		( sysclk_n 		),
	.rst      		( rst      		),
	.PS2_clk  		( PS2_clk  		),
	.PS2_Data 		( PS2_Data 		),
	.swt      		( swt      		),

	.leds     		( leds     		),
	.SEGCLK   		( SEGCLK   		),
	.SEGCLR   		( SEGCLR   		),
	.SEGDT    		( SEGDT    		),
	.SEGEN    		( SEGEN    		)
);


  initial begin
    clk          =   0;
    forever #1 clk = ~clk;
  end

  initial begin
    sysclk_n     =   1;
    forever #1 sysclk_n = ~sysclk_n;
  end

  initial begin
    swt = 0;
    // rst = 0;
    // #10;
    rst  = 1;
    #100;
    rst = 0;
    #100
    swt = 1;
    #100
    swt = 2;
    #100
    swt = 3;
    #100000000;
    $stop;
  end

endmodule //test
