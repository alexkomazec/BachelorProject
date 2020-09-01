
`ifndef AXIFULL_MONITOR_SV
`define AXIFULL_MONITOR_SV

class AXIFULL_monitor extends uvm_monitor;

	bit [0:89999] [7:0] MEM_Rnew_CONTENT_c ;


    uvm_analysis_port #(Data_Sequence_AXIFULL) item_collected_port;
	int counter=0;

	
	`uvm_component_utils_begin(AXIFULL_monitor)
		`uvm_field_int(MEM_Rnew_CONTENT_c, UVM_DEFAULT)
	`uvm_component_utils_end

    // The virtual interface used to drive and view HDL signals.
    virtual interface IP_ZOOM_AXI_v1_0_150x150_if vif;

    // current transaction
    Data_Sequence_AXIFULL current_transaction;


    function new(string name = "AXIFULL_monitor", uvm_component parent = null);
        super.new(name,parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
        if (!uvm_config_db#(virtual IP_ZOOM_AXI_v1_0_150x150_if)::get(this, "*", "IP_ZOOM_AXI_v1_0_150x150_if", vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
    endfunction : connect_phase

		
	task run_phase( uvm_phase phase );
		
	
		`uvm_info("AXIFULL_monitor","Starting monitor",UVM_HIGH)
	
		forever begin
		 
		 current_transaction = Data_Sequence_AXIFULL::type_id::create("current_transaction", this);
		 
		 @(posedge vif.s01_axi_full_aclk);
			begin
				if(vif.s01_axi_full_rready==1'b1 && vif.s01_axi_full_arready==1'b0 ) begin
				//SENDING THE VALUES
				$display ("AXIFULL_monitor: vif.s01_axi_full_rready= %d",vif.s01_axi_full_rready);
				$display ("AXIFULL_monitor: vif.s01_axi_full_arready=%d",vif.s01_axi_full_arready);
				counter++;
				$display ("AXIFULL_monitor: counter",counter);
					 
					if(counter>=2)begin
						$display ("AXIFULL_monitor: SENDING THE VALUES");
						$display ("AXIFULL_monitor: Current transaction is bulking");
						
						$display ("AXIFULL_monitor: vif.rnew_axi_data_port %d",vif.rnew_axi_data_port);
						wait(vif.s01_axi_full_rvalid ==1'b1);
						current_transaction.rnew_axi_data_port = vif.rnew_axi_data_port;
						wait(vif.s01_axi_full_rvalid ==1'b0);
						@(negedge vif.s01_axi_full_aclk);

						$display("Printing from AXIFULL_monitor\n");
					end
						/*	//CHECKING THE VALUES
						asrt_rnew_axi_data_port_eq_MEM_Rnew_CONTENT_c : assert (vif.rnew_axi_data_port == MEM_Rnew_CONTENT_c[counter]) 
						
						`uvm_info(get_type_name(), "Check succesfull: rnew_axi_data_port == MEM_Rnew_CONTENT_c", UVM_HIGH) 
						else  begin 
						`uvm_error(get_type_name(), $sformatf("Observed rnew_axi_data_port and MEM_Rnew_CONTENT_c mismatch: rnew_axi_data_port = %0d, MEM_Rnew_CONTENT_c = %0d", vif.rnew_axi_data_port, MEM_Rnew_CONTENT_c[counter])) 
						end
			
						item_collected_port.write(current_transaction);
						$display ("AXIFULL_monitor: Current transaction has sent");*/
				end
					
				//$display("AXIFULL_monitor: There is no transaction\n");
			end
		end
	endtask

endclass : AXIFULL_monitor

`endif

