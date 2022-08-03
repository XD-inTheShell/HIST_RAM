module pipeline_ram_top (
    input clk
);

    logic rst;
    logic locked;

    logic pll_clk, m1_sys_rst, m1_read, m1_write, m1_waitrequest, m1_readdatavalid;
    logic readdatavalid_tmp;
    logic [31:0] m1_addr, m1_readdata, m1_writedata;
    logic [31:0] r0, r1, r2, r3;

    logic [31:0] rendered_memaddr, writedata;
    logic [4:0] access_addr;
    logic ram_wren, rf_wren; 

    // r0, JTAG or RegFile
    // r1, ram address
    // r2, wren
    // r3, data
    logic effect_write;
    logic effect_write_last;
    // select between registerfile driven or jtag
    assign access_addr = r0[0] ? r1[4:0] : rendered_memaddr[4:0];
    assign effect_write = r2[0];
    assign ram_wren = r0[0] ? rf_wren : m1_write;
    assign writedata = r0[0] ? r3 : m1_writedata;

    assign rendered_memaddr = m1_addr>>2;
    assign m1_waitrequest = 1'b0;

    always @(posedge pll_clk) begin
        if (m1_sys_rst) begin
            readdatavalid_tmp <= 1'b0;
            m1_readdatavalid <= 1'b0;
    end else begin
        readdatavalid_tmp <= m1_read;
        m1_readdatavalid <= readdatavalid_tmp;
        end
    end
    logic use_JTAG;
    assign use_JTAG = ~r0[0];
    pipeline_ram dut(
        .clk(pll_clk), .rst(m1_sys_rst),
        .addr_r(r1),
        .ram_en(ram_wren),
        // JTAG specific
        .use_JTAG(use_JTAG),
        .m_addr(rendered_memaddr),
        .s_readdata(m1_readdata),
        .m_write(m1_write),
        .m_writedata(m1_writedata),
        .s_readdatavalid()
    );


    


    always_ff @(posedge pll_clk) begin
    if(m1_sys_rst) begin
        rf_wren <= 0;
        effect_write_last <= 0;
    end
    else if (~effect_write_last & effect_write) begin
        rf_wren <= 1;
        effect_write_last <= effect_write;
    end else begin
        rf_wren <= 0;
        effect_write_last <= effect_write;
    end
    end

    


    
    logic m0_read, m0_write, m0_waitrequest, m0_readvalid;
    assign m0_waitrequest = 1'b0;
    assign m0_readvalid = 1'b1;
    logic [31:0] rendered_regaddr, reg_readdata, m0_writedata, m0_addr;
    assign rendered_regaddr = m0_addr>>2;
   regfile rf0 (
       .clock(pll_clk), .ctrl_writeEnable(m0_write), .ctrl_reset(m0_sys_rst),
       .ctrl_writeReg(rendered_regaddr), .ctrl_readRegA(rendered_regaddr), .ctrl_readRegB(),
       .data_writeReg(m0_writedata),
       .data_readRegA(reg_readdata), .data_readRegB(),
           .r0(r0), .r1(r1), .r2(r2), .r3(r3)
   );
//    regfile rf0 (
//        .clock(pll_clk), .ctrl_writeEnable(m1_write), .ctrl_reset(m0_sys_rst),
//        .ctrl_writeReg('b0), .ctrl_readRegA(rendered_regaddr), .ctrl_readRegB(),
//        .data_writeReg(m1_addr),
//        .data_readRegA(reg_readdata), .data_readRegB(),
//            .r0(r0), .r1(r1), .r2(r2), .r3(r3)
//    );



    SRAM_SC periph (
        .clock_bridge_0_out_clk_clk                   (pll_clk),                   //  output,   width = 1,            clock_bridge_0_out_clk.clk
        .clk_clk                                      (clk),                                      //   input,   width = 1,                               clk.clk
        .iopll_0_reset_reset                          (rst),                          //   input,   width = 1,                     iopll_0_reset.reset
        .iopll_0_locked_export                        (locked),                        //  output,   width = 1,                    iopll_0_locked.export
        .master_1_master_reset_reset                  (m1_sys_rst),                  //  output,   width = 1,             master_1_master_reset.reset
        .master_1_master_address                      (m1_addr),                      //  output,  width = 32,                   master_1_master.address
        .master_1_master_readdata                     (m1_readdata),                     //   input,  width = 32,                                  .readdata
        .master_1_master_read                         (m1_read),                         //  output,   width = 1,                                  .read
        .master_1_master_write                        (m1_write),                        //  output,   width = 1,                                  .write
        .master_1_master_writedata                    (m1_writedata),                    //  output,  width = 32,                                  .writedata
        .master_1_master_waitrequest                  (m1_waitrequest),                  //   input,   width = 1,                                  .waitrequest
        .master_1_master_readdatavalid                (m1_readdatavalid),                //   input,   width = 1,                                  .readdatavalid
        .master_1_master_byteenable                   (),                   //  output,   width = 4,                                  .byteenable
        .reset_reset                                  (~locked),                                  //   input,   width = 1,                             reset.reset
        .s10_user_rst_clkgate_2_ninit_done_ninit_done (rst),  //  output,   width = 1, s10_user_rst_clkgate_2_ninit_done.ninit_done
        //master_0 connected to Regfile
        .master_0_master_reset_reset                  (m0_sys_rst),                  //  output,   width = 1,             master_0_master_reset.reset
        .master_0_master_address                      (m0_addr),                      //  output,  width = 32,                   master_0_master.address
        .master_0_master_readdata                     (reg_readdata),                     //   input,  width = 32,                                  .readdata
        .master_0_master_read                         (m0_read),                         //  output,   width = 1,                                  .read
        .master_0_master_write                        (m0_write),                        //  output,   width = 1,                                  .write
        .master_0_master_writedata                    (m0_writedata),                    //  output,  width = 32,                                  .writedata
        .master_0_master_waitrequest                  (m0_waitrequest),                  //   input,   width = 1,                                  .waitrequest
        .master_0_master_readdatavalid                (m0_readvalid),                //   input,   width = 1,                                  .readdatavalid
        .master_0_master_byteenable                   ()                    //  output,   width = 4,                                  .byteenable
    );


endmodule: pipeline_ram_top