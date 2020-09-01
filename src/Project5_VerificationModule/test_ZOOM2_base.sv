/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            test_ZOOM2_base.sv

    DESCRIPTION     base test; to be extended by all other tests

*******************************************************************************/

`ifndef TEST_ZOOM2_BASE_SV
`define TEST_ZOOM2_BASE_SV

class test_ZOOM2_base extends uvm_test;

    `uvm_component_utils(test_ZOOM2_base)
	
	  AXI_env e;
	  AXI_config cfg;
    function new(string name = "test_ZOOM2_base", uvm_component parent = null);
        super.new(name,parent);
    endfunction : new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         e = AXI_env::type_id::create("e", this);
		 cfg = AXI_config::type_id::create("cfg");
		 uvm_config_db#(AXI_config)::set(this, "*", "AXI_config", cfg);
	endfunction : build_phase

    function void connect_phase(uvm_phase phase);
       // drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction : connect_phase

	  // UVM end_of_elaboration_phase
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        // display verification environment topology
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase 

endclass : test_ZOOM2_base

`endif

