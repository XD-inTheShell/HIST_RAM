`timescale 1ns/1ns
module pipeline_ram_tb;
    reg clk, rst, ram_en;
    reg [4:0] addr_r;
    pipeline_ram dut(
        .clk(clk), .rst(rst),
        .addr_r(addr_r),
        .ram_en(ram_en)
    );

    initial clk = 0;
    always begin
        #5 clk = ~clk;
    end

    initial begin
        #15;
        rst = 1;
        #10;
        rst = 0;
        #200;
        $finish;
    end
    logic [31:0] cyc_count;
    always_ff @(posedge clk) begin 
        if (rst) begin
            cyc_count <= 0;
        end else begin
            cyc_count <= cyc_count + 1;
        end
        
    end

    always_comb begin 
        addr_r <= 'd0;
        ram_en <= 'b0;
        if(cyc_count == 1) begin
            addr_r <= 'd1;
            ram_en <= 'b1;
        end else if (cyc_count == 5) begin
            addr_r <= 'd5;
            ram_en <= 'b1;
        end else if (cyc_count == 6) begin
            addr_r <= 'd6;
            ram_en <= 'b1;
        end else if (cyc_count == 7) begin
            addr_r <= 'd5;
            ram_en <= 'b1;
        end else if (cyc_count == 8) begin
            addr_r <= 'd5;
            ram_en <= 'b1;
        end else if (cyc_count == 9) begin
            addr_r <= 'd5;
            ram_en <= 'b1;
        end else if (cyc_count == 10) begin
            addr_r <= 'd5;
            ram_en <= 'b1;
        end else if (cyc_count == 11) begin
            addr_r <= 'd11;
            ram_en <= 'b1;
        end else if (cyc_count == 12) begin
            addr_r <= 'd5;
            ram_en <= 'b0;
        end else if (cyc_count == 13) begin
            addr_r <= 'd5;
            ram_en <= 'b0;
        end
        
    end
    
    initial begin 
        $dumpfile("pipeline_ram_tb.vcd");
        $dumpvars;
    end


endmodule