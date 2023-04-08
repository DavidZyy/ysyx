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
    always @(*) begin
      pmem_read(pc, rinst);
    end


endmodule //rom
