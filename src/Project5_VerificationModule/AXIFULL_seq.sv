`ifndef AXIFULL_SEQ_SV
`define AXIFULL_SEQ_SV

class AXIFULL_seq extends AXIFULL_base_seq;

	`uvm_object_utils (AXIFULL_seq)
	`uvm_declare_p_sequencer(AXI2_SQR)
	int one;
	bit [7:0] one_line;
	bit [0:22499] [7:0] MEM_R_CONTENT_c ;
	integer outfile1; //file descriptor
	int i = 0;
	const real MEMORY_R_OFFSET_C = 0;
	const real MEMORY_C_OFFSET_C = 524288;
	int data_counter=1;
	
	function new (string name="AXIFULL_seq");
		super.new(name);
		//req=Data_Sequence_AXIFULL::type_id::create("req");
	endfunction;
	
	virtual task body();
		Data_Sequence_AXIFULL req;
		
	
		outfile1=$fopen("FirstDim.txt","r");   //"r" means reading and "w" means writing
		//$display ("AXIFULL_seq: Prepare for reading from FirstDim.txt");
		//read line by line.
		while (! $feof(outfile1)) begin //read until an "end of file" is reached.
			
			$fscanf(outfile1,"%b\n",one_line); //scan each line and get the value as an hexadecimal, use %b for binary and %d for decimal.
			//$display ("AXIFULL_seq:one_line= %b",one_line);
			#10; //wait some time as needed.
				
			for(int j=0;j<8;j++) begin
				MEM_R_CONTENT_c[i][j]=one_line[j];
			end	
			
			//$display ("AXIFULL_seq:MEM_R_CONTENT_c[%d\t][%b\t]",i,MEM_R_CONTENT_c[i]);
			i++;
		end 
		//once reading and writing is finished, close the file.
		$fclose(outfile1);

		//begin	
		
				
				//-------------------------------------------------------------------------
				//---------Load the element values for matrix R into the Zoom2 core--------
                //-------------------------------------------------------------------------
				//$display ("AXIFULL_seq:Load the element values for matrix R into the Zoom2 core");
				
				//$display ("AXIFULL_seq:Set relevant values to fields and prepare for loading");
				// prvi korak  kreiranje transakcije   
				req = Data_Sequence_AXIFULL::type_id::create("req"); 	
				// drugi korak - start  
				req.s01_axi_araddr_s=$realtobits(0.0);
				req.s01_axi_awaddr_s=00000000000000000000;	
				//$display ("AXIFULL_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_awaddr_s);
				req.s01_axi_awlen_s=15'b101011111100011;
				//$display ("AXIFULL_seq: req.s01_axi_awlen_s=%d",req.s01_axi_awlen_s);
				req.s01_axi_awsize_s=3'b010;
				//$display ("AXIFULL_seq: req.s01_axi_awsize_s=%b",req.s01_axi_awsize_s);
				req.s01_axi_awburst_s=2'b01;
				//$display ("AXIFULL_seq: req.s01_axi_awburst_s=%b",req.s01_axi_awburst_s);
				req.s01_axi_awvalid_s=1'b1;
				//$display ("AXIFULL_seq: req.s01_axi_awvalid_s=%b",req.s01_axi_awvalid_s);
				req.r_or_w=1'b1;
				//$display ("AXIFULL_seq: req.r_or_w=%b",req.r_or_w);
				req.set_to_zero_or_not=1'b0;
				//$display ("AXIFULL_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
				req.first_or_middle_or_last_wdata=5;//x=5 x!=0,1,2 !!!
				//$display ("AXIFULL_seq: req.first_or_middle_or_last_wdata=%d",req.first_or_middle_or_last_wdata);
				start_item(req);
				//$display ("AXIFULL_seq:start_item(req)");
				// cetvrti korak  
				finish_item(req);
				//$display ("AXIFULL_seq:finish_item(req)");
				
				
				
				
			
				//UPIS PRVOG PODATKA NA ADRESU 0
				//$display ("AXIFULL_seq: UPIS PRVOG PODATKA NA ADRESU 0");
				req.s01_axi_wdata_s=MEM_R_CONTENT_c[0];
			//	$display ("AXIFULL_seq: req.s01_axi_wdata_s=%b",req.s01_axi_wdata_s);
				req.s01_axi_wvalid_s=1'b1;
				//$display ("AXIFULL_seq: req.s01_axi_wvalid_s=%b",req.s01_axi_wvalid_s);
				req.s01_axi_wstrb_s=4'b1111;
				//$display ("AXIFULL_seq: req.s01_axi_wstrb_s=%b",req.s01_axi_wstrb_s);
				req.s01_axi_wlast_s=1'b0;
				//$display ("AXIFULL_seq: req.s01_axi_wlast_s=%b",req.s01_axi_wlast_s);
				req.s01_axi_bready_s=1'b1;
				//$display ("AXIFULL_seq: req.s01_axi_bready_s=%b",req.s01_axi_bready_s);
				req.set_to_zero_or_not=1'b0;
				//$display ("AXIFULL_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
				req.first_or_middle_or_last_wdata=0;
				//$display ("AXIFULL_seq: req.first_or_middle_or_last_wdata=%d",req.first_or_middle_or_last_wdata);
				req.r_or_w=1'b1;
				//$display ("AXIFULL_seq: req.r_or_w=%b",req.r_or_w);
				start_item(req);
			//	$display ("AXIFULL_seq:start_item(req)");
				// cetvrti korak  
				finish_item(req);
				//$display ("AXIFULL_seq:finish_item(req)");
				
				//UPIS OD DRUGOG PA SVE DO PREDPOSLEDNJEG POODATKA
			//	$display ("AXIFULL_seq: UPIS OD DRUGOG PA SVE DO PREDPOSLEDNJEG POODATKA");

				
				for (int i = 1; i <= 22498; i++) begin
						$display ("AXIFULL_seq:aaaaaaaaaaaaa Please wait! It's %d cycle",i);
						// prvi korak  kreiranje transakcije 
					req = Data_Sequence_AXIFULL::type_id::create("req"); 	
					// drugi korak - start  
					
					req.s01_axi_wdata_s=MEM_R_CONTENT_c[i];
					//$display ("AXIFULL_seq: MEM_R_CONTENT_c=[%d]=%b ",i,req.s01_axi_wdata_s);
					//$display ("AXIFULL_seq:***ADRESA***= %d",req.s01_axi_awaddr_s);
					
					req.s01_axi_wvalid_s=1'b1;
				//	$display ("AXIFULL_seq: req.s01_axi_wvalid_s=%b",req.s01_axi_wvalid_s);
					req.s01_axi_wstrb_s=4'b1111;
					//$display ("AXIFULL_seq: req.s01_axi_wstrb_s=%b",req.s01_axi_wstrb_s);
					req.s01_axi_wlast_s=1'b0;
					//$display ("AXIFULL_seq: req.s01_axi_wlast_s=%b",req.s01_axi_wlast_s);
					req.s01_axi_bready_s=1'b1;
				  //  $display ("AXIFULL_seq: req.s01_axi_bready_s=%b",req.s01_axi_bready_s);
					
					
					req.set_to_zero_or_not=1'b0;
					//$display ("AXIFULL_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
					req.first_or_middle_or_last_wdata=1;
				//	$display ("AXIFULL_seq: req.first_or_middle_or_last_wdata=%d",req.first_or_middle_or_last_wdata);
					req.r_or_w=1'b1;
					//$display ("AXIFULL_seq: req.r_or_w=%b",req.r_or_w);
	
					
					start_item(req);
				//	$display ("AXIFULL_seq: start_item(req)");
					
					// cetvrti korak  
					finish_item(req);
					//$display ("AXIFULL_seq: finish_item(req)");
	
				end
			
				
				//$display ("AXIFULL_seq:Load the last value");
				
				//UPIS POSLEDNJEG PODATKA
				//$display ("AXIFULL_seq: UPIS POSLEDNJEG PODATKA");
				// prvi korak  kreiranje transakcije 
					req = Data_Sequence_AXIFULL::type_id::create("req"); 	
					//drugi korak - start  
					req.s01_axi_wdata_s=MEM_R_CONTENT_c[22499];
					//$display ("AXIFULL_seq: req.s01_axi_wdata_s=%b",req.s01_axi_wdata_s);
					req.s01_axi_wvalid_s=1'b1;
					//$display ("AXIFULL_seq: req.s01_axi_wvalid_s=%b",req.s01_axi_wvalid_s);
					req.s01_axi_wstrb_s=4'b1111;
					//$display ("AXIFULL_seq: req.s01_axi_wstrb_s=%b",req.s01_axi_wstrb_s);
					req.s01_axi_wlast_s=1'b1;
					//$display ("AXIFULL_seq: req.s01_axi_wlast_s=%b",req.s01_axi_wlast_s);
					req.s01_axi_bready_s=1'b1;
					//$display ("AXIFULL_seq: req.s01_axi_bready_s=%b",req.s01_axi_bready_s);
					
					
					req.first_or_middle_or_last_wdata=2;
					//$display ("AXIFULL_seq: req.first_or_middle_or_last_wdata=%d",req.first_or_middle_or_last_wdata);
					req.r_or_w=1'b1;
					//$display ("AXIFULL_seq: req.r_or_w=%b",req.r_or_w);
					req.set_to_zero_or_not=1'b0;
					//$display ("AXIFULL_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);

					start_item(req);
					//$display ("AXIFULL_seq: start_item(req)");
					// cetvrti korak  
					finish_item(req);
					//$display ("AXIFULL_seq: finish_item(req)");

				//$display ("AXIFULL_seq:Set values to zero");
				
				//UPIS NULA U SVE REGISTRE 
				//$display ("AXIFULL_seq: UPIS NULA U SVE REGISTRE ");
				// prvi korak  kreiranje transakcije 
					req = Data_Sequence_AXIFULL::type_id::create("req"); 	
					// drugi korak - start  
					req.s01_axi_wdata_s=8'b00000000;
				//	$display ("AXIFULL_seq: req.s01_axi_wdata_s=%b",req.s01_axi_wdata_s);
					req.s01_axi_wvalid_s=1'b0;
					//$display ("AXIFULL_seq: req.s01_axi_wvalid_s=%b",req.s01_axi_wvalid_s);
					req.s01_axi_wstrb_s=4'b0000;
					//$display ("AXIFULL_seq: req.s01_axi_wstrb_s=%b",req.s01_axi_wstrb_s);
					req.s01_axi_wlast_s=1'b0;
					//$display ("AXIFULL_seq: req.s01_axi_wlast_s=%b",req.s01_axi_wlast_s);
					req.s01_axi_awaddr_s=20'b00000000000000000000;
					//$display ("AXIFULL_seq: req.s01_axi_awaddr_s=%b",req.s01_axi_awaddr_s);
					req.s01_axi_awlen_s=15'b000000000000000;
					//$display ("AXIFULL_seq: req.s01_axi_awlen_s=%b",req.s01_axi_awlen_s);
					req.s01_axi_awburst_s=2'b00;
					//$display ("AXIFULL_seq: req.s01_axi_awburst_s=%b",req.s01_axi_awburst_s);
					req.s01_axi_awvalid_s=1'b0;
					//$display ("AXIFULL_seq: req.s01_axi_awvalid_s=%b",req.s01_axi_awvalid_s);
					req.s01_axi_bready_s=1'b1;
					//$display ("AXIFULL_seq: req.s01_axi_bready_s=%b",req.s01_axi_bready_s);
					
					
					req.r_or_w=1'b1;
				//	$display ("AXIFULL_seq: req.r_or_w=%b",req.r_or_w);
					req.set_to_zero_or_not=1'b1;
					//$display ("AXIFULL_seq: req.set_to_zero_or_not=%b",req.set_to_zero_or_not);
					start_item(req);
					//$display ("AXIFULL_seq: start_item(req)");
					// cetvrti korak  
					finish_item(req);
					//$display ("AXIFULL_seq: finish_item(req)");

					
	//print();
	//`uvm_info("AXIFULL_seq","Sequence",UVM_HIGH)
	
	endtask
endclass
`endif
