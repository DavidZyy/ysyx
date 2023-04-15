// also use DPI-C machenism, may be use ip-core when vivado?

// NOTE !!, the read addr is aligned o 8 bit, do not forget this point.
`include "./include/defines.v"

module rom (
    input [`Vec(`RegWidth)] pc,

    output [`Vec(`InstWidth)] inst
);
    
    localparam mask = 64'h7;

    wire [`Vec(`RegWidth)] rinst;
    assign inst = (pc & mask) == 0 ? rinst[`Vec(`InstWidth)] : rinst[63:32];


    /* We should read instructions immediately when pc changes. */
    // always @(*) begin
      // pmem_read(pc, rinst);
    // end


    reg [63:0] rom_mem[8192-1:0]; 
    
    initial begin
      $readmemh("/home/zhuyangyang/project/ysyx-workbench/npc/vsrc/cpu/hello.hex", rom_mem);
    end
    

    /* verilator lint_off UNUSEDSIGNAL */
    wire [`Vec(`RegWidth)] shift_pc = pc >> 3;
    assign rinst = rom_mem[shift_pc[12:0]][63:0];
endmodule //rom
