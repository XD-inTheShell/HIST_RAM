	component SRAM_SC_s10_user_rst_clkgate_1 is
		port (
			ninit_done : out std_logic   -- ninit_done
		);
	end component SRAM_SC_s10_user_rst_clkgate_1;

	u0 : component SRAM_SC_s10_user_rst_clkgate_1
		port map (
			ninit_done => CONNECTED_TO_ninit_done  -- ninit_done.ninit_done
		);

