	component SRAM_SC is
		port (
			clock_bridge_0_out_clk_clk                   : out std_logic;                                        -- clk
			clk_clk                                      : in  std_logic                     := 'X';             -- clk
			iopll_0_reset_reset                          : in  std_logic                     := 'X';             -- reset
			iopll_0_locked_export                        : out std_logic;                                        -- export
			master_0_master_reset_reset                  : out std_logic;                                        -- reset
			master_0_master_address                      : out std_logic_vector(31 downto 0);                    -- address
			master_0_master_readdata                     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			master_0_master_read                         : out std_logic;                                        -- read
			master_0_master_write                        : out std_logic;                                        -- write
			master_0_master_writedata                    : out std_logic_vector(31 downto 0);                    -- writedata
			master_0_master_waitrequest                  : in  std_logic                     := 'X';             -- waitrequest
			master_0_master_readdatavalid                : in  std_logic                     := 'X';             -- readdatavalid
			master_0_master_byteenable                   : out std_logic_vector(3 downto 0);                     -- byteenable
			master_1_master_reset_reset                  : out std_logic;                                        -- reset
			master_1_master_address                      : out std_logic_vector(31 downto 0);                    -- address
			master_1_master_readdata                     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			master_1_master_read                         : out std_logic;                                        -- read
			master_1_master_write                        : out std_logic;                                        -- write
			master_1_master_writedata                    : out std_logic_vector(31 downto 0);                    -- writedata
			master_1_master_waitrequest                  : in  std_logic                     := 'X';             -- waitrequest
			master_1_master_readdatavalid                : in  std_logic                     := 'X';             -- readdatavalid
			master_1_master_byteenable                   : out std_logic_vector(3 downto 0);                     -- byteenable
			reset_reset                                  : in  std_logic                     := 'X';             -- reset
			s10_user_rst_clkgate_2_ninit_done_ninit_done : out std_logic                                         -- ninit_done
		);
	end component SRAM_SC;

	u0 : component SRAM_SC
		port map (
			clock_bridge_0_out_clk_clk                   => CONNECTED_TO_clock_bridge_0_out_clk_clk,                   --            clock_bridge_0_out_clk.clk
			clk_clk                                      => CONNECTED_TO_clk_clk,                                      --                               clk.clk
			iopll_0_reset_reset                          => CONNECTED_TO_iopll_0_reset_reset,                          --                     iopll_0_reset.reset
			iopll_0_locked_export                        => CONNECTED_TO_iopll_0_locked_export,                        --                    iopll_0_locked.export
			master_0_master_reset_reset                  => CONNECTED_TO_master_0_master_reset_reset,                  --             master_0_master_reset.reset
			master_0_master_address                      => CONNECTED_TO_master_0_master_address,                      --                   master_0_master.address
			master_0_master_readdata                     => CONNECTED_TO_master_0_master_readdata,                     --                                  .readdata
			master_0_master_read                         => CONNECTED_TO_master_0_master_read,                         --                                  .read
			master_0_master_write                        => CONNECTED_TO_master_0_master_write,                        --                                  .write
			master_0_master_writedata                    => CONNECTED_TO_master_0_master_writedata,                    --                                  .writedata
			master_0_master_waitrequest                  => CONNECTED_TO_master_0_master_waitrequest,                  --                                  .waitrequest
			master_0_master_readdatavalid                => CONNECTED_TO_master_0_master_readdatavalid,                --                                  .readdatavalid
			master_0_master_byteenable                   => CONNECTED_TO_master_0_master_byteenable,                   --                                  .byteenable
			master_1_master_reset_reset                  => CONNECTED_TO_master_1_master_reset_reset,                  --             master_1_master_reset.reset
			master_1_master_address                      => CONNECTED_TO_master_1_master_address,                      --                   master_1_master.address
			master_1_master_readdata                     => CONNECTED_TO_master_1_master_readdata,                     --                                  .readdata
			master_1_master_read                         => CONNECTED_TO_master_1_master_read,                         --                                  .read
			master_1_master_write                        => CONNECTED_TO_master_1_master_write,                        --                                  .write
			master_1_master_writedata                    => CONNECTED_TO_master_1_master_writedata,                    --                                  .writedata
			master_1_master_waitrequest                  => CONNECTED_TO_master_1_master_waitrequest,                  --                                  .waitrequest
			master_1_master_readdatavalid                => CONNECTED_TO_master_1_master_readdatavalid,                --                                  .readdatavalid
			master_1_master_byteenable                   => CONNECTED_TO_master_1_master_byteenable,                   --                                  .byteenable
			reset_reset                                  => CONNECTED_TO_reset_reset,                                  --                             reset.reset
			s10_user_rst_clkgate_2_ninit_done_ninit_done => CONNECTED_TO_s10_user_rst_clkgate_2_ninit_done_ninit_done  -- s10_user_rst_clkgate_2_ninit_done.ninit_done
		);

