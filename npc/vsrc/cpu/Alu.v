`include "./include/defines.v"

module Alu (
    input  [`Vec(`ImmWidth)]    operator_1,
    input  [`Vec(`ImmWidth)]    operator_2,
    input  [`Vec(`AluopWidth)]  alu_op_ID,

    output [`Vec(`ImmWidth)]    alu_result
);
    
    /* verilator lint_off UNUSEDSIGNAL */
    // wire[`Vec(`ImmWidth)] temp_0, temp_1, temp_2, temp_3, temp_4;
    // wire [`Vec(`WordWidth)] temp_0_slice, temp_1_slice, temp_2_slice, temp_3_slice, temp_4_slice;

    wire[`Vec(`ImmWidth)] temp_0 = (operator_1 + operator_2);
    wire[`Vec(`ImmWidth)] temp_1 = (operator_1 <<  operator_2[`Vec(`ShtWdtW)]);
    // wire[`Vec(`ImmWidth)] temp_2 = (operator_1 >>  operator_2[`Vec(`ShtWdtW)]);
    // wire[`Vec(`ImmWidth)] temp_3 = (operator_1 >>> operator_2[`Vec(`ShtWdtW)]);
    wire[`Vec(`WordWidth)] temp_2 = operator_1[`Vec(`WordWidth)];
    wire[`Vec(`WordWidth)] temp_3 = operator_1[`Vec(`WordWidth)];
    wire[`Vec(`ImmWidth)] temp_4 = (operator_1 - operator_2);
    wire[127:0] temp_5 = ($signed(operator_1) * $signed(operator_2)); // mulh
    wire[127:0] temp_6 = ($signed(operator_1) * $unsigned(operator_2)); // mulhsu
    wire[127:0] temp_7 = ($unsigned(operator_1) * $unsigned(operator_2)); // mulhu
    wire[127:0] temp_8 = ((operator_1) * (operator_2)); // mulw
    wire[`Vec(`ImmWidth)] temp_9  = ($signed(operator_1) / $signed(operator_2)); // div
    wire[`Vec(`ImmWidth)] temp_10 = ($unsigned(operator_1) / $unsigned(operator_2)); // divu
    wire[`Vec(`ImmWidth)] temp_11 = ($signed(operator_1) % $signed(operator_2)); // rem
    wire[`Vec(`ImmWidth)] temp_12 = ($unsigned(operator_1) % $unsigned(operator_2)); // remu


    wire [`Vec(`WordWidth)] temp_0_slice  = temp_0[`Vec(`WordWidth)];
    wire [`Vec(`WordWidth)] temp_1_slice  = temp_1[`Vec(`WordWidth)];
    // wire [`Vec(`WordWidth)] temp_2_slice  = temp_2[`Vec(`WordWidth)];
    // wire [`Vec(`WordWidth)] temp_3_slice  = temp_3[`Vec(`WordWidth)];
    wire [`Vec(`WordWidth)] temp_2_slice  = temp_2 >> operator_2[`Vec(`ShtWdtW)];
    wire [`Vec(`WordWidth)] temp_3_slice  = $signed(temp_3 ) >>> operator_2[`Vec(`ShtWdtW)];
    wire [`Vec(`WordWidth)] temp_4_slice  = temp_4[`Vec(`WordWidth)];
    wire [`Vec(`ImmWidth)]  temp_5_slice  = temp_5[127:64]; // temp_5 >> `ImmWidth;
    wire [`Vec(`ImmWidth)]  temp_6_slice  = temp_6[127:64];
    wire [`Vec(`ImmWidth)]  temp_7_slice  = temp_7[127:64];
    wire [`Vec(`WordWidth)] temp_8_slice  = temp_8[`Vec(`WordWidth)];
    wire [`Vec(`WordWidth)] temp_9_slice  = temp_9[`Vec(`WordWidth)];
    wire [`Vec(`WordWidth)] temp_10_slice = temp_10[`Vec(`WordWidth)];
    wire [`Vec(`WordWidth)] temp_11_slice = temp_11[`Vec(`WordWidth)];
    wire [`Vec(`WordWidth)] temp_12_slice = temp_12[`Vec(`WordWidth)];
    
    /* use a multiplexer */
    MuxKey
    #(
        .NR_KEY     (33),
        .KEY_LEN    (`AluopWidth),
        .DATA_LEN   (`ImmWidth)
    )
    alu_mux(
        .out(alu_result),
        .key(alu_op_ID),
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
        `AluMul,     operator_1 * operator_2,
        `AluMulh  ,  temp_5_slice,
        `AluMulhsu,  temp_6_slice,
        `AluMulhu ,  temp_7_slice,
        `AluMulw  ,  `SEXT(temp_8_slice, `WordWidth),
        `Aludiv   ,  temp_9,
        `Aludivu  ,  temp_10,
        `Alurem   ,  temp_11,
        `Aluremu  ,  temp_12,
        `Aludivw  ,  `SEXT(temp_9_slice,  `WordWidth),
        `Aludivuw ,  `SEXT(temp_10_slice, `WordWidth), 
        `Aluremw  ,  `SEXT(temp_11_slice, `WordWidth), 
        `Aluremuw ,  `SEXT(temp_12_slice, `WordWidth)
        })
        );
endmodule //Alu
