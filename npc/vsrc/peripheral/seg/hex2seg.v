// `timescale 1ns / 1ps

module hex2seg(
    input   [3:0]   num,
    input   dot,

    /* verilator lint_off COMBDLY */
    output  reg [7:0]   seg
);

always@(*)
begin
    seg[7]<=~dot;
    case(num)
        4'd0:seg[6:0]<=7'b1000000;
        4'd1:seg[6:0]<=7'b1111001;
        4'd2:seg[6:0]<=7'b0100100;
        4'd3:seg[6:0]<=7'b0110000;
        4'd4:seg[6:0]<=7'b0011001;
        4'd5:seg[6:0]<=7'b0010010;
        4'd6:seg[6:0]<=7'b0000010;
        4'd7:seg[6:0]<=7'b111_1000;
        4'd8:seg[6:0]<=7'b000_0000;
        4'd9:seg[6:0]<=7'b001_0000;
        4'ha:seg[6:0]<=7'b000_1000;
        4'hb:seg[6:0]<=7'b000_0011;
        4'hc:seg[6:0]<=7'b100_0110;
        4'hd:seg[6:0]<=7'b010_0001;
        4'he:seg[6:0]<=7'b000_0110;
        4'hf:seg[6:0]<=7'b000_1110;
    endcase
end

endmodule
