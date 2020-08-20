
puts " -------------------- "
puts " W7X_TIMING_SETUP.TCL "
puts " -------------------- "


# BRAM_PORTA
ipx::add_bus_interface BRAM_PORTA [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:bram_rtl:1.0 [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:bram:1.0 [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
ipx::add_port_map ADDR [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_addra [ipx::get_port_maps ADDR -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map CLK [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_clka [ipx::get_port_maps CLK -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map DIN [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_dina [ipx::get_port_maps DIN -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map EN [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_ena [ipx::get_port_maps EN -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map DOUT [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_douta [ipx::get_port_maps DOUT -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map RST [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_rsta [ipx::get_port_maps RST -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map WE [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_wea [ipx::get_port_maps WE -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]


# BRAM_PORTB
ipx::add_bus_interface BRAM_PORTB [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:bram_rtl:1.0 [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:bram:1.0 [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property display_name BRAM_PORTB [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property description BRAM_PORTB [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
ipx::add_port_map ADDR [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_addrb [ipx::get_port_maps ADDR -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]
ipx::add_port_map CLK [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_clkb [ipx::get_port_maps CLK -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]
ipx::add_port_map DOUT [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_doutb [ipx::get_port_maps DOUT -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]
ipx::add_port_map EN [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_enb [ipx::get_port_maps EN -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map RST [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_rstb [ipx::get_port_maps RST -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]
ipx::add_port_map WE [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_web [ipx::get_port_maps WE -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]


# Set clk_axi_in on s00_axi
ipx::infer_bus_interface clk_axi_in xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::associate_bus_interfaces -busif s00_axi:BRAM_PORTA:BRAM_PORTB -clock clk_axi_in [ipx::current_core]
ipx::infer_bus_interface clk_int_in xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface clk_int_out xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces clk_int_out -of_objects [ipx::current_core]]
set_property value 10000000 [ipx::get_bus_parameters FREQ_HZ -of_objects [ipx::get_bus_interfaces clk_int_out -of_objects [ipx::current_core]]]


# Add MDD to SoftwareDriverGroup
set mddfile [file normalize "./src/rp_trig.mdd"]
ipx::add_file $mddfile [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type mdd [ipx::get_files $mddfile -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
