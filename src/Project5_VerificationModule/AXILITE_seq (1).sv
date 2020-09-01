`ifndef AXILITE_SEQ_SV
`define AXILITE_SEQ_SV

class AXILITE_seq extends AXILITE_base_seq;
	
	`uvm_object_utils (AXILITE_seq)
	`uvm_declare_p_sequencer(AXI1_SQR)
	
	
	
	function new (string name="AXILITE_seq");
		super.new(name);
		//req=Data_Sequence_AXILITE::type_id::create("req");
	endfunction;
	
	virtual task body();
		Data_Sequence_AXILITE req;
		const real COL_REG_ADDR_C = 0;
		const real ROW_REG_ADDR_C = 4;
		const real N_c = 150;
		const real M_c = 150;
	
	
	`uvm_info("AXILITE_seq","Starting sequence",UVM_HIGH)
		
		//  Set the value for the first dimension (parameter COL) of matrix R and RNEW 	
		//$display ("AXILITE_seq: Set the value for the parameter COL");
		// prvi korak  kreiranje transakcije 
					req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_awaddr_s=$realtobits(COL_REG_ADDR_C);
					//$display ("AXILITE_seq: req.s00_axi_awaddr_s=%b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=1'b1;
					//$display ("AXILITE_seq: req.s00_axi_awvalid_s=%b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=32'b00000000000000000000000010010110;//150
					//$display ("AXILITE_seq: req.s00_axi_wdata_s=%b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b1;
					//$display ("AXILITE_seq: req.s00_axi_wvalid_s=%b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b1111;
					//$display ("AXILITE_seq: req.s00_axi_wstrb_s=%b",req.s00_axi_wstrb_s);
								   req.s00_axi_bready_s=1'b1;
					//$display ("AXILITE_seq: req.s00_axi_bready_s=%b",req.s00_axi_bready_s);
					
					
					
					
					
								   req.r_or_w=1'b1;
					//$display ("AXILITE_seq: req.r_or_w=%b",req.r_or_w);
								   req.set_to_zero_or_not=1'b0;
					//$display ("AXILITE_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
					start_item(req);
					//$display ("AXILITE_seq: start_item(req)");
					// cetvrti korak  
					finish_item(req);
					//$display ("AXILITE_seq: finish_item(req)");
					//$display ("AXILITE_seq: calling transaction print()");
					//print();

		
		//  Set the zeros for the first dimension (parameter COL) of matrix R and RNEW 
		//$display ("AXILITE_seq: Set the zeros to fields");
		// prvi korak  kreiranje transakcije 
					req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_awaddr_s=$realtobits(0.0);
					//$display ("AXILITE_seq: req.s00_axi_awaddr_s=%b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=$realtobits(0.0);
								 //  $display ("AXILITE_seq: req.s00_axi_awvalid_s=%b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=$realtobits(0.0);
								  // $display ("AXILITE_seq: req.s00_axi_wdata_s=%b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b0;
								 //  $display ("AXILITE_seq: req.s00_axi_wvalid_s=%b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b0000;
								  // $display ("AXILITE_seq: req.s00_axi_wstrb_s=%b",req.s00_axi_wstrb_s);
								   req.s00_axi_bready_s=1'b0;
							      // $display ("AXILITE_seq: req.s00_axi_bready_s=%b",req.s00_axi_bready_s);
								   
								   
								   
								   
								   
								   req.r_or_w=1'b1;
								   //$display ("AXILITE_seq: req.r_or_w=%b",req.r_or_w);
								   req.set_to_zero_or_not=1'b1;
							     //  $display ("AXILITE_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
					start_item(req);
					//$display ("AXILITE_seq: start_item(req)");
					// cetvrti korak  
					finish_item(req);
					//$display ("AXILITE_seq: finish_item(req)");
					//`uvm_info(get_type_name(),$sformatf("Printing frame from AXILITE_seq \n %s",this.sprint()),UVM_LOW)
		//  Set the value for the second dimension (parameter ROW) of matrix R and RNEW 
		//$display ("AXILITE_seq: Set the value for the parameter ROW");
		// prvi korak  kreiranje transakcije 
					req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_awaddr_s=4'b0100;//ROW_REG_ADDR_C = 4;
					//$display ("AXILITE_seq: req.s00_axi_awaddr_s=%b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=1'b1;
								  // $display ("AXILITE_seq: req.s00_axi_awvalid_s=%b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=32'b00000000000000000000000010010110;//M_c=150 
								 //  $display ("AXILITE_seq: req.s00_axi_wdata_s=%b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b1;
								 //  $display ("AXILITE_seq: req.s00_axi_wvalid_s=%b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b1111;
								  // $display ("AXILITE_seq: req.s00_axi_wstrb_s=%b",req.s00_axi_wstrb_s);
								   req.s00_axi_bready_s=1'b1;
								 //  $display ("AXILITE_seq: req.s00_axi_bready_s=%b",req.s00_axi_bready_s);
								   req.r_or_w=1'b1;
								 //  $display ("AXILITE_seq: req.r_or_w=%b",req.r_or_w);
								   req.set_to_zero_or_not=1'b0;
								//   $display ("AXILITE_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
					start_item(req);
					//$display ("AXILITE_seq: start_item(req)");
					// cetvrti korak  
					finish_item(req);
					//$display ("AXILITE_seq: finish_item(req)");
		//`uvm_info(get_type_name(),$sformatf("Printing frame from AXILITE_seq \n %s",this.sprint()),UVM_LOW)			
					
		//  Set the zeros  the second dimension (parameter ROW) of matrix R and RNEW
		//$display ("AXILITE_seq: Set the zeros to fields");
		// prvi korak  kreiranje transakcije 
					req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_awaddr_s=$realtobits(0.0);
					//$display ("AXILITE_seq: req.s00_axi_awaddr_s=%b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=$realtobits(0.0);
								  // $display ("AXILITE_seq: req.s00_axi_awvalid_s=%b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=$realtobits(0.0);
								  // $display ("AXILITE_seq: req.s00_axi_wdata_s=%b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b0;
								  // $display ("AXILITE_seq: req.s00_axi_wvalid_s=%b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b0000;
								  // $display ("AXILITE_seq: req.s00_axi_wstrb_s=%b",req.s00_axi_wstrb_s);
								   req.s00_axi_bready_s=1'b0;
								 //  $display ("AXILITE_seq: req.s00_axi_bready_s=%b",req.s00_axi_bready_s);
								   req.r_or_w=1'b1;
								//   $display ("AXILITE_seq: req.r_or_w=%b",req.r_or_w);
								   req.set_to_zero_or_not=1'b1;
								//   $display ("AXILITE_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
					start_item(req);
					//$display ("AXILITE_seq: start_item(req)");
					// cetvrti korak  
					finish_item(req);
					//$display ("AXILITE_seq: finish_item(req)");
	`uvm_info("AXILITE_seq","Sequence",UVM_HIGH)
	 //`uvm_info(get_type_name(),$sformatf("Printing frame from AXILITE_seq \n %s",this.sprint()),UVM_LOW)
	endtask
endclass
`endif	
