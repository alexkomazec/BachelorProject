`ifndef AXIFULL2_SEQ_SV
`define AXIFULL2_SEQ_SV

class AXIFULL2_seq extends AXIFULL_base_seq;

	`uvm_object_utils (AXIFULL2_seq)
	`uvm_declare_p_sequencer(AXI2_SQR)
	const real MEMORY_C_OFFSET_C = 524288;
	  
	Data_Sequence_AXIFULL req;
	
	
	function new (string name="AXIFULL2_seq");
		super.new(name);
		//req=Data_Sequence_AXIFULL::type_id::create("req");
	endfunction;
	
	virtual task body();
	Data_Sequence_AXIFULL req;
	`uvm_info("AXIFULL2_seq","Starting sequence",UVM_HIGH)
	
/*-------------------------------------------------------------------------------------------     
	--           Read the elements of Rnew from the Zoom2      
	--     -------------------------------------------------------------------------------------------     
	*/ 	
		 
		
	$display ("AXIFULL2_seq:Read the elements of Rnew from the Zoom2  "); 
  // prvi korak  kreiranje transakcije   
	req = Data_Sequence_AXIFULL::type_id::create("req"); 
  // drugi korak - start  
	req.s01_axi_araddr_s=MEMORY_C_OFFSET_C;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_araddr_s);
	req.s01_axi_arlen_s=89999;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_arlen_s);
	req.s01_axi_arsize_s=3'b010;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_arsize_s);
	req.s01_axi_arburst_s=2'b01;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_arburst_s);
	req.s01_axi_arvalid_s=1;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_arvalid_s);
	req.s01_axi_rready_s=1;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_rready_s);
	
	
	req.r_or_w=1'b0;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.r_or_w);
	req.set_to_zero_or_not=1'b0;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.set_to_zero_or_not);
	start_item(req); 
  // cetvrti korak - 
	finish_item(req); 
	
	$display ("AXIFULL_seq:Set zeros to the mentioned fields");
	// prvi korak  kreiranje transakcije   
	req = Data_Sequence_AXIFULL::type_id::create("req"); 	
    // drugi korak - start  
	req.s01_axi_araddr_s=$realtobits(0.0);
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_araddr_s);
	req.s01_axi_arlen_s=$realtobits(0.0);
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_arlen_s);
	req.s01_axi_arburst_s=$realtobits(0.0);
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_arburst_s);
	req.s01_axi_arvalid_s=$realtobits(0.0);
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_arvalid_s);
	
	req.r_or_w=1'b0;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_araddr_s);
	req.set_to_zero_or_not=1'b1;
	$display ("AXIFULL2_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_araddr_s);
	start_item(req);
    // cetvrti korak  
	finish_item(req); 
				      
	`uvm_info("AXIFULL2_seq","Sequence",UVM_HIGH)
	endtask
endclass
`endif
