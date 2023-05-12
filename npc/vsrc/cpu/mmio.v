
`include "../include/defines.v"

module mmio (
    input clk,
    input [`Vec(`RegWidth)]     mem_raddr,
    input [`Vec(`AddrWidth)]    mem_waddr,
    /* verilator lint_off UNUSEDSIGNAL */
    input [`Vec(`RegWidth)]     mem_wdata,
    input mem_wen,
    input mem_ren,
    input [`Vec(`WdtTypeCnt)]   wdt_op,
    input [`Vec(`KbWidth)]      kb_rdata,   // read data from keyboard
    input kb_ready,
    input [`Vec(8)]             swt_rdata,
    input [`Vec(`ClkDivWidth)]  clkdiv,

    output reg [`Vec(`ImmWidth)]  mem_rdata,
    output reg sig_rd_kb,
    output reg [`Vec(`SegWidth)]  seg_wdata,
    output reg [`Vec(`LedWidth)]  led_wdata
);

    wire [`Vec(`ImmWidth)]  ram_rdata;
    // reg  [`Vec(`ImmWidth)]  ram_wdata;
    // wire [`Vec(`ImmWidth)]  kb_rdata;   // read data from keyboard

    ram u_ram (
      //ports
      .clk  	  ( clk      ),
      .mem_raddr  ( mem_raddr),
      .mem_waddr  ( mem_waddr),
    //   .mem_wdata  ( ram_wdata),
      .mem_wdata  ( mem_wdata),
      .mem_wen    ( mem_wen  ),
      .mem_ren    ( mem_ren  ),
      .wdt_op     ( wdt_op   ),

      .mem_rdata  ( ram_rdata)
    );


/************************* read data *********************/

    // always @(posedge clk) begin
    /* or ram use  always @(*) and here use always @(posedge clk) */
    always @(*) begin
        /* in test c , if(read_data != 0) write_seg */
        mem_rdata   =  64'h0;
        sig_rd_kb   =  0;
                $display("clkdiv: %x", clkdiv);
        if(mem_ren) begin
            // if(mem_raddr >= `ADDR_RAM && mem_raddr < `ADDR_RAM + `RAM_LEN) begin
            if (`InMem(mem_raddr, `ADDR_RAM, `RAM_LEN)) begin
                mem_rdata = ram_rdata;
            end
            // else if (mem_raddr >= `ADDR_KB && mem_raddr < `ADDR_KB + `PERI_LEN) begin
            else if (`InMem(mem_raddr, `KBD_ADDR, `KBD_LEN)) begin
                if(kb_ready) begin
                    sig_rd_kb   =  1;
                    mem_rdata =    `ZEXT(kb_rdata, `KbWidth);
                end
                else
                    mem_rdata  =   mem_rdata;
            end
            else if (`InMem(mem_raddr, `SWT_ADDR, `PERI_LEN)) begin
                mem_rdata =    `ZEXT(swt_rdata, 8);
            end
            else if (`InMem(mem_raddr, `RTC_ADDR, `RTC_LEN)) begin
                mem_rdata = clkdiv;
                // print_clkdiv(clkdiv);
                $display("clkdiv: %x", clkdiv);
            end
            // report out of boundary error
            else begin
                mem_rdata  =   mem_rdata;
                $display("read address out of boundary: %x", mem_raddr);
            end
        end
        else
            mem_rdata  =   mem_rdata;
    end

/************************* write data *********************/

    wire [`Vec(`SegWidth)]  num;

    always @(negedge clk) begin
        if(mem_wen) begin
            if (`InMem(mem_waddr, `SEG_ADDR, `PERI_LEN)) begin
                seg_wdata <= mem_wdata[31:0];
            end
            else if (`InMem(mem_waddr, `LED_ADDR, `PERI_LEN)) begin
                led_wdata   <=  mem_wdata[`Vec(`LedWidth)];
            end
            /* because ram is write at negedge, so here should not write at negedge */
            else if (`InMem(mem_waddr, `ADDR_RAM, `RAM_LEN)) begin
                // ram_wdata <= mem_wdata;
                ;
            end
            else begin
                $display("write address out of boundary: %x", mem_waddr);
            end
        end
    end

endmodule
