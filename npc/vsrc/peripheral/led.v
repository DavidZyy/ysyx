
`include "../include/defines.v"
module led (
    input [`Vec(`LedWidth)]     led_wdata,

    output  [`Vec(`LedWidth)]   led_out
);

    assign led_out = led_wdata;

endmodule //led
