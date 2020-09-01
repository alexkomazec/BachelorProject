/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXI2_SQR.sv

    DESCRIPTION     

*******************************************************************************/

`ifndef AXI2_SQR
`define AXI2_SQR

class AXI2_SQR extends uvm_sequencer#(Data_Sequence_AXIFULL);

    `uvm_component_utils(AXI2_SQR)

    function new(string name = "AXI2_SQR", uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass : AXI2_SQR

`endif

