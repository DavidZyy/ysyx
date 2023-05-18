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

//   wire 	ps2_clk;
// wire 	ps2_data;

ps2_keyboard_model #(
	.kbd_clk_period 		( 60 		))
u_ps2_keyboard_model(
	//ports
	.ps2_clk  		( PS2_clk     ),
	.ps2_data 		( PS2_Data    )
);


  initial begin
    swt = 0;
    // rst = 0;
    // #10;
    rst  = 1;
    #1000;
    rst = 0;
    #1000
    swt = 1;
    #1000
    swt = 2;
    #1000
    swt = 3;

    #1000
    u_ps2_keyboard_model.kbd_sendcode(8'h1C);
    #1000
    u_ps2_keyboard_model.kbd_sendcode(8'hF0); // break code
    #1000
    u_ps2_keyboard_model.kbd_sendcode(8'h1C); // release 'A'
    #100000000;
    $stop;
  end

endmodule //test
