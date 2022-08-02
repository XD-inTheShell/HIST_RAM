module histogram top #(
        parameter NUM_BINS = 3
    ) (
        input logic rst, clk
        input logic [31:0] value,
        // JTAG Specific
        input logic m_sys_rst,
        input logic [31:0] m_addr,
        output logic [31:0] s_readdata,
        input logic m_read, m_write,
        input logic [31:0] m_writedata,
        output logic s_readvalid

    );

    logic [NUM_BINS-1:0] bin_idx_onehot, bin_idx_binary;
    hist_controller controller #(NUM_BINS = 3) (
        .clk(clk),
        .rst(m_sys_rst),
        .wren_range(m_write),
        .value(value),
        .writedata_range(m_writedata),
        .addrwrt_range(m_addr),
        //output
        .readdata_range(s_readdata),
        .readvalid_range(s_readvalid),
        .bin_idx_onehot(bin_idx_onehot)
    )

    onehot_decode decoder #(NUM_BINS = 3) (
        .bin_idx_onehot(bin_idx_onehot),
        .bin_idx_binary(bin_idx_binary)
    )


    pipeline_ram RAM(
        .clk(clk), .rst(rst),
        .addr_r(bin_idx_binary[4:0]),
        .ram_en(ram_en)
    );

endmodule