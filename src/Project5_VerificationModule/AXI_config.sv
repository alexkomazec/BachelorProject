/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXI_config.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXI_CONFIG
`define AXI_CONFIG

class AXI_config
 extends uvm_object;

    uvm_active_passive_enum is_active = UVM_ACTIVE;

    `uvm_object_utils_begin (AXI_config)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
    `uvm_object_utils_end

    function new(string name = "AXI_config");
        super.new(name);
    endfunction

endclass : AXI_config

`endif


