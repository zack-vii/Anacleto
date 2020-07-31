puts " -------------------- "
puts " W7X_TIMING_SETUP.TCL "
puts " -------------------- "


# BRAM_PORTA
ipx::add_bus_interface BRAM_PORTA [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:bram_rtl:1.0 [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:bram:1.0 [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
ipx::add_port_map RST [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_rsta [ipx::get_port_maps RST -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map CLK [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_clka [ipx::get_port_maps CLK -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map DIN [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_dina [ipx::get_port_maps DIN -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map EN [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_ena [ipx::get_port_maps EN -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map DOUT [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_douta [ipx::get_port_maps DOUT -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map WE [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_wea [ipx::get_port_maps WE -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]
ipx::add_port_map ADDR [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]
set_property physical_name bram_addra [ipx::get_port_maps ADDR -of_objects [ipx::get_bus_interfaces BRAM_PORTA -of_objects [ipx::current_core]]]


# BRAM_PORTB
ipx::add_bus_interface BRAM_PORTB [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:bram_rtl:1.0 [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:bram:1.0 [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property display_name BRAM_PORTB [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property description BRAM_PORTB [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
ipx::add_port_map DOUT [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_doutb [ipx::get_port_maps DOUT -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]
ipx::add_port_map RST [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_rstb [ipx::get_port_maps RST -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]
ipx::add_port_map CLK [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_clkb [ipx::get_port_maps CLK -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]
ipx::add_port_map ADDR [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]
set_property physical_name bram_addrb [ipx::get_port_maps ADDR -of_objects [ipx::get_bus_interfaces BRAM_PORTB -of_objects [ipx::current_core]]]


# Set FREQ_HZ on s00_axi
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces s00_axi -of_objects [ipx::current_core]]
set_property value 125000000 [ipx::get_bus_parameters FREQ_HZ -of_objects [ipx::get_bus_interfaces s00_axi -of_objects [ipx::current_core]]]


# Add MDD to SoftwareDriverGroup
ipx::add_file ./src/w7x_timing.mdd [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type mdd [ipx::get_files ./src/w7x_timing.mdd -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
