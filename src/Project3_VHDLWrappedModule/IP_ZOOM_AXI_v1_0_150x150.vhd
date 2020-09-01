library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.utils_pkg.all;

entity IP_ZOOM_AXI_v1_0_150x150 is
	generic (
		-- Users to add parameters here
            WIDTH  : integer := 256;     
            SIZE   : integer := 150;
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI_LITE
		C_S00_AXI_LITE_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_LITE_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface S01_AXI_FULL
		C_S01_AXI_FULL_ID_WIDTH	: integer	:= 1;
		C_S01_AXI_FULL_DATA_WIDTH	: integer	:= 32;
		C_S01_AXI_FULL_ADDR_WIDTH	: integer	:= 20;
		C_S01_AXI_FULL_AWUSER_WIDTH	: integer	:= 1;
		C_S01_AXI_FULL_ARUSER_WIDTH	: integer	:= 1;
		C_S01_AXI_FULL_WUSER_WIDTH	: integer	:= 1;
		C_S01_AXI_FULL_RUSER_WIDTH	: integer	:= 1;
		C_S01_AXI_FULL_BUSER_WIDTH	: integer	:= 1
	);
	port (
		-- Users to add ports here
        -- signal declarations   
             
		-- User ports ends
		-- Do not modify the ports beyond this line
		
		rnew_axi_data_port:   out std_logic_vector(log2c(WIDTH)-1 downto 0);
		-- Ports of Axi Slave Bus Interface S00_AXI_LITE
		--sel_s              : in std_logic;
		reset_s  		    : in std_logic;
		s00_axi_lite_aclk	: in std_logic;
		s00_axi_lite_aresetn	: in std_logic;
		s00_axi_lite_awaddr	: in std_logic_vector(C_S00_AXI_LITE_ADDR_WIDTH-1 downto 0);
		s00_axi_lite_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_lite_awvalid	: in std_logic;
		s00_axi_lite_awready	: out std_logic;
		s00_axi_lite_wdata	: in std_logic_vector(C_S00_AXI_LITE_DATA_WIDTH-1 downto 0);
		s00_axi_lite_wstrb	: in std_logic_vector((C_S00_AXI_LITE_DATA_WIDTH/8)-1 downto 0);
		s00_axi_lite_wvalid	: in std_logic;
		s00_axi_lite_wready	: out std_logic;
		s00_axi_lite_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_lite_bvalid	: out std_logic;
		s00_axi_lite_bready	: in std_logic;
		s00_axi_lite_araddr	: in std_logic_vector(C_S00_AXI_LITE_ADDR_WIDTH-1 downto 0);
		s00_axi_lite_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_lite_arvalid	: in std_logic;
		s00_axi_lite_arready	: out std_logic;
		s00_axi_lite_rdata	: out std_logic_vector(C_S00_AXI_LITE_DATA_WIDTH-1 downto 0);
		s00_axi_lite_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_lite_rvalid	: out std_logic;
		s00_axi_lite_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S01_AXI_FULL
		s01_axi_full_aclk	: in std_logic;
		s01_axi_full_aresetn	: in std_logic;
		s01_axi_full_awid	: in std_logic_vector(C_S01_AXI_FULL_ID_WIDTH-1 downto 0);
		s01_axi_full_awaddr	: in std_logic_vector(C_S01_AXI_FULL_ADDR_WIDTH-1 downto 0);
		s01_axi_full_awlen	: in std_logic_vector(log2c(4*SIZE*SIZE)-3 downto 0);
		s01_axi_full_awsize	: in std_logic_vector(2 downto 0);
		s01_axi_full_awburst	: in std_logic_vector(1 downto 0);
		s01_axi_full_awlock	: in std_logic;
		s01_axi_full_awcache	: in std_logic_vector(3 downto 0);
		s01_axi_full_awprot	: in std_logic_vector(2 downto 0);
		s01_axi_full_awqos	: in std_logic_vector(3 downto 0);
		s01_axi_full_awregion	: in std_logic_vector(3 downto 0);
		s01_axi_full_awuser	: in std_logic_vector(C_S01_AXI_FULL_AWUSER_WIDTH-1 downto 0);
		s01_axi_full_awvalid	: in std_logic;
		s01_axi_full_awready	: out std_logic;
		s01_axi_full_wdata	: in std_logic_vector(C_S01_AXI_FULL_DATA_WIDTH-1 downto 0);
		s01_axi_full_wstrb	: in std_logic_vector((C_S01_AXI_FULL_DATA_WIDTH/8)-1 downto 0);
		s01_axi_full_wlast	: in std_logic;
		s01_axi_full_wuser	: in std_logic_vector(C_S01_AXI_FULL_WUSER_WIDTH-1 downto 0);
		s01_axi_full_wvalid	: in std_logic;
		s01_axi_full_wready	: out std_logic;
		s01_axi_full_bid	: out std_logic_vector(C_S01_AXI_FULL_ID_WIDTH-1 downto 0);
		s01_axi_full_bresp	: out std_logic_vector(1 downto 0);
		s01_axi_full_buser	: out std_logic_vector(C_S01_AXI_FULL_BUSER_WIDTH-1 downto 0);
		s01_axi_full_bvalid	: out std_logic;
		s01_axi_full_bready	: in std_logic;
		s01_axi_full_arid	: in std_logic_vector(C_S01_AXI_FULL_ID_WIDTH-1 downto 0);
		s01_axi_full_araddr	: in std_logic_vector(C_S01_AXI_FULL_ADDR_WIDTH-1 downto 0);
		s01_axi_full_arlen	: in std_logic_vector(log2c(4*SIZE*SIZE)-1 downto 0);
		s01_axi_full_arsize	: in std_logic_vector(2 downto 0);
		s01_axi_full_arburst: in std_logic_vector(1 downto 0);
		s01_axi_full_arlock	: in std_logic;
		s01_axi_full_arcache	: in std_logic_vector(3 downto 0);
		s01_axi_full_arprot	: in std_logic_vector(2 downto 0);
		s01_axi_full_arqos	: in std_logic_vector(3 downto 0);
		s01_axi_full_arregion	: in std_logic_vector(3 downto 0);
		s01_axi_full_aruser	: in std_logic_vector(C_S01_AXI_FULL_ARUSER_WIDTH-1 downto 0);
		s01_axi_full_arvalid	: in std_logic;
		s01_axi_full_arready	: out std_logic;
		s01_axi_full_rid	: out std_logic_vector(C_S01_AXI_FULL_ID_WIDTH-1 downto 0);
		s01_axi_full_rdata	: out std_logic_vector(C_S01_AXI_FULL_DATA_WIDTH-1 downto 0);
		s01_axi_full_rresp	: out std_logic_vector(1 downto 0);
		s01_axi_full_rlast	: out std_logic;
		s01_axi_full_ruser	: out std_logic_vector(C_S01_AXI_FULL_RUSER_WIDTH-1 downto 0);
		s01_axi_full_rvalid	: out std_logic;
		s01_axi_full_rready	: in std_logic
		
		--en_rnew_ss: out std_logic
	);
