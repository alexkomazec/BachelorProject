/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXI_scoreboard.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXI_SCOREBOARD_SV
`define AXI_SCOREBOARD_SV

`uvm_analysis_imp_decl(_lite)
`uvm_analysis_imp_decl(_full)

class AXI_scoreboard extends uvm_scoreboard;
	
    bit [0:89999] [7:0] MEM_Rnew_CONTENT_c ;
	integer outfile1; //file descriptor
    int i = 0;
	bit [7:0] one_line;
	integer counter=0;
    // This TLM port is used to connect the scoreboard to the monitor

	uvm_analysis_imp_lite#(Data_Sequence_AXILITE, AXI_scoreboard) port_lite;   
	uvm_analysis_imp_full#(Data_Sequence_AXIFULL, AXI_scoreboard) port_full;

    int num_of_tr;

    `uvm_component_utils(AXI_scoreboard)


    function new(string name = "AXI_scoreboard", uvm_component parent = null);
        super.new(name,parent);
			port_full = new("port_full", this);
			port_lite = new("port_lite", this);
    endfunction : new

	task run_phase(uvm_phase phase);     
		
		
		//initial begin	?????
		
			outfile1=$fopen("NewFirstDim.txt","r");   //"r" means reading and "w" means writing
			//$display ("AXIFULL_seq: Prepare for reading from FirstDim.txt");
			//read line by line.
			while (! $feof(outfile1)) begin //read until an "end of file" is reached.
				
				$fscanf(outfile1,"%b\n",one_line); //scan each line and get the value as an hexadecimal, use %b for binary and %d for decimal.
				//$display ("AXIFULL_seq:one_line= %b",one_line);
				#10; //wait some time as needed.
					
				for(int j=0;j<8;j++) begin
					MEM_Rnew_CONTENT_c[i][j]=one_line[j];
				end	
				
				//$display ("AXIFULL_seq:MEM_Rnew_CONTENT_c[%d\t][%b\t]",i,MEM_Rnew_CONTENT_c[i]);
				i++;
			end 
			//once reading and writing is finished, close the file.
			$fclose(outfile1);
		//end
		
		
		
	endtask : run_phase
	
	
	function write_full ( Data_Sequence_AXIFULL tr);
		
		Data_Sequence_AXIFULL tr_clone;	
		$display ("AXI_scoreboard:I am here 2");
		
		counter++;
		$display ("AXI_scoreboard:I am here 3"); 
        
        assert($cast(tr_clone, tr.clone())); 
		
          //CHECKING THE VALUES
				asrt_rnew_axi_data_port_eq_MEM_Rnew_CONTENT_c : assert (tr_clone.rnew_axi_data_port == MEM_Rnew_CONTENT_c[counter]) 
				
				`uvm_info(get_type_name(), "Check succesfull: rnew_axi_data_port == MEM_Rnew_CONTENT_c", UVM_LOW) 
					else begin  
				`uvm_error(get_type_name(), $sformatf("Observed rnew_axi_data_port and MEM_Rnew_CONTENT_c mismatch: rnew_axi_data_port = %0d, MEM_Rnew_CONTENT_c = %0d",tr_clone.rnew_axi_data_port, MEM_Rnew_CONTENT_c[counter])) 
				end
     
    endfunction : write_full


	function write_lite (Data_Sequence_AXILITE tr );

	endfunction : write_lite

	function void report_phase(uvm_phase phase);
		//print();
		`uvm_info(get_type_name(), $sformatf("AXI scoreboard examined: %0d transactions", num_of_tr), UVM_HIGH);
	endfunction : report_phase

endclass : AXI_scoreboard

`endif

