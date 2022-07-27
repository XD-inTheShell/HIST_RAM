module SRAM_SC (
		output wire        clock_bridge_0_out_clk_clk,                   //            clock_bridge_0_out_clk.clk
		input  wire        clk_clk,                                      //                               clk.clk
		input  wire        iopll_0_reset_reset,                          //                     iopll_0_reset.reset
		output wire        iopll_0_locked_export,                        //                    iopll_0_locked.export
		output wire        master_0_master_reset_reset,                  //             master_0_master_reset.reset
		output wire [31:0] master_0_master_address,                      //                   master_0_master.address
		input  wire [31:0] master_0_master_readdata,                     //                                  .readdata
		output wire        master_0_master_read,                         //                                  .read
		output wire        master_0_master_write,                        //                                  .write
		output wire [31:0] master_0_master_writedata,                    //                                  .writedata
		input  wire        master_0_master_waitrequest,                  //                                  .waitrequest
		input  wire        master_0_master_readdatavalid,                //                                  .readdatavalid
		output wire [3:0]  master_0_master_byteenable,                   //                                  .byteenable
		output wire        master_1_master_reset_reset,                  //             master_1_master_reset.reset
		output wire [31:0] master_1_master_address,                      //                   master_1_master.address
		input  wire [31:0] master_1_master_readdata,                     //                                  .readdata
		output wire        master_1_master_read,                         //                                  .read
		output wire        master_1_master_write,                        //                                  .write
		output wire [31:0] master_1_master_writedata,                    //                                  .writedata
		input  wire        master_1_master_waitrequest,                  //                                  .waitrequest
		input  wire        master_1_master_readdatavalid,                //                                  .readdatavalid
		output wire [3:0]  master_1_master_byteenable,                   //                                  .byteenable
		input  wire        reset_reset,                                  //                             reset.reset
		output wire        s10_user_rst_clkgate_2_ninit_done_ninit_done  // s10_user_rst_clkgate_2_ninit_done.ninit_done
	);
endmodule

