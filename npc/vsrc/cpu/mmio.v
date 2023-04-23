
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

    output [`Vec(`ImmWidth)]  mem_rdata
);

    wire [`Vec(`ImmWidth)]  ram_rdata;
    wire [`Vec(`ImmWidth)]  kb_rdata;   // read data from keyboard

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

    always @(posedge clk) begin
        if(mem_raddr >= `ADDR_RAM && mem_raddr < `ADDR_RAM + `RAM_LEN) begin
            mem_rdata <= ram_rdata;
        end
        else if (mem_raddr >= `ADDR_KB && mem_raddr < `ADDR_KB + `PERI_LEN) begin
            mem_rdata <= kb_rdata;
        end
        else
            $display("read address error!");
    end

/************************* write data *********************/

endmodule
