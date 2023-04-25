module led (
    input [`Vec(8)]     led_wdata,

    output  [`Vec(8)]   led_out
);

    assign led_out = led_wdata; 

endmodule //led
