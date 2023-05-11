// also use DPI-C machenism, may be use ip-core when vivado?

// NOTE !!, the read addr is aligned o 8 bit, do not forget this point.
`include "../include/defines.v"

module rom (
    input [`Vec(`RegWidth)] pc,

    output [`Vec(`InstWidth)] inst
);
    
    // localparam mask = 64'h7;

    // wire [`Vec(`RegWidth)] rinst;
    // assign inst = (pc & mask) == 0 ? rinst[`Vec(`InstWidth)] : rinst[63:32];

    /* We should read instructions immediately when pc changes. */
//     always @(*) begin
//       pmem_read(pc, rinst);
//     end
// 

    localparam addr_width = 11;
    // localparam addr_width = 21;
    localparam mem_size   = (2**addr_width); 

    reg [31:0] rom_mem[mem_size-1:0];
    
    /* reg应该是31:0，怀疑是readmemh的锅*/
    initial begin
    //   $readmemh("/home/zhuyangyang/project/ysyx-workbench/am-kernels/tests/cpu-tests/build/kb_test-riscv64-npc.rom.hex", rom_mem);
      $readmemh("/home/zhuyangyang/project/ysyx-workbench/am-kernels/tests/am-tests/build/amtest-riscv64-npc.rom.hex", rom_mem);
    end
    

    /* verilator lint_off UNUSEDSIGNAL */
    wire [`Vec(`RegWidth)] sub_pc   = pc - `PcRst;
    wire [`Vec(`RegWidth)] shift_pc = sub_pc >> 2;
    assign inst = rom_mem[shift_pc[addr_width-1:0]][31:0];
endmodule //rom
