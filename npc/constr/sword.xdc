# constrain file of sword board
set_property PACKAGE_PIN M24 [get_ports SEGCLK]
set_property IOSTANDARD LVCMOS33 [get_ports SEGCLK]
set_property PACKAGE_PIN P19 [get_ports SEGCLR]
set_property IOSTANDARD LVCMOS33 [get_ports SEGCLR]
set_property PACKAGE_PIN L24 [get_ports SEGDT]
set_property IOSTANDARD LVCMOS33 [get_ports SEGDT]
set_property PACKAGE_PIN R18 [get_ports SEGEN]
set_property IOSTANDARD LVCMOS33 [get_ports SEGEN]

# set_property PACKAGE_PIN M19 [get_ports PS2_Data]
# set_property IOSTANDARD LVCMOS33 [get_ports PS2_Data]
# set_property PULLUP true [get_ports PS2_Data]
# set_property PACKAGE_PIN N18 [get_ports PS2_clk]
# set_property IOSTANDARD LVCMOS33 [get_ports PS2_clk]
# set_property PULLUP true [get_ports PS2_clk]

set_property PACKAGE_PIN AC18 [get_ports clk]
set_property IOSTANDARD LVDS [get_ports clk]
set_property PACKAGE_PIN W13 [get_ports rst]
set_property IOSTANDARD LVCMOS18 [get_ports rst]
