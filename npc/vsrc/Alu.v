`include "./include/defines.v"

module Alu (
    input [`Vec(`ImmWidth)] operator_1,
    input [`Vec(`ImmWidth)] operator_2,
    input [`Vec(`AluopWidth)] alu_op,

    output [`Vec(`ImmWidth)] alu_result
);
    
    /* verilator lint_off UNUSEDSIGNAL */
    wire[`Vec(`ImmWidth)] temp_0, temp_1, temp_2, temp_3, temp_4;
    wire [`Vec(`WordWidth)] temp_0_slice, temp_1_slice, temp_2_slice, temp_3_slice, temp_4_slice;

    assign temp_0 = (operator_1 + operator_2);
    assign temp_1 = (operator_1 <<  operator_2[`Vec(`ShtWdtW)]);
    assign temp_2 = (operator_1 >>  operator_2[`Vec(`ShtWdtW)]);
    assign temp_3 = (operator_1 >>> operator_2[`Vec(`ShtWdtW)]);
    assign temp_4 = (operator_1 - operator_2);

    assign temp_0_slice = temp_0[`Vec(`WordWidth)];
    assign temp_1_slice = temp_1[`Vec(`WordWidth)];
    assign temp_2_slice = temp_2[`Vec(`WordWidth)];
    assign temp_3_slice = temp_3[`Vec(`WordWidth)];
    assign temp_4_slice = temp_4[`Vec(`WordWidth)];
    
    /* use a multiplexer */
    MuxKey
    #(
        .NR_KEY     (20),
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
        `AluGeu,    `ZEXT($unsigned(operator_1) >= $unsigned(operator_2), 1),
        `AluAddw,   `SEXT(temp_0_slice, `WordWidth),
        `AluSllw,   `SEXT(temp_1_slice, `WordWidth),
        `AluSrlw,   `SEXT(temp_2_slice, `WordWidth),
        `AluSraw,   `SEXT(temp_3_slice, `WordWidth),
        `AluSubw,   `SEXT(temp_4_slice, `WordWidth),
        `AluMul,     operator_1 * operator_2
        })
        );
endmodule //Alu
