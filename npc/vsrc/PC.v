`include "./include/defines.v"

module PC (
    input      clk,
    input      rst,
    // input [`RegWidth-1:0] JAddr,
    // input jar,
    // input bxx,
    
    output [`RegWidth-1:0] current_pc
);

/* a multiplexer to choose which is the next pc */
wire [`RegWidth-1:0] next_pc = current_pc + 4;

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
