/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXILITE_agent.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXILITE_AGENT_SV
`define AXILITE_AGENT_SV

class AXILITE_agent extends uvm_agent;

    // components
    AXILITE_drive drv;
    AXI1_SQR seqr;
    AXILITE_monitor mon;

    // configuration
		AXI_config cfg;


	`uvm_component_utils_begin (AXILITE_agent)
		`uvm_field_object(cfg, UVM_DEFAULT)
	`uvm_component_utils_end

    function new(string name = "AXILITE_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(AXI_config)::get(this, "", "AXI_config", cfg))
            `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".cfg"})

        mon = AXILITE_monitor::type_id::create("mon", this);
        if(cfg.is_active == UVM_ACTIVE) begin
            drv = AXILITE_drive::type_id::create("drv", this);
            seqr = AXI1_SQR::type_id::create("seqr", this);
        end

    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(cfg.is_active == UVM_ACTIVE) begin
            drv.seq_item_port.connect(seqr.seq_item_export);
        end
    endfunction : connect_phase

endclass : AXILITE_agent

`endif

