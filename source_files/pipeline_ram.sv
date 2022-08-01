module pipeline_ram (
    input logic clk, rst,
    input logic [4:0] addr_r,
    input logic ram_en
);    
    // three stages: issue read, between read and write, write
    logic [4:0] addr_b, addr_w, wraddr;
    logic en_r, en_b, en_w;
    
    // Issue Read
    logic [31:0] readdata, writedata, readdata_fvalue;
    logic [4:0] rdaddr;
    assign rdaddr = addr_r;
    ram2 u0 (
        .data      (writedata),      //   input,  width = 32,      data.datain
        .q         (readdata),         //  output,  width = 32,         q.dataout
        .wraddress (addr_w), //   input,   width = 5, wraddress.wraddress
        .rdaddress (rdaddr), //   input,   width = 5, rdaddress.rdaddress
        .wren      (en_w),      //   input,   width = 1,      wren.wren
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

    assign writedata =  readdata_fvalue + 1;
    assign wraddr = addr_w;

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
            fw_value_b <= writedata;
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
