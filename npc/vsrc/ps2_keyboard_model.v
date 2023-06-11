// 不能去掉，和test.v的保持一致，否则test.v的#1表示1us，即为1000ns，这里的表示
// 1ns，timescale不一致。
`timescale 1us/1ns

module ps2_keyboard_model(
    output reg ps2_clk,
    output reg ps2_data
);
parameter [31:0] kbd_clk_period = 60;
initial ps2_clk = 1'b1;

task kbd_sendcode;
    input [7:0] code; // key to be sent
    integer i;

    reg[10:0] send_buffer;
    begin
        send_buffer[0]   = 1'b0;  // start bit
        send_buffer[8:1] = code;  // code
        send_buffer[9]   = ~(^code); // odd parity bit
        send_buffer[10]  = 1'b1;  // stop bit
        i = 0;
        while( i < 11) begin
            // set kbd_data
            ps2_data = send_buffer[i];
            #(kbd_clk_period/2) ps2_clk = 1'b0;
            #(kbd_clk_period/2) ps2_clk = 1'b1;
            i = i + 1;
        end
    end
endtask

endmodule
