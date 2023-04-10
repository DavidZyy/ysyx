
`include "./include/defines.v"

module forwarding (
  input [`Vec(`RegIdWidth)]	rs1,
  input [`Vec(`RegIdWidth)]	rs2,
  input [`Vec(`RegIdWidth)] rd_EX,

  output rdata_1_forward,
  output rdata_2_forward
);
    
    assign rdata_1_forward = (rs1 == rd_EX);
    assign rdata_2_forward = (rs2 == rd_EX);

endmodule //forwarding
