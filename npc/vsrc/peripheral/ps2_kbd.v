/*kb_clk 的频率应该大于rdn的频率，即cpu_clk的频率，这样才能有效有效采样，但是
    这样有可能一个cpu_clk中读出多个fifo中的data， */
module ps2_kbd (
    input   kb_clk,
    input   clrn,                   // clock and reset (active low)
    input   ps2_clk,
    input   ps2_data, 	         	// ps2 signals from keyboard
    input   rdn,               		// read signal from cpu, (cpu had read the kb, and send out the signal to clear ready)

    output  [7:0] data,        // keyboard code
    output  reg ready,         		// queue (fifo) state
    output  reg overflow
);

    // internal signal, for test
    reg [9:0] buffer;        // ps2_data bits
    reg [7:0] fifo[7:0];     // data fifo
    reg [2:0] w_ptr,r_ptr;   // fifo write and read pointers
    reg [3:0] count;  // count ps2_data bits
    // detect falling edge of ps2_clk
    reg [2:0] ps2_clk_sync;

    always @(posedge kb_clk) begin
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    // edge of ps2_clk detected
    wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];

    /* 因为键盘时钟频率大于cpu时钟频率，确保键盘每次取时，fifo中只有一个数据，在一个cpu周期中，
        只要键盘clk有，就会取一次。 */
    /* if kb_clk faster than cpu_clk, maybe in one inst cycle read more than one 
        kb codes. if kb_clk is cpu_clk, cpu_clk get new inst at negedge. */
    // always @(posedge kb_clk) begin
    always @(negedge kb_clk) begin
        if (clrn == 1) begin // reset (shit !! clrn is 0)
            count <= 0; w_ptr <= 0; r_ptr <= 0; overflow <= 0; ready<= 0;
        end
        else begin
            if ( ready ) begin // read to output next data
                // if(rdn == 1'b0) //read next data
                if(rdn == 1'b1) //read next data
                begin
                    r_ptr <= r_ptr + 3'b1;
                    if(w_ptr==(r_ptr+1'b1)) //empty
                        ready <= 1'b0;
                end
            end
            if (sampling) begin
              if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    fifo[w_ptr] <= buffer[8:1];  // kbd scan code
                    w_ptr <= w_ptr+3'b1;
                    ready <= 1'b1;
                    overflow <= overflow | (r_ptr == (w_ptr + 3'b1));
                end
                count <= 0;     // for next
              end else begin
                buffer[count] <= ps2_data;  // store ps2_data
                count <= count + 3'b1;
              end
            end
        end
    end
    assign data = fifo[r_ptr]; //always set output data

endmodule
