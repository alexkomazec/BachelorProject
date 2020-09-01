/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXI_env.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXI_ENV_SV
`define AXI_ENV_SV

class AXI_env extends uvm_env;

	AXILITE_agent LITEagent;
	AXIFULL_agent FULLagent;
	AXI_scoreboard AXIscoreboard;

    `uvm_component_utils (AXI_env)

    function new(string name = "AXI_env", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
		LITEagent = AXILITE_agent::type_id::create("AXILITE_agent", this);
		FULLagent = AXIFULL_agent::type_id::create("FULLagent", this);
		AXIscoreboard = AXI_scoreboard::type_id::create("AXI_scoreboard", this); 
    endfunction : build_phase
	
	 function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
		  LITEagent.mon.item_collected_port.connect(AXIscoreboard.port_lite);
		  FULLagent.mon.item_collected_port.connect(AXIscoreboard.port_full);
    endfunction : connect_phase

endclass : AXI_env

`endif




