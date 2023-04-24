
`include "../include/defines.v"

module mmio (
    input clk,
    input [`Vec(`RegWidth)]  mem_raddr,
    input [`Vec(`AddrWidth)] mem_waddr,
    /* verilator lint_off UNUSEDSIGNAL */
    input [`Vec(`RegWidth)]  mem_wdata,
    input mem_wen,
    input mem_ren,
    input [`Vec(`WdtTypeCnt)] wdt_op,
    input [`Vec(`KbWidth)]  kb_data,   // read data from keyboard
    input kb_ready,

    output reg [`Vec(`ImmWidth)]  mem_rdata,
    output sig_rd_kb,
    output [`Vec(`SegWidth)]  seg_wdata
);

    wire [`Vec(`ImmWidth)]  ram_rdata;
    // wire [`Vec(`ImmWidth)]  kb_data;   // read data from keyboard

    ram u_ram (
      //ports
      .clk  	  ( clk      ),
      .mem_raddr  ( mem_raddr),
      .mem_waddr  ( mem_waddr),
      .mem_wdata  ( mem_wdata),
      .mem_wen    ( mem_wen     ),
      .mem_ren    ( mem_ren  ),
      .wdt_op     ( wdt_op   ),

      .mem_rdata  ( ram_rdata)
    );


/************************* read data *********************/

    // always @(posedge clk) begin
    /* or ram use  always @(*) and here use always @(posedge clk) */
    always @(*) begin
        mem_rdata   =  0;
        sig_rd_kb   =  0;
        if(mem_ren) begin
            // if(mem_raddr >= `ADDR_RAM && mem_raddr < `ADDR_RAM + `RAM_LEN) begin
            if (`InMem(mem_raddr, `ADDR_RAM, `RAM_LEN)) begin
                mem_rdata = ram_rdata;
            end
            // else if (mem_raddr >= `ADDR_KB && mem_raddr < `ADDR_KB + `PERI_LEN) begin
            else if (`InMem(mem_raddr, `ADDR_KB, `PERI_LEN)) begin
                if(kb_ready) begin
                    sig_rd_kb   =  1;
                    mem_rdata =    `ZEXT(kb_data, `KbWidth);
                end
                else
                    mem_rdata  =   mem_rdata;
            end
            else
                mem_rdata  =   mem_rdata;
                // $display("read address error!");
        end
        // else
            // mem_rdata  =   mem_rdata;
    end

/************************* write data *********************/

    wire [`Vec(`SegWidth)]  num;

    always @(negedge clk) begin
        if(mem_wen) begin
            if(`InMem(mem_waddr, `ADDR_SEG, `PERI_LEN)) begin
                seg_wdata = mem_wdata[31:0];            
            end
        end
    end

endmodule
