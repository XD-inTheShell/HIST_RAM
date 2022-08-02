module pipeline_ram (
    input logic clk, rst,
    input logic [4:0] addr_r,
    input logic ram_en,
    // JTAG Specific
    input logic use_JTAG,
    input logic [31:0] m_addr,
    output logic [31:0] s_readdata,
    input logic m_write,
    input logic [31:0] m_writedata,
    output logic s_readdatavalid
); 

    // master_1_master_reset_reset                  (m1_sys_rst),                  //  output,   width = 1,             master_1_master_reset.reset
    // .master_1_master_address                      (m1_addr),                      //  output,  width = 32,                   master_1_master.address
    // .master_1_master_readdata                     (m1_readdata),                     //   input,  width = 32,                                  .readdata
    // .master_1_master_read                         (m1_read),                         //  output,   width = 1,                                  .read
    // .master_1_master_write                        (m1_write),                        //  output,   width = 1,                                  .write
    // .master_1_master_writedata                    (m1_writedata),                    //  output,  width = 32,                                  .hist_writedata
    // .master_1_master_waitrequest                  (m1_waitrequest),                  //   input,   width = 1,                                  .waitrequest
    // .master_1_master_readdatavalid                (m1_readdatavalid),                //   input,   width = 1,                                  .readdatavalid
    // .master_1_master_byteenable 

    // three stages: issue read, between read and write, write
    logic [4:0] addr_b, addr_w;
    logic en_r, en_b, en_w;
    
    // Issue Read
    logic [31:0] readdata, hist_writedata, readdata_fvalue;
    logic [4:0] hist_rdaddr;
    assign hist_rdaddr = addr_r;

    // Jtag specific
    logic wren;
    logic [4:0] wraddr, rdaddr;
    logic [31:0] writedata;
    always_comb begin
        if(use_JTAG) begin
            writedata = m_writedata;
            wraddr = m_addr;
            rdaddr = m_addr;
            wren = m_write;
            s_readdata = readdata;
        end else begin
            writedata = hist_writedata;
            wraddr = addr_w;
            rdaddr = hist_rdaddr;
            wren = en_w;
            s_readdata = 'bx;
        end
    end
    ram2 u0 (
        .data      (writedata),      //   input,  width = 32,      data.datain
        .q         (readdata),         //  output,  width = 32,         q.dataout
        .wraddress (wraddr), //   input,   width = 5, wraddress.wraddress
        .rdaddress (rdaddr), //   input,   width = 5, rdaddress.rdaddress
        .wren      (wren),      //   input,   width = 1,      wren.wren
        .clock     (clk)      //   input,   width = 1,     clock.clk
    );

    // Combinational logic of SRAM between issue read and write 
    always_ff @(posedge clk) begin
        if (rst) begin
            addr_b <= 'b0;
        end else begin
            addr_b <= addr_r;
        end
    end

    // Write Stage, add one and update to memory. 
    always_ff @(posedge clk) begin
        if (rst) begin
            addr_w <= 'b0;
        end else begin
            addr_w <= addr_b;
        end
    end

    assign hist_writedata =  readdata_fvalue + 1;

    // always_ff (posedge clk) begin
    //     if(rst) begin
    //         en_r <= 0;
    //     end else if (~en_r) begin
        
    // end

    // delay wren by two cycles
    assign en_r = ram_en;
    always_ff @(posedge clk) begin
        if (rst) begin
            en_b <= 0;
            en_w <= 0;
        end else begin
            en_b <= en_r;
            en_w <= en_b;
        end
    end

    // forward
    logic [31:0] fw_value_b, fw_value_w;
    always_ff @(posedge clk) begin
        if(rst) begin
            fw_value_b <= 0;
            fw_value_w <= 0;
        end else begin
            fw_value_b <= hist_writedata;
            fw_value_w <= fw_value_b;
        end
    end
    
    logic [4:0] addr_prev0, addr_prev1;
    always_ff @(posedge clk) begin
        if(rst) begin
            addr_prev0 <= 0;
            addr_prev1 <= 0;
        end else begin
            addr_prev0 <= addr_w;
            addr_prev1 <= addr_prev0;
        end
    end

    logic [4:0] en_prev0, en_prev1;
    always_ff @(posedge clk) begin
        if(rst) begin
            en_prev0 <= 0;
            en_prev1 <= 0;
        end else begin
            en_prev0 <= en_w;
            en_prev1 <= en_prev0;
        end
    end

    //
    logic fw_rb, fw_rw;
    assign fw_rb = en_prev0 ? (addr_w == addr_prev0) : 1'b0;
    assign fw_rw = en_prev1 ? (addr_w == addr_prev1) : 1'b0;
    always_comb begin
        if(fw_rb) begin
            readdata_fvalue = fw_value_b;
        end else if(fw_rw) begin
            readdata_fvalue = fw_value_w;
        end else begin
            readdata_fvalue = readdata;
        end
    end

    
endmodule
