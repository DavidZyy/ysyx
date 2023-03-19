`include "./include/defines.v"

module Alu (
    input [`ImmWidth-1:0] operator_1,
    input [`ImmWidth-1:0] operator_2,
    input alu_add,

    output [`ImmWidth-1:0] alu_result
);
    
    wire [`ImmWidth-1:0] add_result = operator_1 + operator_2;

    assign alu_result = ({`ImmWidth{alu_add}} & add_result);
endmodule //Alu
