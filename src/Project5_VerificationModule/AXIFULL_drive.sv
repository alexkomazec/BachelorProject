/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXIFULL_drive.sv

    DESCRIPTION     
              
*******************************************************************************/

`ifndef AXIFULL_DRIVE
`define AXIFULL_DRIVE

class AXIFULL_drive extends uvm_driver#(Data_Sequence_AXIFULL);

    `uvm_component_utils(AXIFULL_drive)
	
	//Data_Sequence_AXIFULL req;
	//int counter=0;
	//int brojac=1;
	//bit [1:3] [7:0] proba ;
    // The virtual interface used to drive and view HDL signals.
    virtual interface IP_ZOOM_AXI_v1_0_150x150_if vif;

    function new(string name = "AXIFULL_drive", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!uvm_config_db#(virtual IP_ZOOM_AXI_v1_0_150x150_if)::get(this, "*", "IP_ZOOM_AXI_v1_0_150x150_if", vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
    endfunction : connect_phase

    task run_phase(uvm_phase phase);
		$display ("AXIFULL_drive: Wait for a positive edge of reset");
		@(posedge vif.s01_axi_full_aresetn);
		$display ("AXIFULL_drive: positive edge of vif.s01_axi_full_aresetn ");
        forever begin
            seq_item_port.get_next_item(req);
			$display ("AXIFULL_drive:  seq_item_port.get_next_item(req)");	
            `uvm_info(get_type_name(),
                        $sformatf("AXIFULL_drive,Driver sending...\n%s", req.sprint()),
                        UVM_HIGH)
			$display ("AXIFULL_drive: Prepare for drive_tr()");			
            drive_tr();
			
            seq_item_port.item_done();
			$display ("AXIFULL_drive: seq_item_port.item_done()");
        end
    endtask : run_phase
	
	task drive_tr();
		
