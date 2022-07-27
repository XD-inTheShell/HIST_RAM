	SRAM_SC u0 (
		.clock_bridge_0_out_clk_clk                   (_connected_to_clock_bridge_0_out_clk_clk_),                   //  output,   width = 1,            clock_bridge_0_out_clk.clk
		.clk_clk                                      (_connected_to_clk_clk_),                                      //   input,   width = 1,                               clk.clk
		.iopll_0_reset_reset                          (_connected_to_iopll_0_reset_reset_),                          //   input,   width = 1,                     iopll_0_reset.reset
		.iopll_0_locked_export                        (_connected_to_iopll_0_locked_export_),                        //  output,   width = 1,                    iopll_0_locked.export
		.master_0_master_reset_reset                  (_connected_to_master_0_master_reset_reset_),                  //  output,   width = 1,             master_0_master_reset.reset
		.master_0_master_address                      (_connected_to_master_0_master_address_),                      //  output,  width = 32,                   master_0_master.address
		.master_0_master_readdata                     (_connected_to_master_0_master_readdata_),                     //   input,  width = 32,                                  .readdata
		.master_0_master_read                         (_connected_to_master_0_master_read_),                         //  output,   width = 1,                                  .read
		.master_0_master_write                        (_connected_to_master_0_master_write_),                        //  output,   width = 1,                                  .write
		.master_0_master_writedata                    (_connected_to_master_0_master_writedata_),                    //  output,  width = 32,                                  .writedata
		.master_0_master_waitrequest                  (_connected_to_master_0_master_waitrequest_),                  //   input,   width = 1,                                  .waitrequest
		.master_0_master_readdatavalid                (_connected_to_master_0_master_readdatavalid_),                //   input,   width = 1,                                  .readdatavalid
		.master_0_master_byteenable                   (_connected_to_master_0_master_byteenable_),                   //  output,   width = 4,                                  .byteenable
		.master_1_master_reset_reset                  (_connected_to_master_1_master_reset_reset_),                  //  output,   width = 1,             master_1_master_reset.reset
		.master_1_master_address                      (_connected_to_master_1_master_address_),                      //  output,  width = 32,                   master_1_master.address
		.master_1_master_readdata                     (_connected_to_master_1_master_readdata_),                     //   input,  width = 32,                                  .readdata
		.master_1_master_read                         (_connected_to_master_1_master_read_),                         //  output,   width = 1,                                  .read
		.master_1_master_write                        (_connected_to_master_1_master_write_),                        //  output,   width = 1,                                  .write
		.master_1_master_writedata                    (_connected_to_master_1_master_writedata_),                    //  output,  width = 32,                                  .writedata
		.master_1_master_waitrequest                  (_connected_to_master_1_master_waitrequest_),                  //   input,   width = 1,                                  .waitrequest
		.master_1_master_readdatavalid                (_connected_to_master_1_master_readdatavalid_),                //   input,   width = 1,                                  .readdatavalid
		.master_1_master_byteenable                   (_connected_to_master_1_master_byteenable_),                   //  output,   width = 4,                                  .byteenable
		.reset_reset                                  (_connected_to_reset_reset_),                                  //   input,   width = 1,                             reset.reset
		.s10_user_rst_clkgate_2_ninit_done_ninit_done (_connected_to_s10_user_rst_clkgate_2_ninit_done_ninit_done_)  //  output,   width = 1, s10_user_rst_clkgate_2_ninit_done.ninit_done
	);

