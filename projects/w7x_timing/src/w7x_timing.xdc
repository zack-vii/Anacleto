create_clock -period 100 -name clk_ext_in -waveform {0 50} [get_ports clk_ext_in]
create_clock -period  10 -name clk_axi_in -waveform {0  5} [get_ports clk_axi_in]
set_clock_groups -name async -asynchronous -group {clk_ext_in} -group {clk_axi_in}

set_input_delay  -clock [get_clocks clk_axi_in] -min  0 [get_ports s00_axi_* -filter {DIRECTION==IN}]
set_input_delay  -clock [get_clocks clk_axi_in] -max  4 [get_ports s00_axi_* -filter {DIRECTION==IN}]

set_output_delay -clock [get_clocks clk_axi_in] -min  0 [get_ports s00_axi_* -filter {DIRECTION==OUT}]
set_output_delay -clock [get_clocks clk_axi_in] -max  1 [get_ports s00_axi_* -filter {DIRECTION==OUT}]

set_input_delay  -clock [get_clocks clk_ext_in] -min  0 [get_ports trg_in]
set_input_delay  -clock [get_clocks clk_ext_in] -max 10 [get_ports trg_in]

set_output_delay -clock [get_clocks clk_ext_in] -min  0 [get_ports state_out[*]]
set_output_delay -clock [get_clocks clk_ext_in] -max 10 [get_ports state_out[*]]
