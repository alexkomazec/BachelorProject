/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXILITE_drive.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXILITE_DRIVE_SV
`define AXILITE_DRIVE_SV

class AXILITE_drive extends uvm_driver#(Data_Sequence_AXILITE);

    `uvm_component_utils(AXILITE_drive)
	
	//Data_Sequence_AXILITE req;
	bit [31:0]axi_read_data_v=0;
    // The virtual interface used to drive and view HDL signals.
    virtual interface IP_ZOOM_AXI_v1_0_150x150_if vif;

    function new(string name = "AXILITE_drive", uvm_component parent = null);
        super.new(name,parent);
		`uvm_info(get_type_name(), "AXILITE_drive", UVM_LOW)
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
		if (!uvm_config_db#(virtual IP_ZOOM_AXI_v1_0_150x150_if)::get(this, "*", "IP_ZOOM_AXI_v1_0_150x150_if", vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
    endfunction : connect_phase

    task run_phase(uvm_phase phase);

			
			//$display ("AXILITE_drive: Wait for a positive edge of reset");
			@(posedge vif.s00_axi_lite_aresetn);
			forever begin
			//$display ("AXILITE_drive: prepare for seq_item_port.get_next_item");
            seq_item_port.get_next_item(req);
			$display ("AXILITE_drive: seq_item_port.get_next_item");
            `uvm_info(get_type_name(),
                        $sformatf("AXILITE_drive: Driver sending...\n%s", req.sprint()),
                        UVM_HIGH)
			//$display ("AXILITE_drive: prepare for drive_tr()");
            drive_tr();
			
            seq_item_port.item_done();
        end
		
    endtask : run_phase
	
	task drive_tr();
		
		//int n=0;
		

		@(negedge vif.s00_axi_lite_aclk);

		if(req.r_or_w==1'b1) begin
				if(req.set_to_zero_or_not==1'b0) begin
					//Set the values
					@(negedge vif.s00_axi_lite_aclk);
					//$display ("AXILITE_drive: !!!!!!!!!!!!!!!!WRITE_NOT_ZERO!!!!!!!!!!!!!!!!!!!!!");
					//$display ("AXILITE_drive: vif.r_or_w==%b and vif.set_to_zero_or_not==%b",req.r_or_w,req.set_to_zero_or_not);
					vif.s00_axi_lite_awaddr = req.s00_axi_awaddr_s;
					//$display ("AXILITE_drive: req.s00_axi_awaddr_s %b",req.s00_axi_awaddr_s);
					//$display ("AXILITE_drive: vif.s00_axi_lite_awaddr %b",vif.s00_axi_lite_awaddr);
					vif.s00_axi_lite_awvalid = req.s00_axi_awvalid_s;
					//$display ("AXILITE_drive: req.s00_axi_awvalid_s %b",req.s00_axi_awvalid_s);
					//$display ("AXILITE_drive: vif.s00_axi_lite_awvalid %b",vif.s00_axi_lite_awvalid);
					vif.s00_axi_lite_wdata = req.s00_axi_wdata_s;
					//$display ("AXILITE_drive: req.s00_axi_wdata_s %b",req.s00_axi_wdata_s);
					//$display ("AXILITE_drive: vif.s00_axi_lite_wdata %b",vif.s00_axi_lite_wdata);
					vif.s00_axi_lite_wvalid = req.s00_axi_wvalid_s;
					//$display ("AXILITE_drive: req.s00_axi_wvalid_s %b",req.s00_axi_wvalid_s);
					//$display ("AXILITE_drive: vif.s00_axi_lite_wvalid %b",vif.s00_axi_lite_wvalid);
					vif.s00_axi_lite_wstrb = req.s00_axi_wstrb_s;
					//$display ("AXILITE_drive: req.s00_axi_wstrb_s %b",req.s00_axi_wstrb_s);
					//$display ("AXILITE_drive: vif.s00_axi_lite_wstrb %b",vif.s00_axi_lite_wstrb);
					vif.s00_axi_lite_bready = req.s00_axi_bready_s;
					//$display ("AXILITE_drive: req.s00_axi_bready_s %b",req.s00_axi_bready_s);
				//	$display ("AXILITE_drive: vif.s00_axi_lite_bready %b",vif.s00_axi_lite_bready);
					wait(vif.s00_axi_lite_awready ==1'b1);
					wait(vif.s00_axi_lite_awready ==1'b0);
				    //@(negedge vif.s00_axi_lite_aclk);
				end
				
				else begin
					//$display ("AXILITE_drive: req.r_or_w==1'b1 and req.set_to_zero_or_not==1'b1 ");
					//Set the zeros
					//$display ("AXILITE_drive: !!!!!!!!!!!!!!!!WRITE_ZERO!!!!!!!!!!!!!!!!!!!!!");
					//Respecting the protocol, please set mentioned values to 0.

					vif.s00_axi_lite_awaddr = req.s00_axi_awaddr_s;
					//$display ("AXILITE_drive: req.s00_axi_awaddr_s %b",req.s00_axi_awaddr_s);
					//$display ("AXILITE_drive: vif.s00_axi_lite_awaddr %b",vif.s00_axi_lite_awaddr);
					vif.s00_axi_lite_awvalid = req.s00_axi_awvalid_s;
				///	$display ("AXILITE_drive: req.s00_axi_awvalid_s %b",req.s00_axi_awvalid_s);
				//	$display ("AXILITE_drive: vif.s00_axi_lite_awvalid %b",vif.s00_axi_lite_awvalid);
					vif.s00_axi_lite_wdata = req.s00_axi_wdata_s;
				//	$display ("AXILITE_drive: req.s00_axi_wdata_s %b",req.s00_axi_wdata_s);
				//	$display ("AXILITE_drive: vif.s00_axi_lite_wdata %b",vif.s00_axi_lite_wdata);
					vif.s00_axi_lite_wvalid = req.s00_axi_wvalid_s;
				//	$display ("AXILITE_drive: req.s00_axi_wvalid_s %b",req.s00_axi_wvalid_s);
				//	$display ("AXILITE_drive: vif.s00_axi_lite_wvalid %b",vif.s00_axi_lite_wvalid);
					vif.s00_axi_lite_wstrb = req.s00_axi_wstrb_s;
				//	$display ("AXILITE_drive: req.s00_axi_wstrb_s %b",req.s00_axi_wstrb_s);
				//	$display ("AXILITE_drive: vif.s00_axi_lite_wstrb %b",vif.s00_axi_lite_wstrb);
					
					wait(vif.s00_axi_lite_bvalid==1'b0)
					@(negedge vif.s00_axi_lite_aclk);
					//vif.s00_axi_lite_bvalid=req.s00_axi_bvalid_s;
					//@(negedge vif.s00_axi_lite_aclk);
					vif.s00_axi_lite_bready = req.s00_axi_bready_s;
				//	$display ("AXILITE_drive: req.s00_axi_bready_s %b",req.s00_axi_bready_s);
				//	$display ("AXILITE_drive: vif.s00_axi_lite_bready %b",vif.s00_axi_lite_bready);
					@(negedge vif.s00_axi_lite_aclk);
					
					
					//Respecting the protocol, please wait 5 cycles.
					for (int i = 0; i < 5; i++) begin
						@(negedge vif.s00_axi_lite_aclk);
			//			$display ("AXILITE_drive: Please wait! It's %d cycle",i);
					end
				end 
		end

		else begin
			//while(n!=1) begin
				
				if(req.set_to_zero_or_not==1'b0) begin
					$display ("AXILITE_drive: req.r_or_w==1'b0 and req.set_to_zero_or_not==1'b0 ");
					$display ("AXILITE_drive: !!!!!!!!!!!!!!!!READ_NOT_ZERO!!!!!!!!!!!!!!!!!!!!!");
					//Read the values
					@(negedge vif.s00_axi_lite_aclk);
					vif.s00_axi_lite_araddr = req.s00_axi_araddr_s;
					$display ("AXILITE_drive: req.s00_axi_araddr_s %b",req.s00_axi_araddr_s);
					$display ("AXILITE_drive: vif.s00_axi_lite_araddr %b",vif.s00_axi_lite_araddr);
					vif.s00_axi_lite_arvalid = req.s00_axi_arvalid_s;
					$display ("AXILITE_drive: req.s00_axi_arvalid_s %b",req.s00_axi_arvalid_s);
					$display ("AXILITE_drive: vif.s00_axi_lite_arvalid %b",vif.s00_axi_lite_arvalid);
					vif.s00_axi_lite_rready = req.s00_axi_rready_s;
					$display ("AXILITE_drive: req.s00_axi_rready_s %b",req.s00_axi_rready_s);
					$display ("AXILITE_drive: vif.s00_axi_lite_rready %b",vif.s00_axi_lite_rready);
					//Set the zeros
					wait(vif.s00_axi_lite_arready==1'b1);
					//req.s00_axi_rdata_s = vif.s00_axi_lite_rdata;
					axi_read_data_v  = vif.s00_axi_lite_rdata;
					$display ("AXILITE_drive: vif.s00_axi_lite_rdata %b",vif.s00_axi_lite_rdata);
					$display ("AXILITE_drive: req.s00_axi_rdata_s %b",req.s00_axi_rdata_s);
					
					wait(vif.s00_axi_lite_arready==1'b0);
					//@(negedge vif.s00_axi_lite_aclk);
					
					//req.n=1'b1;
					//$display ("AXILITE_drive: req.n %b",req.n);
				end
				
				else begin
					$display ("AXILITE_drive: req.r_or_w==1'b0 and req.set_to_zero_or_not==1'b1 ");
					$display ("AXILITE_drive: !!!!!!!!!!!!!!!!READ_ZERO!!!!!!!!!!!!!!!!!!!!!");
					
					vif.s00_axi_lite_araddr = req.s00_axi_araddr_s;
					$display ("AXILITE_drive: req.s00_axi_araddr_s %b",req.s00_axi_araddr_s);
					$display ("AXILITE_drive: vif.s00_axi_lite_araddr %b",vif.s00_axi_lite_araddr);
					vif.s00_axi_lite_arvalid = req.s00_axi_arvalid_s;
					$display ("AXILITE_drive: req.s00_axi_arvalid_s %b",req.s00_axi_arvalid_s);
					$display ("AXILITE_drive: vif.s00_axi_lite_arvalid %b",vif.s00_axi_lite_arvalid);
					vif.s00_axi_lite_rready = req.s00_axi_rready_s;
					$display ("AXILITE_drive: req.s00_axi_rready_s %b",req.s00_axi_rready_s);
					$display ("AXILITE_drive: vif.s00_axi_lite_rready %b",vif.s00_axi_lite_rready);
					$display ("--------------!!!!!!!!!!!!!!!!!!!!!!---------------------");
					req.s00_axi_rdata_s = vif.s00_axi_lite_rdata;
					$display ("AXILITE_drive: req.s00_axi_rdata_s %b",req.s00_axi_rdata_s);
					$display ("AXILITE_drive: vif.s00_axi_lite_rdata %b",vif.s00_axi_lite_rdata);
					
					$display ("--------------??????????????????????????????---------------------");
					
								while(axi_read_data_v[0]!==1'b1) begin
									$display ("AXILITE_drive: req.r_or_w==1'b0 and req.set_to_zero_or_not==1'b0 ");
									$display ("AXILITE_drive: !!!!!!!!!!!!!!!!READ_NOT_ZERO!!!!!!!!!!!!!!!!!!!!!");
								//Read the values
								@(negedge vif.s00_axi_lite_aclk);
								
								vif.s00_axi_lite_araddr = 12;
								$display ("AXILITE_drive: vif.s00_axi_lite_araddr %b",vif.s00_axi_lite_araddr);
								vif.s00_axi_lite_arvalid = 1;
								$display ("AXILITE_drive: vif.s00_axi_lite_arvalid %b",vif.s00_axi_lite_arvalid);
								vif.s00_axi_lite_rready = 1;
								$display ("AXILITE_drive: vif.s00_axi_lite_rready %b",vif.s00_axi_lite_rready);
								//Set the zeros
								wait(vif.s00_axi_lite_arready==1'b1);
								//req.s00_axi_rdata_s = vif.s00_axi_lite_rdata;
								axi_read_data_v  = vif.s00_axi_lite_rdata;
								$display ("AXILITE_drive: vif.s00_axi_lite_rdata %b",vif.s00_axi_lite_rdata);
								$display ("AXILITE_drive: axi_read_data_v %b",axi_read_data_v);
								
								wait(vif.s00_axi_lite_arready==1'b0);
								
								vif.s00_axi_lite_araddr = req.s00_axi_araddr_s;
								
								$display ("AXILITE_drive: vif.s00_axi_lite_araddr %b",vif.s00_axi_lite_araddr);
								vif.s00_axi_lite_arvalid = 0;
								$display ("AXILITE_drive: vif.s00_axi_lite_arvalid %b",vif.s00_axi_lite_arvalid);
								vif.s00_axi_lite_rready = 0;
								$display ("AXILITE_drive: vif.s00_axi_lite_rready %b",vif.s00_axi_lite_rready);
								req.s00_axi_rdata_s = 0;
								$display ("AXILITE_drive: vif.s00_axi_lite_rdata %b",vif.s00_axi_lite_rdata);
								
								end
				end 
					
			$display ("--------------************************************---------------------");
		end
		
		$display ("AXILITE_drive: EXIT!");
	endtask : drive_tr

endclass : AXILITE_drive

`endif

