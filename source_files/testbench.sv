`timescale 1ns/1ns
module testbench;
    reg clk, rst;
    logic [31:0] writedata, readdata, wraddr, rdaddr;
    logic wren;

    initial clk = 0;
    always begin
        #5 clk = ~clk;
    end

    // ram1 u0 (
    //     .data    (writedata),    //   input,  width = 32,    data.datain
    //     .q       (readdata),       //  output,  width = 32,       q.dataout
    //     .address (address), //   input,  width = 12, address.address
    //     .wren    (wren),    //   input,   width = 1,    wren.wren
    //     .clock   (clk)    //   input,   width = 1,   clock.clk
    // );

    
    ram2 u0 (
        .data      (writedata),      //   input,  width = 32,      data.datain
        .q         (readdata),         //  output,  width = 32,         q.dataout
        .wraddress (wraddr), //   input,   width = 5, wraddress.wraddress
        .rdaddress (rdaddr), //   input,   width = 5, rdaddress.rdaddress
        .wren      (wren),      //   input,   width = 1,      wren.wren
        .clock     (clk)      //   input,   width = 1,     clock.clk
    );


    initial begin
        #15;
        rst = 1;
        #10;
        rst = 0;
        #10;
        writedata = 'd10;
        wraddr = 'd0;
        wren = 'b1;
        #10;
        writedata= 'd15;
        wraddr = 'd0;
        rdaddr = 'd0;
        wren = 'b0;
        #10;
        rdaddr = 'd0;
        #150;
        $finish;
    end

    initial begin 
        $dumpfile("testbench.vcd");
        $dumpvars;
    end
endmodule