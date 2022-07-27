// ram1_ram_1port_intel_mce_arb_2000_37opjya.v

// Generated using ACDS version 19.4 64

`timescale 1 ps / 1 ps
module ram1_ram_1port_intel_mce_arb_2000_37opjya #(
		parameter LATENCY           = 2,
		parameter DATA_WIDTH        = 32,
		parameter WIDTHAD           = 12,
		parameter BYTE_ENABLE_WIDTH = 4
	) (
		input  wire        clk,               //      mm_clk.clk
		input  wire        reset,             //       reset.reset
		input  wire [11:0] uaddr,             //    user_slv.address
		input  wire [3:0]  ubyteena,          //            .byteenable
		input  wire [31:0] uwdata,            //            .write
		input  wire        urden,             //            .read
		input  wire        uwren,             //            .writeenable
		input  wire        uaddressstall,     //            .addressstall
		output wire [31:0] urdata,            //            .readdata
		input  wire [11:0] ismce_addr,        // ismce_slave.address
		input  wire [3:0]  ismce_byteena,     //            .byteenable
		input  wire [31:0] ismce_wdata,       //            .writedata
		input  wire        ismce_wren,        //            .write
		input  wire        ismce_rden,        //            .read
		output wire [31:0] ismce_rdata,       //            .readdata
		output wire        ismce_waitrequest, //            .waitrequest
		output wire [11:0] addr,              //  ram_master.address
		output wire [3:0]  byteena,           //            .byteenable
		output wire [31:0] wdata,             //            .writedata
		output wire        rden,              //            .read
		output wire        wren,              //            .write
		output wire        addressstall,      //            .addressstall
		input  wire [31:0] rdata              //            .readdata
	);

	generate
		// If any of the display statements (or deliberately broken
		// instantiations) within this generate block triggers then this module
		// has been instantiated this module with a set of parameters different
		// from those it was generated for.  This will usually result in a
		// non-functioning system.
		if (LATENCY != 2)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					latency_check ( .error(1'b1) );
		end
		if (DATA_WIDTH != 32)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					data_width_check ( .error(1'b1) );
		end
		if (WIDTHAD != 12)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					widthad_check ( .error(1'b1) );
		end
		if (BYTE_ENABLE_WIDTH != 4)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					byte_enable_width_check ( .error(1'b1) );
		end
	endgenerate

	altera_sld_arbiter #(
		.LATENCY           (2),
		.DATA_WIDTH        (32),
		.WIDTHAD           (12),
		.BYTE_ENABLE_WIDTH (4)
	) intel_mce_arb_inst (
		.clk               (clk),               //   input,   width = 1,      mm_clk.clk
		.reset             (reset),             //   input,   width = 1,       reset.reset
		.uaddr             (uaddr),             //   input,  width = 12,    user_slv.address
		.ubyteena          (ubyteena),          //   input,   width = 4,            .byteenable
		.uwdata            (uwdata),            //   input,  width = 32,            .write
		.urden             (urden),             //   input,   width = 1,            .read
		.uwren             (uwren),             //   input,   width = 1,            .writeenable
		.uaddressstall     (uaddressstall),     //   input,   width = 1,            .addressstall
		.urdata            (urdata),            //  output,  width = 32,            .readdata
		.ismce_addr        (ismce_addr),        //   input,  width = 12, ismce_slave.address
		.ismce_byteena     (ismce_byteena),     //   input,   width = 4,            .byteenable
		.ismce_wdata       (ismce_wdata),       //   input,  width = 32,            .writedata
		.ismce_wren        (ismce_wren),        //   input,   width = 1,            .write
		.ismce_rden        (ismce_rden),        //   input,   width = 1,            .read
		.ismce_rdata       (ismce_rdata),       //  output,  width = 32,            .readdata
		.ismce_waitrequest (ismce_waitrequest), //  output,   width = 1,            .waitrequest
		.addr              (addr),              //  output,  width = 12,  ram_master.address
		.byteena           (byteena),           //  output,   width = 4,            .byteenable
		.wdata             (wdata),             //  output,  width = 32,            .writedata
		.rden              (rden),              //  output,   width = 1,            .read
		.wren              (wren),              //  output,   width = 1,            .write
		.addressstall      (addressstall),      //  output,   width = 1,            .addressstall
		.rdata             (rdata)              //   input,  width = 32,            .readdata
	);

endmodule
