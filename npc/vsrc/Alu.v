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
        .NR_KEY     (15),
        .KEY_LEN    (`AluopWidth),
        .DATA_LEN   (`ImmWidth)
    )
    alu_mux(
        .out(alu_result),
        .key(alu_op),
        .lut({
        `AluAdd,    operator_1 + operator_2,
        `AluSub,    operator_1 - operator_2,
        `AluLt,     `ZEXT($signed(operator_1) < $signed(operator_2), 1),
        `AluLtu,    `ZEXT($unsigned(operator_1) < $unsigned(operator_2), 1),
        `AluAnd,    operator_1 & operator_2,
        `AluOr,     operator_1 | operator_2,
        `AluXor,    operator_1 ^ operator_2,
        `AluSll,    operator_1 << operator_2[`Vec(`ShtWdt)],
        `AluSrl,    operator_1 >> operator_2[`Vec(`ShtWdt)],
        `AluSra,    operator_1 >>> operator_2[`Vec(`ShtWdt)],
        `AluOutImm, operator_2,
        `AluEq,     `ZEXT(operator_1 == operator_2, 1),
        `AluNe,     `ZEXT(operator_1 != operator_2, 1),
        `AluGe,     `ZEXT($signed(operator_1) >= $signed(operator_2), 1),
        `AluGeu,    `ZEXT($unsigned(operator_1) >= $unsigned(operator_2), 1)
        })
        );
endmodule //Alu