end IP_ZOOM_AXI_v1_0_150x150;

architecture arch_imp of IP_ZOOM_AXI_v1_0_150x150 is
    --signal reset_s :    std_logic;   
         -- Interface to the AXI controllers   
         signal reg_data_s     : std_logic_vector(log2c(SIZE)-1 downto 0);   
         signal row_wr_s       : std_logic;
         signal col_wr_s       : std_logic;      
         signal cmd_wr_s       : std_logic;
         signal controlR_s   : std_logic;
         signal col_axi_s    : std_logic_vector(log2c(SIZE)-1 downto 0);
         signal row_axi_s    : std_logic_vector(log2c(SIZE)-1 downto 0);
         signal cmd_axi_s    : std_logic;   
         signal status_axi_s : std_logic;
          
        
         signal mem_addr_s : std_logic_vector(log2c(SIZE*SIZE)+2 downto 0);    
         signal mem_data_s  : std_logic_vector(32-1 downto 0);   
         signal mem_wr_s     : std_logic; 
        
         signal r_axi_data_s : std_logic_vector(log2c(WIDTH)-1 downto 0);   
         signal rnew_axi_data_s : std_logic_vector(log2c(WIDTH)-1 downto 0);   
          
        
         -- Interface to the matrix multiply module   
         signal row_s      : std_logic_vector(log2c(SIZE)-1 downto 0);  
         signal col_s      : std_logic_vector(log2c(SIZE)-1 downto 0);   
         signal start_s    : std_logic;   
         signal ready_s    : std_logic; 
        
         signal r_addr_s     : std_logic_vector(log2c(SIZE*SIZE) downto 0);   
         signal r_wr_s       : std_logic;   
         signal r_data_s     : std_logic_vector(log2c(WIDTH)-1 downto 0); 
        
         signal rnew_addr_s     : std_logic_vector(log2c(SIZE*SIZE)+1 downto 0);  
         signal rnew_wr_s       : std_logic;   
         signal rnew_data_s     : std_logic_vector(log2c(WIDTH)-1 downto 0);
         
         
	-- component declaration
	component IP_ZOOM_AXI_v1_0_S00_AXI_LITE_150x150 is
		generic (
            WIDTH  : integer := 256;
            SIZE   : integer:=3;
            C_S_AXI_DATA_WIDTH	: integer	:= 32;
            C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		    reg_data_o 		: out  std_logic_vector(log2c(SIZE)-1 downto 0);
            col_wr_o        : out  std_logic;     
            row_wr_o        : out  std_logic;          
            cmd_wr_o        : out  std_logic;
                    
            col_axi_i       : in std_logic_vector(log2c(SIZE)-1 downto 0);    
            row_axi_i       : in std_logic_vector(log2c(SIZE)-1 downto 0);        
            cmd_axi_i       : in std_logic;     
            status_axi_i    : in std_logic;
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component IP_ZOOM_AXI_v1_0_S00_AXI_LITE_150x150;

	component IP_ZOOM_AXI_v1_0_S01_AXI_FULL_150x150 is
		generic (
		WIDTH : integer   := 256;     
        SIZE   : integer := 3;
		C_S_AXI_ID_WIDTH	: integer	:= 1;
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 20;
		C_S_AXI_AWUSER_WIDTH	: integer	:= 1;
		C_S_AXI_ARUSER_WIDTH	: integer	:= 1;
		C_S_AXI_WUSER_WIDTH	: integer	:= 1;
		C_S_AXI_RUSER_WIDTH	: integer	:= 1;
		C_S_AXI_BUSER_WIDTH	: integer	:= 1
		);
		port (
		mem_addr_o  : out  std_logic_vector(log2c(SIZE*SIZE)+2 downto 0);     
        --mem_data_o  : out  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        mem_data_o  : out  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);     
        mem_wr_o    : out  std_logic; 
                
        r_axi_data_i: in std_logic_vector(log2c(WIDTH)-1 downto 0);     
        rnew_axi_data_i: in std_logic_vector(log2c(WIDTH)-1 downto 0);
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWLEN	: in std_logic_vector(log2c(4*SIZE*SIZE)-3 downto 0);
		S_AXI_AWSIZE	: in std_logic_vector(2 downto 0);
		S_AXI_AWBURST	: in std_logic_vector(1 downto 0);
		S_AXI_AWLOCK	: in std_logic;
		S_AXI_AWCACHE	: in std_logic_vector(3 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWQOS	: in std_logic_vector(3 downto 0);
		S_AXI_AWREGION	: in std_logic_vector(3 downto 0);
		S_AXI_AWUSER	: in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WLAST	: in std_logic;
		S_AXI_WUSER	: in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BID	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BUSER	: out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARLEN	: in std_logic_vector(log2c(4*SIZE*SIZE)-1 downto 0);
		S_AXI_ARSIZE	: in std_logic_vector(2 downto 0);
		S_AXI_ARBURST	: in std_logic_vector(1 downto 0);
		S_AXI_ARLOCK	: in std_logic;
		S_AXI_ARCACHE	: in std_logic_vector(3 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARQOS	: in std_logic_vector(3 downto 0);
		S_AXI_ARREGION	: in std_logic_vector(3 downto 0);
		S_AXI_ARUSER	: in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RID	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RLAST	: out std_logic;
		S_AXI_RUSER	: out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component IP_ZOOM_AXI_v1_0_S01_AXI_FULL_150x150;

begin

-- Instantiation of Axi Bus Interface S00_AXI_LITE
IP_ZOOM_AXI_v1_0_S00_AXI_LITE_inst : IP_ZOOM_AXI_v1_0_S00_AXI_LITE_150x150
	generic map (
	    WIDTH  => WIDTH,
        SIZE   => SIZE,
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_LITE_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_LITE_ADDR_WIDTH
	)
	port map (
	       
		S_AXI_ACLK	=> s00_axi_lite_aclk,
		S_AXI_ARESETN	=> s00_axi_lite_aresetn,
		S_AXI_AWADDR	=> s00_axi_lite_awaddr,
		S_AXI_AWPROT	=> s00_axi_lite_awprot,
		S_AXI_AWVALID	=> s00_axi_lite_awvalid,
		S_AXI_AWREADY	=> s00_axi_lite_awready,
		S_AXI_WDATA	=> s00_axi_lite_wdata,
		S_AXI_WSTRB	=> s00_axi_lite_wstrb,
		S_AXI_WVALID	=> s00_axi_lite_wvalid,
		S_AXI_WREADY	=> s00_axi_lite_wready,
		S_AXI_BRESP	=> s00_axi_lite_bresp,
		S_AXI_BVALID	=> s00_axi_lite_bvalid,
		S_AXI_BREADY	=> s00_axi_lite_bready,
		S_AXI_ARADDR	=> s00_axi_lite_araddr,
		S_AXI_ARPROT	=> s00_axi_lite_arprot,
		S_AXI_ARVALID	=> s00_axi_lite_arvalid,
		S_AXI_ARREADY	=> s00_axi_lite_arready,
		S_AXI_RDATA	=> s00_axi_lite_rdata,
		S_AXI_RRESP	=> s00_axi_lite_rresp,
		S_AXI_RVALID	=> s00_axi_lite_rvalid,
		S_AXI_RREADY	=> s00_axi_lite_rready,
		        reg_data_o    => reg_data_s,      
                 row_wr_o     => row_wr_s,     
                 col_wr_o     => col_wr_s,         
                 cmd_wr_o     => cmd_wr_s,
                 row_axi_i       => row_axi_s,     
                 col_axi_i       => col_axi_s,          
                 cmd_axi_i     => cmd_axi_s,     
                 status_axi_i  => status_axi_s
	);

-- Instantiation of Axi Bus Interface S01_AXI_FULL
IP_ZOOM_AXI_v1_0_S01_AXI_FULL_inst : IP_ZOOM_AXI_v1_0_S01_AXI_FULL_150x150
	generic map (
	    WIDTH=>WIDTH,
        SIZE=>SIZE,
		C_S_AXI_ID_WIDTH	=> C_S01_AXI_FULL_ID_WIDTH,
		C_S_AXI_DATA_WIDTH	=> C_S01_AXI_FULL_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S01_AXI_FULL_ADDR_WIDTH,
		C_S_AXI_AWUSER_WIDTH	=> C_S01_AXI_FULL_AWUSER_WIDTH,
		C_S_AXI_ARUSER_WIDTH	=> C_S01_AXI_FULL_ARUSER_WIDTH,
		C_S_AXI_WUSER_WIDTH	=> C_S01_AXI_FULL_WUSER_WIDTH,
		C_S_AXI_RUSER_WIDTH	=> C_S01_AXI_FULL_RUSER_WIDTH,
		C_S_AXI_BUSER_WIDTH	=> C_S01_AXI_FULL_BUSER_WIDTH
	)
	port map (
	    mem_addr_o  =>mem_addr_s,    
        mem_data_o=>mem_data_s,    
        mem_wr_o    =>mem_wr_s, 
        r_axi_data_i   =>r_axi_data_s,    
        rnew_axi_data_i =>rnew_axi_data_s,
		S_AXI_ACLK	=> s01_axi_full_aclk,
		S_AXI_ARESETN	=> s01_axi_full_aresetn,
		S_AXI_AWID	=> s01_axi_full_awid,
		S_AXI_AWADDR	=> s01_axi_full_awaddr,
		S_AXI_AWLEN	=> s01_axi_full_awlen,
		S_AXI_AWSIZE	=> s01_axi_full_awsize,
		S_AXI_AWBURST	=> s01_axi_full_awburst,
		S_AXI_AWLOCK	=> s01_axi_full_awlock,
		S_AXI_AWCACHE	=> s01_axi_full_awcache,
		S_AXI_AWPROT	=> s01_axi_full_awprot,
		S_AXI_AWQOS	=> s01_axi_full_awqos,
		S_AXI_AWREGION	=> s01_axi_full_awregion,
		S_AXI_AWUSER	=> s01_axi_full_awuser,
		S_AXI_AWVALID	=> s01_axi_full_awvalid,
		S_AXI_AWREADY	=> s01_axi_full_awready,
		S_AXI_WDATA	=> s01_axi_full_wdata,
		S_AXI_WSTRB	=> s01_axi_full_wstrb,
		S_AXI_WLAST	=> s01_axi_full_wlast,
		S_AXI_WUSER	=> s01_axi_full_wuser,
		S_AXI_WVALID	=> s01_axi_full_wvalid,
		S_AXI_WREADY	=> s01_axi_full_wready,
		S_AXI_BID	=> s01_axi_full_bid,
		S_AXI_BRESP	=> s01_axi_full_bresp,
		S_AXI_BUSER	=> s01_axi_full_buser,
		S_AXI_BVALID	=> s01_axi_full_bvalid,
		S_AXI_BREADY	=> s01_axi_full_bready,
		S_AXI_ARID	=> s01_axi_full_arid,
		S_AXI_ARADDR	=> s01_axi_full_araddr,
		S_AXI_ARLEN	=> s01_axi_full_arlen,
		S_AXI_ARSIZE	=> s01_axi_full_arsize,
		S_AXI_ARBURST	=> s01_axi_full_arburst,
		S_AXI_ARLOCK	=> s01_axi_full_arlock,
		S_AXI_ARCACHE	=> s01_axi_full_arcache,
		S_AXI_ARPROT	=> s01_axi_full_arprot,
		S_AXI_ARQOS	=> s01_axi_full_arqos,
		S_AXI_ARREGION	=> s01_axi_full_arregion,
		S_AXI_ARUSER	=> s01_axi_full_aruser,
		S_AXI_ARVALID	=> s01_axi_full_arvalid,
		S_AXI_ARREADY	=> s01_axi_full_arready,
		S_AXI_RID	=> s01_axi_full_rid,
		S_AXI_RDATA	=> s01_axi_full_rdata,
		S_AXI_RRESP	=> s01_axi_full_rresp,
		S_AXI_RLAST	=> s01_axi_full_rlast,
		S_AXI_RUSER	=> s01_axi_full_ruser,
		S_AXI_RVALID	=> s01_axi_full_rvalid,
		S_AXI_RREADY	=> s01_axi_full_rready
	);

memory_subsystem: entity work.mem_subsystem_150x150(struct)     
	 generic map (       
	 WIDTH  => WIDTH,       
	 SIZE    => SIZE       
	 )     
	 port map (       
	 clk           => s00_axi_lite_aclk,       
	 reset         => reset_s,          
	 -- Interface to the AXI controllers       
	 reg_data_i    => reg_data_s,       
	 col_wr_i      => col_wr_s,       
	 row_wr_i      => row_wr_s,             
	 cmd_wr_i      => cmd_wr_s,
	 col_axi_o     => col_axi_s,       
	 row_axi_o     => row_axi_s,              
	 cmd_axi_o     => cmd_axi_s,       
	 status_axi_o  => status_axi_s,          
	 mem_addr_i    => mem_addr_s,       
	 mem_data_i    => mem_data_s(log2c(WIDTH)-1 downto 0),       
	 mem_wr_i      => mem_wr_s,          
	 rdata_axi_data_o  => r_axi_data_s,       
	 rnewdata_axi_data_o  => rnew_axi_data_s,              
	 -- Interface to the Zoom2 module       
	 col_o         => col_s,       
	 row_o         => row_s,             
	 start_o       => start_s,       
	 ready_i       => ready_s,          
	 r_addr_i      => r_addr_s,       
	 r_wr_i        => r_wr_s,       
	 r_data_o      => r_data_s,          
	 rnew_addr_i   => rnew_addr_s,       
	 rnew_wr_i     => rnew_wr_s,       
	 rnew_data_i   => rnew_data_s,
	 controlR      => controlR_s
	-- sel           => sel_s,
	-- en_rnew_ss    => en_rnew_ss
	 );

zoom2_ip: entity work.Zoom2_150x150(Behavioral)
 generic map (       
    WIDTHD  => WIDTH,       
    N    => SIZE,
    M    => SIZE       
    )     
    port map (       
    clk           => s00_axi_lite_aclk,       
    reset         => reset_s,                        
    -- Interface to the submemory module       
    col           => col_s,       
    row           => row_s,             
    start       => start_s,       
    ready       => ready_s,          
    Raddress    => r_addr_s,       
    RWR        => r_wr_s,       
    Rdata      => r_data_s,          
    Rnewaddress   => rnew_addr_s,       
    RnewWR        => rnew_wr_s,       
    Rnewdata      => rnew_data_s,
    controlR      => controlR_s
    );  

	-- Add user logic here
    rnew_axi_data_port<=rnew_axi_data_s;            
	-- User logic ends

end arch_imp;
