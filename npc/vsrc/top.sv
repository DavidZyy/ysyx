// soc(system on chip)

`include "./include/defines.v"

module top	(
        input	clk,
        input	sysclk_n,
        /* verilator lint_off SYNCASYNCNET */
        input 	rst,
		/* verilator lint_off UNUSEDSIGNAL */
        // input	btn_clk,
        input   PS2_clk,
        input   PS2_Data,
        input   [`Vec(8)]   swt,

        // // output  [`Vec(`ImmWidth)] pc_WB,
        // // output  [`Vec(`ImmWidth)] pc_IF,
        // // output  flush_WB,
        output	[7:0] leds,
        output  SEGCLK,
        output  SEGCLR,
        output  SEGDT,
        output  SEGEN
    );

    /* verilator lint_off UNUSEDSIGNAL */
    // wire [`Vec(`ImmWidth)] pc_WB;
    // wire [`Vec(`ImmWidth)] pc_IF;
    // wire flush_WB;
    wire [`Vec(`InstWidth)]	inst;

    wire    clk200m;
    reg [`Vec(`ClkDivWidth)]  clkdiv;

    IBUFDS  inst_clk(
                .I(clk),
                .IB(sysclk_n),

                .O(clk200m)
            );

    // always@(posedge clk200m)
    //     clkdiv <= clkdiv+1;

    /* seg no display, to see rst signal */
    always@(posedge clk200m or posedge rst)
    	if(rst) begin
    		clkdiv <= 0;
    	end
    	else begin
        	clkdiv <= clkdiv+1;
    	end

    wire  sig_rd_kb;
    wire [`Vec(`SegWidth)]  seg_wdata;

    wire [`Vec(`KbWidth)]	kb_rdata;
    wire 		kb_ready;
    wire overflow;

    wire [`Vec(`LedWidth)]	led_wdata;

    wire [`Vec(8)]	swt_rdata;
    cpu u_cpu (
            //ports
            // .clk        		( clkdiv[0]		), // 200 0000 / (2^27)
            .clk        		( clk200m			), /* for simulation on varilator */
            /* 10 can run on sword */
            // .clk        		( clkdiv[10]		),
            // .clk        		( btn_clk			),
            /* use switch as reset? */
            .rst        		( rst        		),
            .kb_rdata     		( kb_rdata     		),
            .kb_ready    		( kb_ready    		),
            .swt_rdata          ( swt_rdata         ),

            .inst           	( inst 				),
            .pc_IF				( pc_IF				),
            .flush_WB			( flush_WB			),
            .pc_WB				( pc_WB				),
            .sig_rd_kb			( sig_rd_kb			),
            .seg_wdata			( seg_wdata			),
            .led_wdata          ( led_wdata         )
        );

    // always@(posedge clk200m) begin
    // 	$display("%x", pc_WB);
    // end

//     assign leds[7] = btn_clk;
//     /* rst always true */
//     assign leds[6] = rst;
//     assign leds[5] = flush_WB;
//     assign leds[4] = clk200m;
// 
//     assign leds[3:0] = pc_IF[3:0];

	// assign leds [7:0] = seg_wdata[7:0];

    swt u_swt (
    	//ports
    	.swt       		( swt       		),

    	.swt_rdata 		( swt_rdata 		)
    );

    led u_led (
    	//ports
    	.led_wdata 		( led_wdata 		),
    	// .led_wdata 		( seg_wdata[7:0] ),

    	.led_out   		( leds           )
    );

    wire [`Vec(`ImmWidth)]  led_ext = `ZEXT(led_wdata, 8);

    // seg_wdata shift left to display the signal

    seg u_seg (
            //ports
            .clkdiv   		( clkdiv   		),
            .num    		( seg_wdata		),
            // .num    		( led_ext[31:0]		),
            // .num    		( inst ),

            .s_clk  		( SEGCLK		),
            .s_clrn 		( SEGCLR		),
            .sout   		( SEGDT			),
            .EN     		( SEGEN		)
        );

    ps2_kbd u_ps2_kbd (
                //ports
                /* clk200m may be too quickly? */
                // .clk      		( clkdiv[10] 	),
                .clk      		( clkdiv[0]     ),
                .clrn     		( rst			),
                .ps2_clk  		( PS2_clk  		),
                .ps2_data 		( PS2_Data 		),
                .rdn      		( sig_rd_kb     ),

                .data     		( kb_rdata     	),
                .ready    		( kb_ready    	),
                .overflow       ( overflow      )
            );

endmodule //top
