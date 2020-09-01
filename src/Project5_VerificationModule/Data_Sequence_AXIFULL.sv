`ifndef Data_Sequence_AXIFULL_SV
`define Data_Sequence_AXIFULL_SV

class Data_Sequence_AXIFULL extends uvm_sequence_item;
 

	


		bit r_or_w;
		bit set_to_zero_or_not;
		int first_or_middle_or_last_wdata;//0,1,2 Because, we have 3 different stages of writing datas

	  
		 
		  /*----------------------------------------
	    -----AXI_FULL WRITING stimulus bits------
		----------------------------------------*/
		bit s01_axi_aresetn_s;
		bit [19:0] s01_axi_awaddr_s;
		bit [14:0] s01_axi_awlen_s;
		bit [2:0]  s01_axi_awsize_s;
		bit [1:0]  s01_axi_awburst_s;
		bit s01_axi_awvalid_s;
		bit s01_axi_awready_s;
		rand bit [31:0] s01_axi_wdata_s;// SKORO PROMENJENO	
		bit s01_axi_wvalid_s;
		bit [3:0]  s01_axi_wstrb_s;
		bit s01_axi_wlast_s;
		bit s01_axi_bready_s;
		bit s01_axi_wready_s;
		bit s01_axi_bvalid_s;
		  /*----------------------------------------
	 -----AXI_FULL READING stimulus bits------
     ----------------------------------------*/
		bit [19:0] s01_axi_araddr_s;
		bit [17 - 1 : 0]s01_axi_arlen_s;
		bit [2:0] s01_axi_arsize_s;
		bit [1:0] s01_axi_arburst_s;
		bit s01_axi_arvalid_s;
		bit s01_axi_rready_s;
		bit s01_axi_arready_s;
		bit [7:0] rnew_axi_data_s;
		bit s01_axi_rvalid_s;
												   
	  
	  //AXI_FULL sync and reset bits
	   bit s01_axi_full_aclk_s;
	   bit s01_axi_full_aresetn_s;
	 
	   rand bit [7:0] rnew_axi_data_port;
	  
 // UVM factory registration
 `uvm_object_utils_begin(Data_Sequence_AXIFULL)

	`uvm_field_int(r_or_w, UVM_DEFAULT)
	`uvm_field_int(set_to_zero_or_not, UVM_DEFAULT)
	`uvm_field_int(first_or_middle_or_last_wdata, UVM_DEFAULT)
	
 
	 `uvm_field_int(s01_axi_rvalid_s, UVM_DEFAULT)
	 `uvm_field_int(rnew_axi_data_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_arready_s, UVM_DEFAULT)
     `uvm_field_int(s01_axi_bvalid_s, UVM_DEFAULT)
     `uvm_field_int(s01_axi_wready_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_awready_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_aresetn_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_wvalid_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_wlast_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_bready_s, UVM_DEFAULT)
	
	 
	 `uvm_field_int(s01_axi_awaddr_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_awlen_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_awsize_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_awburst_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_wstrb_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_awvalid_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_wdata_s, UVM_DEFAULT)
	 
	 `uvm_field_int(s01_axi_arlen_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_arvalid_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_rready_s, UVM_DEFAULT)
	 
	 `uvm_field_int(s01_axi_araddr_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_arsize_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_arburst_s, UVM_DEFAULT)
	 `uvm_field_int(rnew_axi_data_port, UVM_DEFAULT)
	 
	 `uvm_field_int(s01_axi_full_aclk_s, UVM_DEFAULT)
	 `uvm_field_int(s01_axi_full_aresetn_s, UVM_DEFAULT)
 
 `uvm_object_utils_end
 
	 // constructor
	function new(string name = "Data_Sequence_AXIFULL");
	super.new(name);
	 endfunction

	function bit print();
         `uvm_info(get_type_name(), "Sequence Item", UVM_LOW)
		 `uvm_info(get_type_name(), $sformatf("Data ...\n%s", this.sprint()), UVM_LOW)
	endfunction : print
endclass

`endif