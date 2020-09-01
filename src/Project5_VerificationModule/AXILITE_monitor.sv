
`ifndef AXILITE_MONITOR_SV
`define AXILITE_MONITOR_SV

class AXILITE_monitor extends uvm_monitor;

 

    uvm_analysis_port #(Data_Sequence_AXILITE) item_collected_port;

    `uvm_component_utils(AXILITE_monitor)
  

    // The virtual interface used to drive and view HDL signals.
    virtual interface IP_ZOOM_AXI_v1_0_150x150_if vif;

    // current transaction
    Data_Sequence_AXILITE current_transaction;


    function new(string name = "AXILITE_monitor", uvm_component parent = null);
        super.new(name,parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!uvm_config_db#(virtual IP_ZOOM_AXI_v1_0_150x150_if)::get(this, "*", "IP_ZOOM_AXI_v1_0_150x150_if", vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
    endfunction : connect_phase

   task run_phase( uvm_phase phase );
		 forever begin
		 
		 current_transaction = Data_Sequence_AXILITE::type_id::create("current_transaction", this);
		  @(posedge vif.s00_axi_lite_aclk)

		 begin
			
			if (vif.s00_axi_lite_awready ==1'b1) begin
			//	$display ("AXILITE_monitor: !!!!!!!!!!!!!!!!!!WRITING!!!!!!!!!!!!!!!!!!!!!! ");
			//	$display ("AXILITE_monitor: Current transaction (Writing fields) is bulking ");

		  current_transaction.s00_axi_awaddr_s = vif.s00_axi_lite_awaddr;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_awaddr %b",vif.s00_axi_lite_awaddr);

			current_transaction.s00_axi_awvalid_s = vif.s00_axi_lite_awvalid;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_awvalid %b",vif.s00_axi_lite_awvalid);

		current_transaction.s00_axi_wdata_s = vif.s00_axi_lite_wdata;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_wdata %b",vif.s00_axi_lite_wdata);

			current_transaction.s00_axi_wvalid_s = vif.s00_axi_lite_wvalid;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_wvalid %b",vif.s00_axi_lite_wvalid);
				
			current_transaction.s00_axi_wstrb_s = vif.s00_axi_lite_wstrb;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_wstrb %b",vif.s00_axi_lite_wstrb);

			current_transaction.s00_axi_bready_s = vif.s00_axi_lite_bready;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_bready %b",vif.s00_axi_lite_bready);

				item_collected_port.write(current_transaction);
				//$display ("AXILITE_monitor: Current transaction has sent");
		end
			
		if(vif.s00_axi_lite_arready ==1'b1) begin
				//$display ("AXILITE_monitor: !!!!!!!!!!!!READING!!!!!!!!!! ");
				//$display ("AXILITE_monitor: Current transaction (Reading fields) is bulking ");

			current_transaction.s00_axi_araddr_s = vif.s00_axi_lite_araddr;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_araddr %b",vif.s00_axi_lite_araddr);

		   current_transaction.s00_axi_arvalid_s = vif.s00_axi_lite_arvalid;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_arvalid %b",vif.s00_axi_lite_arvalid);

		   current_transaction.s00_axi_rready_s = vif.s00_axi_lite_rready;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_rready %b",vif.s00_axi_lite_rready);

			current_transaction.s00_axi_rdata_s = vif.s00_axi_lite_rdata;
				//$display ("AXILITE_monitor: vif.s00_axi_lite_rdata %b",vif.s00_axi_lite_rdata);	

				item_collected_port.write(current_transaction);
				//$display ("AXILITE_monitor: Current transaction has sent");
		end

		else begin
				$display ("AXILITE_monitor: No informations to send");
		end
						
			end
		 end
	endtask

endclass : AXILITE_monitor

`endif

