`include "./include/defines.v"

module PC (
    input      clk,
    input      rst,
    // input [`Vec(`RegWidth)] JAddr,
    // input jar,
    // input bxx,
    
    output [`Vec(`RegWidth)] current_pc
    output [`Vec(`RegWidth)] next_pc
);

/* a multiplexer to choose which is the next pc */
wire [`Vec(`RegWidth)] next_pc_temp1 = current_pc + 4;

wire [`Vec(`RegWidth)] next_pc = rst ? `PcRst :  next_pc_temp1;

 Reg 
 #(
  .WIDTH     (`RegWidth),
  .RESET_VAL (`PcRst)
 )
 Pc_Reg(
  .clk  (clk  ),
  .rst  (rst  ),
  .din  (next_pc),
  .wen  (1'b1),

  .dout (current_pc)
 );


      
endmodule //pc
