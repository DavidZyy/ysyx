/* verilator lint_off TIMESCALEMOD */
// `timescale 1us/1ns

module test (
);

reg clk, sysclk_n, rst;
	// reg SEGCLK;
    // reg SEGCLR;
    // reg SEGDT;
    // reg SEGEN;

wire 	SEGCLK;
wire 	SEGCLR;
wire 	SEGDT;
wire 	SEGEN;

top u_top(
	//ports
	.clk      		( clk      		),
	.sysclk_n 		( sysclk_n 		),
	.rst      		( rst      		),

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
    // rst = 0;
    // #10;
    rst  = 1;
    #100;
    rst = 0;
    #100000000;
    $stop;
  end

endmodule //test
