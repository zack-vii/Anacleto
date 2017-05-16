# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"


}

proc update_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to update ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to validate ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.BRAM_SIZE { PARAM_VALUE.BRAM_SIZE } {
	# Procedure called to update BRAM_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BRAM_SIZE { PARAM_VALUE.BRAM_SIZE } {
	# Procedure called to validate BRAM_SIZE
	return true
}

proc update_PARAM_VALUE.CTRL_COUNT { PARAM_VALUE.CTRL_COUNT } {
	# Procedure called to update CTRL_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CTRL_COUNT { PARAM_VALUE.CTRL_COUNT } {
	# Procedure called to validate CTRL_COUNT
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.HEAD_COUNT { PARAM_VALUE.HEAD_COUNT } {
	# Procedure called to update HEAD_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HEAD_COUNT { PARAM_VALUE.HEAD_COUNT } {
	# Procedure called to validate HEAD_COUNT
	return true
}

proc update_PARAM_VALUE.STAT_COUNT { PARAM_VALUE.STAT_COUNT } {
	# Procedure called to update STAT_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STAT_COUNT { PARAM_VALUE.STAT_COUNT } {
	# Procedure called to validate STAT_COUNT
	return true
}


proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.ADDR_WIDTH { MODELPARAM_VALUE.ADDR_WIDTH PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADDR_WIDTH}] ${MODELPARAM_VALUE.ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.STAT_COUNT { MODELPARAM_VALUE.STAT_COUNT PARAM_VALUE.STAT_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STAT_COUNT}] ${MODELPARAM_VALUE.STAT_COUNT}
}

proc update_MODELPARAM_VALUE.CTRL_COUNT { MODELPARAM_VALUE.CTRL_COUNT PARAM_VALUE.CTRL_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CTRL_COUNT}] ${MODELPARAM_VALUE.CTRL_COUNT}
}

proc update_MODELPARAM_VALUE.HEAD_COUNT { MODELPARAM_VALUE.HEAD_COUNT PARAM_VALUE.HEAD_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HEAD_COUNT}] ${MODELPARAM_VALUE.HEAD_COUNT}
}

proc update_MODELPARAM_VALUE.BRAM_SIZE { MODELPARAM_VALUE.BRAM_SIZE PARAM_VALUE.BRAM_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BRAM_SIZE}] ${MODELPARAM_VALUE.BRAM_SIZE}
}

