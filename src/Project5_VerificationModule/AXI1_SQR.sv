/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXI1_SQR.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXI1_SQR
`define AXI1_SQR

class AXI1_SQR extends uvm_sequencer#(Data_Sequence_AXILITE);

    `uvm_component_utils(AXI1_SQR)

    function new(string name = "AXI1_SQR", uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass : AXI1_SQR

`endif

