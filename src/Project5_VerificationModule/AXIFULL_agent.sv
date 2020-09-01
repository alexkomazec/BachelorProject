/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXIFULL_agent.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXIFULL_AGENT_SV
`define AXIFULL_AGENT_SV

class AXIFULL_agent extends uvm_agent;

    // components
	  AXIFULL_drive drv;
      AXI2_SQR seqr;
      AXIFULL_monitor mon;

    // configuration
     AXI_config cfg;

    `uvm_component_utils_begin (AXIFULL_agent)
		`uvm_field_object(cfg, UVM_DEFAULT)
	`uvm_component_utils_end

    function new(string name = "AXIFULL_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(AXI_config)::get(this, "", "AXI_config", cfg))
            `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".cfg"})

        mon = AXIFULL_monitor::type_id::create("mon", this);
        if(cfg.is_active == UVM_ACTIVE) begin
            drv = AXIFULL_drive::type_id::create("drv", this);
            seqr = AXI2_SQR::type_id::create("seqr", this);
        end

    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(cfg.is_active == UVM_ACTIVE) begin
            drv.seq_item_port.connect(seqr.seq_item_export);
        end
    endfunction : connect_phase

endclass : AXIFULL_agent

`endif

