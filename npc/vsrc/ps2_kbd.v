/*
    This implementation has no fifo queue, if a data is assigned and not
    used by cpu, it will be covered by the next data. We can use an fifo 
    queue version later.
*/
module ps2_kbd(
    input   clk,
    input   clrn,                   // clock and reset (active low)
    input   ps2_clk,
    input   ps2_data, 	         	// ps2 signals from keyboard
    input   rdn,               		// read signal from cpu, (cpu had read the kb, and send out the signal to clear ready)

    output  reg [7:0] data,        // keyboard code
    output  reg ready         		// queue (fifo) state
);

reg [3:0] count;          							// count ps2_data bits
reg [9:0] buffer;         							// ps2_data bits

reg [2:0] ps2_clk_sync;   							// for detecting the falling-edge of a frame
// reg [1:0] clk_sample;
 
always @ (posedge clk)
begin 					  			// this is a common method to
    ps2_clk_sync <= {ps2_clk_sync[1:0],ps2_clk};    	// detect
end                                                 	// falling-edge

wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1]; 	// (start bit)

always @ (posedge clk) begin
    if (clrn == 0) begin
        count  <= 0;
        ready  <= 0;
    end
    else begin
        if (rdn && ready)   // cpu had read the data
            ready <= 0;
        else
            ready <= ready ;     	// when cpu reads
        if (sampling) begin
            if (count == 4'd10)// for one frame
            begin
                if ((buffer[0] == 0) &&          	// start bit
                    (ps2_data)       &&          	// stop bit 
                    ({^buffer[9:1]}))
                begin        						// odd prity
                    data<=buffer[8:1];
                    ready<=1;
                end
                count <= 0;                     	// for next
            end
            else
            begin                       	    	// within one frame
                buffer[count] <= ps2_data;       	// store ps2_data
                count <= count + 3'b1;           	// count ps2_data bits
            end
        end
    end
end

//#PS2 Key
//set_property -dict {PACKAGE_PIN M19  IOSTANDARD LVCMOS33 PULLUP true} [get_ports PS2_Data]
//set_property -dict {PACKAGE_PIN N18  IOSTANDARD LVCMOS33 PULLUP true} [get_ports PS2_clk]

endmodule
