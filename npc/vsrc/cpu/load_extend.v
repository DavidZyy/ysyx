`include "./include/defines.v"

module load_extend (
  input [`Vec(`ImmWidth)]   mem_rdata,
  input [`Vec(`WdtTypeCnt)] wdt_op,
  input is_unsigned,

  output [`Vec(`ImmWidth)] extended_data
);

  wire [`Vec(`ImmWidth)] signed_out;
  wire [`Vec(`ImmWidth)] unsigned_out;

  wire [7:0] slice_7_0   = mem_rdata[7:0];
  wire [15:0] slice_15_0 = mem_rdata[15:0];
  wire [31:0] slice_31_0 = mem_rdata[31:0];

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
    `Wdt64,  mem_rdata
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
    `Wdt64,  mem_rdata
    })
  );

  assign extended_data = is_unsigned ? unsigned_out : signed_out;
endmodule //load_extend
