module hist_controller #(
    parameter NUM_BINS = 3
) (
    input logic clk, rst,
    input logic [31:0] value,
    input logic wren_range,
    input logic [31:0] writedata_range, addrwrt_range, 
    output logic [31:0] readdata_range, readvalid_range,
    output logic [NUM_BINS-1:0] bin_idx_onehot
);
    localparam NUM_RANGEVAL = NUM_BINS - 1;

    logic [31:0] onehot_wren;
    logic [NUM_RANGEVAL-1:0] se, gt;
    
    assign readvalid_range = 1'b1;


    assign onehot_wren = 1'b1 << addrwrt_range;

    range_reg range0(
        .clk(clk),
        .rst(rst),
        .value(value),
        .in_range(writedata_range),
        .wren_range(onehot_wren[0] & wren_range),
        .smaller_equal(se[0]),
        .greater(gt[0])
    );

    range_reg range1(
        .clk(clk),
        .rst(rst),
        .value(value),
        .in_range(writedata_range),
        .wren_range(onehot_wren[1] & wren_range),
        .smaller_equal(se[1]),
        .greater(gt[1])
    );

    assign bin_idx_onehot[0]            = 1'b1 & se[0];
    assign bin_idx_onehot[NUM_BINS-1]   = gt[NUM_RANGEVAL-1] & 1'b1;
    assign bin_idx_onehot[1]            = gt[0] & se[1];





endmodule