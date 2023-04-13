
`include "./include/defines.v"

module forwarding (
  input [`Vec(`RegIdWidth)]	rs1,
  input [`Vec(`RegIdWidth)]	rs2,
  input [`Vec(`RegIdWidth)] rd_EX,
  input [`Vec(`RegIdWidth)] rd_MEM,
  input [`Vec(`RegIdWidth)] rd_WB,

  output rdata_1_forward_ID_EX,
  output rdata_2_forward_ID_EX,
  output rdata_1_forward_ID_MEM,
  output rdata_2_forward_ID_MEM,
  output rdata_1_forward_ID_WB,
  output rdata_2_forward_ID_WB
);
    
    /* data in EX stage forwarding to ID */
    assign rdata_1_forward_ID_EX = (rs1 == rd_EX);
    assign rdata_2_forward_ID_EX = (rs2 == rd_EX);

    /* data in MEM stage forwarding to ID */
    assign rdata_1_forward_ID_MEM = (rs1 == rd_MEM);
    assign rdata_2_forward_ID_MEM = (rs2 == rd_MEM);

    /* data in WB stage forwarding to ID */
    assign rdata_1_forward_ID_WB = (rs1 == rd_WB);
    assign rdata_2_forward_ID_WB = (rs2 == rd_WB);
endmodule //forwarding
