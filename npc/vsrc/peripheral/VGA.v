// vga control

module VGA(
    input   clk,
    input   rst,
    input   [11:0]  din,

    output  reg [8:0]   row,
    output  reg [9:0]   col,
    output  reg rdn,
    output  reg [3:0]   R,G,B,
    output  reg HS,VS
);

reg [9:0]   h_count;

always@(posedge clk) begin
    if(rst)
    begin
        h_count<=10'h0;
    end
    else
    begin
        if(h_count==10'd799)
            h_count<=10'h0;
        else
            h_count<=h_count+10'h1;
    end
end

reg [9:0]   v_count;

always@(posedge clk or  posedge rst) begin
    if(rst)
        v_count<=10'h0;
    else begin
        if(h_count==10'd799) begin
            if(v_count==10'd524)
                v_count<=10'h0;
            else
                v_count<=v_count+10'h1;
        end
        else begin
            v_count<=v_count;
        end
    end
end

wire    [9:0]   row_addr;
assign  row_addr=v_count-10'd35;

wire    [9:0]   col_addr;
assign  col_addr=h_count-10'd143;

wire    h_sync;
assign  h_sync=(h_count>10'd95)?(1'b1):(1'b0);

wire    v_sync;
assign  v_sync=(v_count>10'd1);

wire    read;
assign  read=(h_count>10'd142)&&(h_count<10'd783)&&(v_count>10'd34)&&(v_count<10'd515);

always@(posedge clk) begin
    row<=row_addr[8:0];
    col<=col_addr;
    rdn<=~read;
    HS<=h_sync;
    VS<=v_sync;
    {R,G,B}<=(rdn)?(12'h0):({din[3:0],din[7:4],din[11:8]});
end

endmodule
