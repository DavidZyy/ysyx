`include "./include/defines.v"

module Alu (
    input [`Vec(`ImmWidth)] operator_1,
    input [`Vec(`ImmWidth)] operator_2,
    // input alu_add,
    input [`Vec(`AluopWidth)] alu_op,

    output [`Vec(`ImmWidth)] alu_result
);
    
    // wire [`Vec(`IWmm)] add_result = operator_1 + operator_2;

    // assign alu_result = ({`ImmWidth{alu_add}} & add_result);

    /* use a multiplexer */
    MuxKey
    #(
        .NR_KEY     (2),
        .KEY_LEN    (`AluopWidth),
        .DATA_LEN   (`ImmWidth)
    )
    alu_mux(
        .out(alu_result),
        .key(alu_op),
        .lut({
        `AluAdd, operator_1 + operator_2,
        `AluSub, operator_1 - operator_2
        })
        );
endmodule //Alu
