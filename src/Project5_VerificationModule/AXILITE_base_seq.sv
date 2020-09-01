/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXILITE_base_seq.sv

    DESCRIPTION     base sequence; to be extended by all other AXI LITE sequences

*******************************************************************************/

`ifndef AXILITE_BASE_SEQ
`define AXILITE_BASE_SEQ

class AXILITE_base_seq extends uvm_sequence#(Data_Sequence_AXILITE);

    `uvm_object_utils(AXILITE_base_seq)
    `uvm_declare_p_sequencer(AXI1_SQR)


    function new(string name = "AXILITE_base_seq");
        super.new(name);
    endfunction

    // objections are raised in pre_body
    virtual task pre_body();
        uvm_phase phase = get_starting_phase();
        if (phase != null)
            phase.raise_objection(this, {"Running sequence '", get_full_name(), "'"});
    endtask : pre_body 

    // objections are dropped in post_body
    virtual task post_body();
       uvm_phase phase = get_starting_phase();
        if (phase != null)
            phase.drop_objection(this, {"Completed sequence '", get_full_name(), "'"});
    endtask : post_body

endclass : AXILITE_base_seq

`endif

