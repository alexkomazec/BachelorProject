`ifndef Data_Sequence_AXILITE_SV
`define Data_Sequence_AXILITE_SV

class Data_Sequence_AXILITE extends uvm_sequence_item;
	
  
 //Aditional controlling sequence-sequencer-driver handshake
	bit r_or_w; //read=0 or wite=1
    bit set_to_zero_or_not;//set_to_zero=1 is a second part of AXILITE portocol where
                          //we need to set all values to the zeros.     
	bit n; // If 1 ,leave the AXILITE2 reading loop!


	/*----------------------------------------
	-----AXI_LITE WRITING stimulus bits------
    ----------------------------------------*/
	  
	/*1*/bit [3:0] s00_axi_awaddr_s;
	/*2*/bit s00_axi_awvalid_s;
	/*3*/bit [31:0] s00_axi_wdata_s;
	/*4*/bit s00_axi_wvalid_s;
	/*5*/bit [3:0] s00_axi_wstrb_s;
    /*6*/bit s00_axi_bready_s;
    /*7*/bit s00_axi_awready_s;
	/*8*/bit s00_axi_bvalid_s;
    
	
    /*----------------------------------------
	-----AXI_LITE READING stimulus bits------
    ----------------------------------------*/
	  
	/*8*/bit [3:0] s00_axi_araddr_s;
    /*9*/bit s00_axi_arvalid_s;
    /*10*/bit s00_axi_rready_s;
	/*11*/bit s00_axi_arready_s;
	/*11*/bit [31:0]s00_axi_rdata_s;
    
	
	/*----------------------------------------
	-----AXI_LITE RESET AND SYNC bits------
    ----------------------------------------*/
	
	/*12*/ bit s00_axi_lite_aclk_s;
	/*13*/bit s00_axi_aresetn_s;
				
	/*----------------------------------------
	-----Global reset. This thing initializes DUT and its sub memory------
    ----------------------------------------*/			
	/*14*/  bit reset_s;
	
	// UVM factory registration
	 `uvm_object_utils_begin(Data_Sequence_AXILITE)
	
		 `uvm_field_int(r_or_w, UVM_DEFAULT)
		 `uvm_field_int(set_to_zero_or_not, UVM_DEFAULT)
		 `uvm_field_int(n, UVM_DEFAULT)

		 `uvm_field_int(s00_axi_awaddr_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_awvalid_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_wdata_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_wvalid_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_wstrb_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_bready_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_awready_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_bvalid_s, UVM_DEFAULT)
		 
		 `uvm_field_int(s00_axi_araddr_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_arvalid_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_rready_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_arready_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_rdata_s, UVM_DEFAULT)
			
		 `uvm_field_int(s00_axi_lite_aclk_s, UVM_DEFAULT)
		 `uvm_field_int(s00_axi_aresetn_s, UVM_DEFAULT)
		 
		 `uvm_field_int(reset_s, UVM_DEFAULT)
	 
		 `uvm_object_utils_end
		 
		 function bit print();
			//`uvm_info(get_type_name(), "Data_Sequence_AXI", UVM_LOW)
			//`uvm_info(get_type_name(), $sformatf("Data ...\n%s", this.sprint()),UVM_LOW)
		endfunction : print		
		// constructor
		function new(string name = "Data_Sequence_AXILITE");
			super.new(name);
			//`uvm_info(get_type_name(),$sformatf("Printing Data_Sequence_AXILITE\n %s",this.sprint()),UVM_LOW)
		endfunction
	
endclass
`endif