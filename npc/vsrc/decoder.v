/*
Input an instruction, to tell which instrction it is,
and ouput its relative components.
Which signals shoulld decoder to produce to pass to 
executor?
Add a new instructions is not convenient, I plan to write a 
script to generate verilog codes automaticallly when add new
instruction
*/
`include "./include/defines.v"

module decoder (
  input [`InstWidth-1:0] inst,
  // output inst_type,
  output [`RegIdWidth-1:0] rd,
  output [`RegIdWidth-1:0] rs1,
  output [`RegIdWidth-1:0] rs2,
  output [`ImmWidth-1:0] imm
);

  /* opcode */
  wire op_imm = (`OPCODE(inst) == `OP_IMM);
  wire op_system = (`OPCODE(inst) == `SYSTEM);
  
  /* funct3 */
  wire funct3_000 = (`FUNCT3(inst) == 3'b000);

  /* funct7, if it has more cases, use script to generate the codes below */


  /* funct12, use for system codes? */
  wire funct12_000000000001 = (`FUNCT12(inst) == 12'b000000000001);

  /* instructions */
  wire addi     = op_imm & funct3_000;
  wire ebreak   = op_system & funct3_000 & funct12_000000000001;
  

  /* instruction type, to be the key to choose immediate */
  wire I_type = op_imm;


  /* immediate */
  wire [`ImmWidth-1:0] I_imm = `immI(inst);


  assign imm = ({`ImmWidth{I_type}} & I_imm);
endmodule