//@(negedge vif.s01_axi_full_aclk);
		//WRITE!
		if(req.r_or_w==1'b1) begin
				if(req.set_to_zero_or_not==1'b0) begin
					//Set the values
				$display ("AXIFULL_drive: line 60 : req.r_or_w==1'b1 and req.set_to_zero_or_not==1'b0 ");
					
					
					if(req.first_or_middle_or_last_wdata==5) begin	
				//-------------------------------------------------------------------------
				//---------Load starting values for a few fields--------
                //-------------------------------------------------------------------------
						@(negedge vif.s01_axi_full_aclk);
							//$display ("AXIFULL_drive: req.first_or_middle_or_last_wdata==5");
						/*1*/vif.s01_axi_full_awaddr = req.s01_axi_awaddr_s;
						//	$display ("AXIFULL_drive: req.s01_axi_awaddr_s %b",req.s01_axi_awaddr_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_awaddr %b",vif.s01_axi_full_awaddr);
						/*2*/vif.s01_axi_full_awlen = req.s01_axi_awlen_s;
						//	$display ("AXIFULL_drive: req.s01_axi_awlen_s %b",req.s01_axi_awlen_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_awlen %b",vif.s01_axi_full_awlen);
						/*3*/vif.s01_axi_full_awsize = req.s01_axi_awsize_s;
						//	$display ("AXIFULL_drive: req.s01_axi_awsize_s %b",req.s01_axi_awsize_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_awsize %b",vif.s01_axi_full_awsize);
						/*4*/vif.s01_axi_full_awburst = req.s01_axi_awburst_s;
							//$display ("AXIFULL_drive: req.s01_axi_awburst_s %b",req.s01_axi_awburst_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_awburst %b",vif.s01_axi_full_awburst);
						/*5*/vif.s01_axi_full_awvalid = req.s01_axi_awvalid_s;
							//$display ("AXIFULL_drive: req.s01_axi_awvalid_s %b",req.s01_axi_awvalid_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_awvalid %b",vif.s01_axi_full_awvalid);

						wait(vif.s01_axi_full_awready ==1'b1)
						wait(vif.s01_axi_full_awready ==1'b0)
						@(negedge vif.s01_axi_full_aclk);	
					end
					//Send first data at 0 position
					if(req.first_or_middle_or_last_wdata==0) begin
				//-------------------------------------------------------------------------
				//---------AXIFULL_drive: UPIS PRVOG PODATKA NA ADRESU 0--------
                //-------------------------------------------------------------------------
						
						//$display ("AXIFULL_drive: UPIS PRVOG PODATKA NA ADRESU 0");
						//$display ("AXIFULL_drive: //Send first data at 0 position");
							/*1*/vif.s01_axi_full_wdata = req.s01_axi_wdata_s;
							//$display ("AXIFULL_drive: req.s01_axi_wdata_s %b",req.s01_axi_wdata_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_wdata %b",vif.s01_axi_full_wdata);
							/*2*/vif.s01_axi_full_wvalid = req.s01_axi_wvalid_s;
							//$display ("AXIFULL_drive: req.s01_axi_wvalid_s %b",req.s01_axi_wvalid_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_wvalid %b",vif.s01_axi_full_wvalid);
							/*3*/vif.s01_axi_full_wstrb = req.s01_axi_wstrb_s;
							//$display ("AXIFULL_drive: req.s01_axi_wstrb_s %b",req.s01_axi_wstrb_s);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_wstrb %b",vif.s01_axi_full_wstrb);
							/*4*/vif.s01_axi_full_wlast=req.s01_axi_wlast_s;
							//$display ("AXIFULL_drive: req.s01_axi_wlast_s %b",req.s01_axi_wlast_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_wlast %b",vif.s01_axi_full_wlast);
							/*5*/vif.s01_axi_full_bready=req.s01_axi_bready_s;
							//$display ("AXIFULL_drive: req.s01_axi_bready_s %b",req.s01_axi_bready_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_bready %b",vif.s01_axi_full_bready);
							
							//$display ("AXIFULL_drive: wait s01_axi_full_wready");
							wait(vif.s01_axi_full_wready ==1'b1)
							//$display ("AXIFULL_drive:s01_axi_full_wready has proceeded");
							@(negedge vif.s01_axi_full_aclk);
							//$display ("AXIFULL_drive: vif.s01_axi_full_aclk has proceeded");
							@(negedge vif.s01_axi_full_aclk);
							//$display ("AXIFULL_drive: vif.s01_axi_full_aclk has proceeded");
					end

					else if(req.first_or_middle_or_last_wdata==1) begin
				//-------------------------------------------------------------------------
				//---------AXIFULL_drive: UPIS OD DRUGOG PA SVE DO PREDPOSLEDNJEG POODATKA--------
                //-------------------------------------------------------------------------

						//$display ("AXIFULL_drive: UPIS OD DRUGOG PA SVE DO PREDPOSLEDNJEG POODATKA");
						/*1*/vif.s01_axi_full_wdata = req.s01_axi_wdata_s;
						//$display ("AXIFULL_drive: req.s01_axi_wdata_s %b",req.s01_axi_wdata_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_wdata %b",vif.s01_axi_full_wdata);
						/*2*/vif.s01_axi_full_wvalid = req.s01_axi_wvalid_s;
						//	$display ("AXIFULL_drive: req.s01_axi_wvalid_s %b",req.s01_axi_wvalid_s);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_wvalid %b",vif.s01_axi_full_wvalid);
							/*3*/vif.s01_axi_full_wstrb = req.s01_axi_wstrb_s;
						//$display ("AXIFULL_drive: req.s01_axi_wstrb_s %b",req.s01_axi_wstrb_s);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_wstrb %b",vif.s01_axi_full_wstrb);
							/*4*/vif.s01_axi_full_wlast=req.s01_axi_wlast_s;
						//	$display ("AXIFULL_drive: req.s01_axi_wlast_s %b",req.s01_axi_wlast_s);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_wlast %b",vif.s01_axi_full_wlast);
							/*5*/vif.s01_axi_full_bready =req.s01_axi_bready_s;
						//	$display ("AXIFULL_drive: req.s01_axi_bready_s %b",req.s01_axi_bready_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_bready %b",vif.s01_axi_full_bready);

						@(negedge vif.s01_axi_full_aclk);
						//$display ("@(negedge vif.s01_axi_full_aclk)");
					end

					else if(req.first_or_middle_or_last_wdata==2) begin
				//-------------------------------------------------------------------------
				//---------AXIFULL_drive: UPIS POSLEDNJEG PODATKA--------
                //-------------------------------------------------------------------------
						/*1*/vif.s01_axi_full_wdata = req.s01_axi_wdata_s;
						//$display ("AXIFULL_drive: req.s01_axi_wdata_s %b",req.s01_axi_wdata_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_wdata %b",vif.s01_axi_full_wdata);
						/*2*/vif.s01_axi_full_wvalid = req.s01_axi_wvalid_s;
							//$display ("AXIFULL_drive: req.s01_axi_wvalid_s %b",req.s01_axi_wvalid_s);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_wvalid %b",vif.s01_axi_full_wvalid);
							/*3*/vif.s01_axi_full_wstrb = req.s01_axi_wstrb_s;
							$display ("AXIFULL_drive: req.s01_axi_wstrb_s %b",req.s01_axi_wstrb_s);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_wstrb %b",vif.s01_axi_full_wstrb);
							/*4*/vif.s01_axi_full_wlast=req.s01_axi_wlast_s;
						//	$display ("AXIFULL_drive: req.s01_axi_wlast_s %b",req.s01_axi_wlast_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_wlast %b",vif.s01_axi_full_wlast);
							/*5*/vif.s01_axi_full_bready=req.s01_axi_bready_s;
							//$display ("AXIFULL_drive: req.s01_axi_bready_s %b",req.s01_axi_bready_s);
						//$display ("AXIFULL_drive: vif.s01_axi_full_bready %b",vif.s01_axi_full_bready);
						
					end

				end
				
				else begin
					//-------------------------------------------------------------------------
				//---------AXIFULL_drive: POSTAVLJANJE SVIH POLJA NA NULU--------
                //-------------------------------------------------------------------------
					//$display ("AXIFULL_drive: line 132 : req.r_or_w==1'b1 and req.set_to_zero_or_not==1'b1 ");
					@(negedge vif.s01_axi_full_aclk);
					//Respecting the protocol, please set mentioned values to 0.

					/*1*/vif.s01_axi_full_wdata = req.s01_axi_wdata_s;
					//	$display ("AXIFULL_drive: req.s01_axi_wdata_s %b",req.s01_axi_wdata_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_wdata %b",vif.s01_axi_full_wdata);
					/*2*/vif.s01_axi_full_wvalid = req.s01_axi_wvalid_s;
				//	$display ("AXIFULL_drive: req.s01_axi_wvalid_s %b",req.s01_axi_wvalid_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_wvalid %b",vif.s01_axi_full_wvalid);
					/*3*/vif.s01_axi_full_wstrb = req.s01_axi_wstrb_s;
				//		$display ("AXIFULL_drive: req.s01_axi_wstrb_s %b",req.s01_axi_wstrb_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_wstrb %b",vif.s01_axi_full_wstrb);
					/*4*/vif.s01_axi_full_wlast=req.s01_axi_wlast_s;
				//		$display ("AXIFULL_drive: req.s01_axi_wlast_s %b",req.s01_axi_wlast_s);
			//		$display ("AXIFULL_drive: vif.s01_axi_full_wlast %b",vif.s01_axi_full_wlast);
					/*5*/vif.s01_axi_full_awaddr = req.s01_axi_awaddr_s;
				//		$display ("AXIFULL_drive: req.s01_axi_awaddr_s %b",req.s01_axi_awaddr_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_awaddr %b",vif.s01_axi_full_awaddr);
					/*6*/vif.s01_axi_full_awlen = req.s01_axi_awlen_s;
				//		$display ("AXIFULL_drive: req.s01_axi_awlen_s %d",req.s01_axi_awlen_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_awlen %d",vif.s01_axi_full_awlen);
					/*7*/vif.s01_axi_full_awburst = req.s01_axi_awburst_s;
				//		$display ("AXIFULL_drive: req.s01_axi_awburst_s %b",req.s01_axi_awburst_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_awburst %b",vif.s01_axi_full_awburst);
					/*8*/vif.s01_axi_full_awvalid = req.s01_axi_awvalid_s;
				//		$display ("AXIFULL_drive: req.s01_axi_awvalid_s %b",req.s01_axi_awvalid_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_awvalid %b",vif.s01_axi_full_awvalid);
					/*9*/vif.s01_axi_full_bready = req.s01_axi_bready_s;
				//		$display ("AXIFULL_drive: req.s01_axi_bready_s %b",req.s01_axi_bready_s);
				//	$display ("AXIFULL_drive: vif.s01_axi_full_bready %b",vif.s01_axi_full_bready);
					
					
					if(vif.s01_axi_full_bvalid==1'b1) begin
					//	$display ("AXIFULL_drive: vif.s01_axi_full_bvalid==1'b1 ");
						wait(vif.s01_axi_full_bvalid==1'b0);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_bvalid==1'b0 ");
						@(negedge vif.s01_axi_full_aclk);
						vif.s01_axi_full_bready=1'b0;
					//	$display ("AXIFULL_drive: vif.s01_axi_full_bready %b",vif.s01_axi_full_bready);
					end
			
					else begin
					//	$display ("AXIFULL_drive: WAIT! vif.s01_axi_full_bvalid==1'b1 ");
						wait(vif.s01_axi_full_bvalid==1'b1);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_bvalid==1'b1 ");
						wait(vif.s01_axi_full_bvalid==1'b0);
					//	$display ("AXIFULL_drive: vif.s01_axi_full_bvalid==1'b1 ");
						@(negedge vif.s01_axi_full_aclk);
						vif.s01_axi_full_bready=1'b0;
				//		$display ("AXIFULL_drive: vif.s01_axi_full_bready %b",vif.s01_axi_full_bready);
					end
	
					

				end
		end

		else begin
			//READ!!!
			if(req.set_to_zero_or_not==1'b0) begin
				@(negedge vif.s01_axi_full_aclk);
				$display ("AXIFULL_drive: line 180 : req.r_or_w==1'b0 and req.set_to_zero_or_not==1'b0 ");
				/*1*/vif.s01_axi_full_araddr	= req.s01_axi_araddr_s;
				$display ("AXIFULL_drive: req.s01_axi_araddr_s %b",req.s01_axi_araddr_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_araddr %b",vif.s01_axi_full_araddr);
				/*2*/vif.s01_axi_full_arlen    = req.s01_axi_arlen_s;
				$display ("AXIFULL_drive: req.s01_axi_arlen_s %b",req.s01_axi_arlen_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_arlen %b",vif.s01_axi_full_arlen);
				/*3*/vif.s01_axi_full_arsize    = req.s01_axi_arsize_s;
				$display ("AXIFULL_drive: req.s01_axi_arsize_s %b",req.s01_axi_arsize_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_arsize %b",vif.s01_axi_full_arsize);
				/*4*/vif.s01_axi_full_arburst    = req.s01_axi_arburst_s;
				$display ("AXIFULL_drive: req.s01_axi_arburst_s %b",req.s01_axi_arburst_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_arburst %b",vif.s01_axi_full_arburst);
				/*5*/vif.s01_axi_full_arvalid    = req.s01_axi_arvalid_s;
				$display ("AXIFULL_drive: req.s01_axi_arvalid_s %b",req.s01_axi_arvalid_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_arvalid %b",vif.s01_axi_full_arvalid);
				/*6*/vif.s01_axi_full_rready	= req.s01_axi_rready_s;
				$display ("AXIFULL_drive: req.s01_axi_rready_s %b",req.s01_axi_rready_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_rready %b",vif.s01_axi_full_rready);
	
			end

			else begin
				$display ("AXIFULL_drive: line 203 : req.r_or_w==1'b0 and req.set_to_zero_or_not==1'b1 ");
				wait(vif.s01_axi_full_arready==1'b1)
				wait(vif.s01_axi_full_arready==1'b0)
				@(negedge vif.s01_axi_full_aclk);

				/*1*/vif.s01_axi_full_araddr	= req.s01_axi_araddr_s;
				$display ("AXIFULL_drive: req.s01_axi_araddr_s %b",req.s01_axi_araddr_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_araddr %b",vif.s01_axi_full_araddr);
				/*2*/vif.s01_axi_full_arlen    = req.s01_axi_arlen_s;
				$display ("AXIFULL_drive: req.s01_axi_arlen_s %b",req.s01_axi_arlen_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_arlen %b",vif.s01_axi_full_arlen);
				/*3*/vif.s01_axi_full_arburst    = req.s01_axi_arburst_s;
				$display ("AXIFULL_drive: req.s01_axi_arburst_s %b",req.s01_axi_arburst_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_arburst %b",vif.s01_axi_full_arburst);
				/*4*/vif.s01_axi_full_arvalid    = req.s01_axi_arvalid_s;
				$display ("AXIFULL_drive: req.s01_axi_arvalid_s %b",req.s01_axi_arvalid_s);
					$display ("AXIFULL_drive: vif.s01_axi_full_arvalid %b",vif.s01_axi_full_arvalid);
				
				
				
				
				for(int i=0;i<=89999;i++) begin
					wait(vif.s01_axi_full_rvalid==1'b1)
					wait(vif.s01_axi_full_rvalid==1'b0)
				$display ("AXIFULL_drive: counter %d",i);
				end
				
				///*5*/vif.s01_axi_full_rready   = 1'b0;
					//$display ("AXIFULL_drive: vif.s01_axi_full_rready %b",vif.s01_axi_full_rready);
			end
				
		end
		
			
			$display ("AXIFULL_drive: EXIT");
	endtask : drive_tr

endclass : AXIFULL_drive

`endif

