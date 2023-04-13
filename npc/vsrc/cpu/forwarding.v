
`include "./include/defines.v"

module forwarding (
  input [`Vec(`RegIdWidth)]	rs1,
  input [`Vec(`RegIdWidth)]	rs2,
  input [`Vec(`RegIdWidth)] rd_EX,
  input [`Vec(`RegIdWidth)] rd_MEM,

  output rdata_1_forward_EX,
  output rdata_2_forward_EX,
  output rdata_1_forward_MEM,
  output rdata_2_forward_MEM,
);
    
    assign rdata_1_forward_EX = (rs1 == rd_EX);
    assign rdata_2_forward_EX = (rs2 == rd_EX);

endmodule //forwarding
