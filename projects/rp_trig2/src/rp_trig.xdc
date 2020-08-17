create_clock -period 100 -name clk_in  -waveform {0 50} [get_ports {clk_ext_in clk_int_in}]
create_clock -period  8  -name clk_axi -waveform {0  4} [get_ports clk_axi_in]
set_clock_groups -name async -asynchronous -group {clk_in} -group {clk_axi}

set_input_delay  -clock [get_clocks clk_axi] -min  0 [get_ports s00_axi_* -filter {DIRECTION==IN}]
set_input_delay  -clock [get_clocks clk_axi] -max  4 [get_ports s00_axi_* -filter {DIRECTION==IN}]

set_output_delay -clock [get_clocks clk_axi] -min  0 [get_ports s00_axi_* -filter {DIRECTION==OUT}]
set_output_delay -clock [get_clocks clk_axi] -max  1 [get_ports s00_axi_* -filter {DIRECTION==OUT}]

set_input_delay  -clock [get_clocks clk_in] -min  0 [get_ports trg_in]
set_input_delay  -clock [get_clocks clk_in] -max 10 [get_ports trg_in]

set_output_delay -clock [get_clocks clk_in] -min  0 [get_ports state_out[*]]
set_output_delay -clock [get_clocks clk_in] -max 10 [get_ports state_out[*]]