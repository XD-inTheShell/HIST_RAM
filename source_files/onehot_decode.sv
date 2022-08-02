module onehot_decode #(
    parameter NUM_BINS = 3
) (
    input logic [NUM_BINS-1:0] bin_idx_onehot, 
    output logic [NUM_BINS-1:0]bin_idx_binary
);
    logic [31:0] binary;
    logic [31:0] idx;

    integer i;
    always_comb begin
        binary = 'b0;
        for(i=0; i<NUM_BINS; i++) begin
            binary |= ({32{bin_idx_onehot[i]}} & i);
        end
    end

    assign bin_idx_binary = binary;

    // SRAM Avalon MM ports:
    // .onchip_memory2_0_s1_address                  (_connected_to_onchip_memory2_0_s1_address_),                  //   input,  width = 10,               onchip_memory2_0_s1.address
    // .onchip_memory2_0_s1_clken                    (_connected_to_onchip_memory2_0_s1_clken_),                    //   input,   width = 1,                                  .clken
    // .onchip_memory2_0_s1_chipselect               (_connected_to_onchip_memory2_0_s1_chipselect_),               //   input,   width = 1,                                  .chipselect
    // .onchip_memory2_0_s1_write                    (_connected_to_onchip_memory2_0_s1_write_),                    //   input,   width = 1,                                  .write
    // .onchip_memory2_0_s1_readdata                 (_connected_to_onchip_memory2_0_s1_readdata_),                 //  output,  width = 32,                                  .readdata
    // .onchip_memory2_0_s1_writedata                (_connected_to_onchip_memory2_0_s1_writedata_),                //   input,  width = 32,                                  .writedata
    // .onchip_memory2_0_s1_byteenable               (_connected_to_onchip_memory2_0_s1_byteenable_)                //   input,   width = 4,                                  .byteenable



endmodule