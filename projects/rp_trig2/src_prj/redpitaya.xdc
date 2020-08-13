

############################################################################
# IO constraints                                                           #
############################################################################

#### DIO
# in
set_property IOSTANDARD LVCMOS33 [get_ports {trg_in clk_in}]
set_property PULLDOWN true       [get_ports {trg_in clk_in}]
# out
set_property IOSTANDARD LVCMOS33 [get_ports {state0[*] trg_out clk_out clk_int_out active_out state_leds[*]}]
set_property SLEW FAST           [get_ports {state0[*] trg_out clk_out clk_int_out active_out state_leds[*]}]
set_property DRIVE 8             [get_ports {state0[*] trg_out clk_out clk_int_out active_out              }]
set_property DRIVE 4             [get_ports {                                               state_leds[*]}]
#DIO0-7_P
set_property PACKAGE_PIN G17 [get_ports trg_in]
set_property PACKAGE_PIN H16 [get_ports trg_out]
set_property PACKAGE_PIN J18 [get_ports clk_in]
set_property PACKAGE_PIN K17 [get_ports clk_int_out]
set_property PACKAGE_PIN L14 [get_ports clk_out]
set_property PACKAGE_PIN L16 [get_ports active_out]
#set_property PACKAGE_PIN K16 [get_ports pin6]
#set_property PACKAGE_PIN M14 [get_ports pin7]
#DIO0-7_N
set_property PACKAGE_PIN G18 [get_ports {state0[0]}]
set_property PACKAGE_PIN H17 [get_ports {state0[1]}]
set_property PACKAGE_PIN H18 [get_ports {state0[2]}]
set_property PACKAGE_PIN K18 [get_ports {state0[3]}]
set_property PACKAGE_PIN L15 [get_ports {state0[4]}]
set_property PACKAGE_PIN L17 [get_ports {state0[5]}]
set_property PACKAGE_PIN J16 [get_ports {state0[6]}]
set_property PACKAGE_PIN M15 [get_ports {state0[7]}]

#### LED PINS
set_property PACKAGE_PIN F16 [get_ports {state_leds[0]}]
set_property PACKAGE_PIN F17 [get_ports {state_leds[1]}]
set_property PACKAGE_PIN G15 [get_ports {state_leds[2]}]
set_property PACKAGE_PIN H15 [get_ports {state_leds[3]}]
set_property PACKAGE_PIN K14 [get_ports {state_leds[4]}]
set_property PACKAGE_PIN G14 [get_ports {state_leds[5]}]
set_property PACKAGE_PIN J15 [get_ports {state_leds[6]}]
set_property PACKAGE_PIN J14 [get_ports {state_leds[7]}]

#create_clock -period 100.000 -name clk_ext_in -waveform {0.000 50.000} [get_ports clk_in]
#set_clock_groups -name async -asynchronous -group clk_ext_in -group clk_fpga_0
#
#set_output_delay -clock [get_clocks clk_ext_in] -min 3 [get_ports {state0[*] trg_out state_leds[*]}]
#set_output_delay -clock [get_clocks clk_ext_in] -max 8 [get_ports {state0[*] trg_out state_leds[*]}]
#set_input_delay  -clock [get_clocks clk_ext_in] -min 3 [get_ports {trg_in}]
#set_input_delay  -clock [get_clocks clk_ext_in] -max 8 [get_ports {trg_in}]
