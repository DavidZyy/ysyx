`include "./include/defines.v"

module load_extend (
  input [`Vec(`ImmWidth)]   mem_rdata,
  input [`Vec(`WdtTypeCnt)] wdt_op,
  input is_unsigned,

  output [`Vec(`ImmWidth)] extended_data
);

  wire [`Vec(`ImmWidth)] signed_out;
  wire [`Vec(`ImmWidth)] unsigned_out;

  wire slice_7_0  = load_mem_data[7:0];
  wire slice_15_0 = load_mem_data[15:0];
  wire slice_31_0 = load_mem_data[31:0];

  MuxKey
  #(
    .NR_KEY   (4),
    .KEY_LEN  (`WdtTypeCnt),
    .DATA_LEN (`ImmWidth)
  )
  signed_mux(
    .out(signed_out),
    .key(wdt_op),
    .lut({
    `Wdt8,   `SEXT(slice_7_0, 8),
    `Wdt16,  `SEXT(slice_15_0, 16),
    `Wdt32,  `SEXT(slice_31_0, 32),
    `Wdt64,  load_mem_data
    })
  );

  MuxKey
  #(
    .NR_KEY   (4),
    .KEY_LEN  (`WdtTypeCnt),
    .DATA_LEN (`ImmWidth)
  )
  unsigned_mux(
    .out(unsigned_out),
    .key(wdt_op),
    .lut({
    `Wdt8,   `ZEXT(slice_7_0, 8),
    `Wdt16,  `ZEXT(slice_15_0, 16),
    `Wdt32,  `ZEXT(slice_31_0, 32),
    `Wdt64,  load_mem_data
    })
  );

  assign extended_data = is_unsigned ? unsigned_out : signed_out;
endmodule //load_extend
