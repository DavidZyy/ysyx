
`include "./include/defines.v"

module forwarding (
  input [`Vec(`RegIdWidth)]	rs1,
  input [`Vec(`RegIdWidth)]	rs2,
  input [`Vec(`RegIdWidth)] rd_EX,
  input [`Vec(`RegIdWidth)] rd_MEM,

  output rdata_1_forward_ID_EX,
  output rdata_2_forward_ID_EX,
  output rdata_1_forward_ID_MEM,
  output rdata_2_forward_ID_MEM
);
    
    /* data in EX stage forwarding to ID */
    assign rdata_1_forward_ID_EX = (rs1 == rd_EX);
    assign rdata_2_forward_ID_EX = (rs2 == rd_EX);

    /* data in MEM stage forwarding to ID */
    assign rdata_1_forward_ID_MEM = (rs1 == rd_MEM);
    assign rdata_2_forward_ID_MEM = (rs2 == rd_MEM);

endmodule //forwarding
