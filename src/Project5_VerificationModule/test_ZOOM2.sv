`ifndef IP_ZOOM_AXI_V1_0_150x150_IF
`define IP_ZOOM_AXI_V1_0_150x150_IF


`include "sequences/AXILITE_base_seq.sv"
`include "sequences/AXIFULL_base_seq.sv"

`include "sequences/AXILITE_seq.sv"
`include "sequences/AXIFULL_seq.sv"
`include "sequences/AXILITE2_seq.sv"
`include "sequences/AXIFULL2_seq.sv"



class test_ZOOM2 extends test_ZOOM2_base;
	
    `uvm_component_utils(test_ZOOM2)
	
	AXILITE_seq s1;
	AXIFULL_seq s2;
	AXILITE2_seq s3;
	AXIFULL2_seq s4;

    function new(string name = "test_ZOOM2", uvm_component parent = null);
        super.new(name,parent);
    endfunction : new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
		  s1 = AXILITE_seq::type_id::create("s1");
		  s2 = AXIFULL_seq::type_id::create("s2");
		  s3 = AXILITE2_seq::type_id::create("s3");
		  s4 = AXIFULL2_seq::type_id::create("s4");
    endfunction : build_phase

    task run_phase(uvm_phase phase);
	`uvm_info("test_ZOOM2","---TEST_SEQUENCES---",UVM_LOW)
		//assert(s1.randomize());
	`uvm_info("test_ZOOM2","---RAISE AN OBJECTION---",UVM_LOW)
        phase.raise_objection(this);
	`uvm_info("test_ZOOM2","---START s1---",UVM_LOW)
        s1.start(e.LITEagent.seqr);
	`uvm_info("test_ZOOM2","---START s2---",UVM_LOW)
	 	s2.start(e.FULLagent.seqr);
	`uvm_info("test_ZOOM2","---START s3---",UVM_LOW)
	 	s3.start(e.LITEagent.seqr);
	`uvm_info("test_ZOOM2","---START s4---",UVM_LOW)
		s4.start(e.FULLagent.seqr);
        phase.drop_objection(this);
    endtask : run_phase

endclass : test_ZOOM2

`endif