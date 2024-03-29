`include "./include/defines.v"

module seg (
  input [31:0] display_data,

  output [7:0] seg0,
  output [7:0] seg1,
  output [7:0] seg2,
  output [7:0] seg3,
  output [7:0] seg4,
  output [7:0] seg5,
  output [7:0] seg6,
  output [7:0] seg7
);
    
wire [7:0] hex[15:0];

/* common anode */
assign hex[0] =  8'h03;
assign hex[1] =  8'h9f;
assign hex[2] =  8'h25;
assign hex[3] =  8'h0d;
assign hex[4] =  8'h99;
assign hex[5] =  8'h49;
assign hex[6] =  8'h41;
assign hex[7] =  8'h1f;
assign hex[8] =  8'h01;
assign hex[9] =  8'h09;
assign hex[10] = 8'h11;
assign hex[11] = 8'hc1;
assign hex[12] = 8'h63;
assign hex[13] = 8'h85;
assign hex[14] = 8'h61;
assign hex[15] = 8'h71;

/* common cathode */
// assign hex[0] =  8'h3f;
// assign hex[1] =  8'h06;
// assign hex[2] =  8'h5b;
// assign hex[3] =  8'h4f;
// assign hex[4] =  8'h66;
// assign hex[5] =  8'h6d;
// assign hex[6] =  8'h7d;
// assign hex[7] =  8'h07;
// assign hex[8] =  8'h7f;
// assign hex[9] =  8'h6f;
// assign hex[10] = 8'h77;
// assign hex[11] = 8'h7c;
// assign hex[12] = 8'h39;
// assign hex[13] = 8'h5e;
// assign hex[14] = 8'h79;
// assign hex[15] = 8'h71;


MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i0 (
  .out(seg0),
  .key(display_data[3:0]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);

MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i1 (
  .out(seg1),
  .key(display_data[7:4]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);

MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i2 (
  .out(seg2),
  .key(display_data[11:8]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);

MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i3 (
  .out(seg3),
  .key(display_data[15:12]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);


MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i4 (
  .out(seg4),
  .key(display_data[19:16]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);


MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i5 (
  .out(seg5),
  .key(display_data[23:20]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);


MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i6 (
  .out(seg6),
  .key(display_data[27:24]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);

MuxKey 
#(
  .NR_KEY   (16), 
  .KEY_LEN  (4), 
  .DATA_LEN (8)
) 
i7 (
  .out(seg7),
  .key(display_data[31:28]),
  .lut({
  4'h0, hex[0],
  4'h1, hex[1],
  4'h2, hex[2],
  4'h3, hex[3],
  4'h4, hex[4],
  4'h5, hex[5],
  4'h6, hex[6],
  4'h7, hex[7],
  4'h8, hex[8],
  4'h9, hex[9],
  4'ha, hex[10],
  4'hb, hex[11],
  4'hc, hex[12],
  4'hd, hex[13],
  4'he, hex[14],
  4'hf, hex[15]
  })
);

endmodule //seg

