/*******************************************************************************
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+
    |F|u|n|c|t|i|o|n|a|l| |V|e|r|i|f|i|c|a|t|i|o|n| |o|f| |H|a|r|d|w|a|r|e|
    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+

    FILE            AXIFULL_base_seq.sv

    DESCRIPTION     base sequence; to be extended by all other sequences

*******************************************************************************/

`ifndef AXIFULL_BASE_SEQ_SV
`define AXIFULL_BASE_SEQ_SV

class AXIFULL_base_seq extends uvm_sequence#(Data_Sequence_AXIFULL);

    `uvm_object_utils(AXIFULL_base_seq)
    `uvm_declare_p_sequencer(AXI2_SQR)

    function new(string name = "AXIFULL_base_seq");
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

endclass : AXIFULL_base_seq

`endif

