/*
    switch 
*/
`include "../include/defines.v"

module swt (
    input   [`Vec(8)]   swt,

    output  [`Vec(8)]   swt_rdata
);
    
    assign swt_rdata = swt;

endmodule //swt
