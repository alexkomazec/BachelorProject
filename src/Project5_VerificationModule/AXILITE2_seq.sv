`ifndef AXILITE2_seq
`define AXILITE2_seq



class AXILITE2_seq extends AXILITE_base_seq;
	
	`uvm_object_utils (AXILITE2_seq)
	`uvm_declare_p_sequencer(AXI1_SQR)
	
	bit [31:0]axi_read_data_v;
	bit [31:0]axi_read_data_c;
	
	
	function new (string name="AXILITE2_seq");
		super.new(name);
		//req=Data_Sequence_AXILITE::type_id::create("req");
	endfunction;
	
	virtual task body();
	
	Data_Sequence_AXILITE req;
	
	
	const real CMD_REG_ADDR_C = 8;
	const real STATUS_REG_ADDR_C =12 ;
	const real ROW_REG_ADDR_C = 4;
	
	
	`uvm_info("AXILITE2_seq","Starting sequence",UVM_HIGH)
	


				//----------------------------------------------
				//---------Start the Zoom2 core-----------------
                //----------------------------------------------
		
		// Set the value start bit (bit 0 in the CMD register) to 1
		//$display ("AXILITE2_seq:  Set the CMD value to 1 //to start bit");
		req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
								   req.s00_axi_awaddr_s=8;
								  // $display ("AXILITE2_seq:  s00_axi_awaddr_s %b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=1;
								//   $display ("AXILITE2_seq:  s00_axi_awvalid_s %b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=1;
								 //  $display ("AXILITE2_seq:  s00_axi_wdata_s %b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b1;
								//  $display ("AXILITE2_seq:  s00_axi_wvalid_s %b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b1111;
								//   $display ("AXILITE2_seq:  s00_axi_wstrb_s %b",req.s00_axi_wstrb_s);
								 req.s00_axi_bready_s=1'b1;
								//  $display ("AXILITE2_seq:  s00_axi_bready_s %b",req.s00_axi_bready_s);
								   
								   
								   
								   req.r_or_w=1'b1;
								  // $display ("AXILITE2_seq:  r_or_w %b",req.r_or_w);
								   req.set_to_zero_or_not=1'b0;
								 //  $display ("AXILITE2_seq:  set_to_zero_or_not %b",req.set_to_zero_or_not);
					start_item(req);
					// cetvrti korak  
					finish_item(req);
		
		// Set the value start bit (bit 0 in the CMD register) to zeros
		//$display ("AXILITE2_seq:  Set the  CMD value to 0 //to start bit");
		req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_awaddr_s=$realtobits(0.0);
					//$display ("AXILITE2_seq:  s00_axi_awaddr_s %b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=$realtobits(0.0);
								  // $display ("AXILITE2_seq:  s00_axi_awvalid_s %b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=$realtobits(0.0);
								  // $display ("AXILITE2_seq:  s00_axi_wdata_s %b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b0;
								 //  $display ("AXILITE2_seq:  s00_axi_wvalid_s %b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b0000;
								//  $display ("AXILITE2_seq:  s00_axi_wstrb_s %b",req.s00_axi_wstrb_s);
								   req.s00_axi_bready_s=1'b0;
								//   $display ("AXILITE2_seq:  s00_axi_bready_s %b",req.s00_axi_bready_s);
								   
								   
								   
								   req.r_or_w=1'b1;
								//  $display ("AXILITE2_seq:  r_or_w %b",req.r_or_w);
								   req.set_to_zero_or_not=1'b1;
								//  $display ("AXILITE2_seq:  set_to_zero_or_not %b",req.set_to_zero_or_not);
					start_item(req);
					// cetvrti korak  
					finish_item(req);
					
		//Clearing the start bit!
		//$display ("AXILITE2_seq:  Clearing the start bit!");
		req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_awaddr_s=CMD_REG_ADDR_C;
					//$display ("AXILITE2_seq:  s00_axi_awaddr_s %b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=1;
								  // $display ("AXILITE2_seq:  s00_axi_awvalid_s %b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=$realtobits(0.0);
								//   $display ("AXILITE2_seq:  s00_axi_wdata_s %b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b1;
								//   $display ("AXILITE2_seq:  s00_axi_wvalid_s %b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b1111;
								//   $display ("AXILITE2_seq:  s00_axi_wstrb_s %b",req.s00_axi_wstrb_s);
								   req.s00_axi_bready_s=1'b1;
								//   $display ("AXILITE2_seq:  s00_axi_bready_s %b",req.s00_axi_bready_s);
								   
								   
								   
								   req.r_or_w=1'b1;
								 //  $display ("AXILITE2_seq:  r_or_w %b",req.r_or_w);
								   req.set_to_zero_or_not=1'b0;
								//   $display ("AXILITE2_seq:  set_to_zero_or_not %b",req.set_to_zero_or_not);
					start_item(req);
					// cetvrti korak  
					finish_item(req);
					
		// Set the value start bit (bit 0 in the CMD register) to zeros
		//$display ("AXILITE2_seq: Set the value start bit (bit 0 in the CMD register) to zeros!");
		req = Data_Sequence_AXILITE::type_id::create("req"); 	
				//	 drugi korak - start  
					req.s00_axi_awaddr_s=$realtobits(0.0);
					//$display ("AXILITE2_seq:  s00_axi_awaddr_s %b",req.s00_axi_awaddr_s);
								   req.s00_axi_awvalid_s=$realtobits(0.0);
								  // $display ("AXILITE2_seq:  s00_axi_awvalid_s %b",req.s00_axi_awvalid_s);
								   req.s00_axi_wdata_s=$realtobits(0.0);
								 //  $display ("AXILITE2_seq:  s00_axi_wdata_s %b",req.s00_axi_wdata_s);
								   req.s00_axi_wvalid_s=1'b0;
								//   $display ("AXILITE2_seq:  s00_axi_wvalid_s %b",req.s00_axi_wvalid_s);
								   req.s00_axi_wstrb_s=4'b0000;
								 //  $display ("AXILITE2_seq:  s00_axi_wstrb_s %b",req.s00_axi_wstrb_s);
								   req.s00_axi_bready_s=1'b0;
								 //  $display ("AXILITE2_seq:  s00_axi_bready_s %b",req.s00_axi_bready_s);
								   
								   
								   
								   req.r_or_w=1'b1;
								  // $display ("AXILITE2_seq:  r_or_w %b",req.r_or_w);
								   req.set_to_zero_or_not=1'b1;
								  // $display ("AXILITE2_seq:  set_to_zero_or_not %b",req.set_to_zero_or_not);
					start_item(req);
					// cetvrti korak  
					finish_item(req);
					
		
	
		
		//axi_read_data_v=0;
	//	$display ("AXILITE2_seq: axi_read_data_v=%b",axi_read_data_v);
		//$display ("AXILITE2_seq: Pre ulaska");
	//	while(axi_read_data_v[0]!==1'b1) begin
			//	$display ("AXILITE2_seq: axi_read_data_v[0]!==1'b1------------");
				//$display ("AXILITE2_seq: ------------Read the content of the Status register--------------");
				// Read the content of the Status register
				req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_araddr_s=STATUS_REG_ADDR_C;
					$display ("AXILITE2_seq:  s00_axi_araddr_s %b",req.s00_axi_araddr_s);
												   req.s00_axi_arvalid_s=1;
												  // $display ("AXILITE2_seq:  s00_axi_arvalid_s %b",req.s00_axi_arvalid_s);
								                   req.s00_axi_rready_s=1;
												   //$display ("AXILITE2_seq:  s00_axi_rready_s %b",req.s00_axi_rready_s);
												   
												   
												   
												   req.r_or_w=1'b0;
												//   $display ("AXILITE2_seq:  r_or_w %b",req.r_or_w);
												   req.set_to_zero_or_not=1'b0;
											//	   $display ("AXILITE2_seq:  set_to_zero_or_not %b",req.set_to_zero_or_not);
												 //  axi_read_data_v=req.s00_axi_rdata_s;
												  // $display ("AXILITE2_seq:AAA RTC axi_read_data_v=%b AAA",axi_read_data_v);
												  // $display ("AXILITE2_seq:AAA RTC req.s00_axi_rdata_s=%b AAA",req.s00_axi_rdata_s);
					start_item(req);
				//	$display ("AXILITE2_seq: start_item(req)");
					// cetvrti korak  
					finish_item(req);
				//	$display ("AXILITE2_seq: finish_item(req)");
				//axi_read_data_c=	axi_read_data_v;
				//$display ("AXILITE2_seq:AAA RTC axi_read_data_c=%b CCC",axi_read_data_c);	
					
			//$display ("AXILITE2_seq: ------------Set the values to the zeros--------------");
				// Set the values to the zeros
				req = Data_Sequence_AXILITE::type_id::create("req"); 	
					// drugi korak - start  
					req.s00_axi_araddr_s=$realtobits(0.0);
					//$display ("AXILITE2_seq:  s00_axi_araddr_s %b",req.s00_axi_araddr_s);
												   req.s00_axi_arvalid_s=0;
												 //  $display ("AXILITE2_seq:  s00_axi_arvalid_s %b",req.s00_axi_arvalid_s);
								                   req.s00_axi_rready_s=0;
												//   $display ("AXILITE2_seq:  s00_axi_rready_s %b",req.s00_axi_rready_s);
												   
												   
												   
												   req.r_or_w=1'b0;
												//   $display ("AXILITE2_seq:  r_or_w %b",req.r_or_w);
												   req.set_to_zero_or_not=1'b1;
												//   $display ("AXILITE2_seq:  set_to_zero_or_not %b",req.set_to_zero_or_not);
												 //  axi_read_data_v=req.s00_axi_rdata_s;
												 //  $display ("AXILITE2_seq:AAA ZTC axi_read_data_v=%b AAA",axi_read_data_v);
					start_item(req);			  // $display ("AXILITE2_seq:AAA ZTC req.s00_axi_rdata_s=%b AAA",req.s00_axi_rdata_s);
					// cetvrti korak  
					finish_item(req);
					//axi_read_data_c=	axi_read_data_v;
				   // $display ("AXILITE2_seq:AAA CCC` axi_read_data_c=%b CCC",axi_read_data_c);
				
				
					
		//end
	$display ("AXILITE2_seq: ------------I HAVE FINISHED THE SEQUENCE--------------");
	`uvm_info("AXILITE2_seq","Sequence",UVM_HIGH)
	endtask
endclass
`endif
