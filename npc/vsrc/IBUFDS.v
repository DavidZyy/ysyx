module IBUFDS (
    input      I,
    input      IB,
    
    output     O
);

    assign O = I ^ IB;
    
endmodule //IBUFDS
