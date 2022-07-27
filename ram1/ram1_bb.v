module ram1 (
		input  wire [31:0] data,    //    data.datain
		output wire [31:0] q,       //       q.dataout
		input  wire [11:0] address, // address.address
		input  wire        wren,    //    wren.wren
		input  wire        clock    //   clock.clk
	);
endmodule

