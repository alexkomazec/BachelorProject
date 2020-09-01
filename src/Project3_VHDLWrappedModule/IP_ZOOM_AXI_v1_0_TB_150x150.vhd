
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

use STD.textio.all;
use ieee.std_logic_textio.all;
 
 
use work.utils_pkg.all; 
 
entity IP_ZOOM_AXI_v1_0_TB_150x150 is
--  Port ( );
end IP_ZOOM_AXI_v1_0_TB_150x150;  
 
architecture Behavioral of IP_ZOOM_AXI_v1_0_TB_150x150 is   
constant DATA_WIDTH_c : integer := 256;   
constant SIZE_c  : integer := 150;   
constant N_c  : integer := 150;   
constant M_c  : integer := 150;   
constant N_Rnew_c  : integer := 2*N_c;   
constant M_Rnew_c  : integer := 2*M_c;     
type mem_t is array (0 to N_c*M_c-1) of std_logic_vector(log2c(DATA_WIDTH_c)-1 downto 0);       
type mem_rnew is array (0 to N_Rnew_c*M_Rnew_c-1) of std_logic_vector(log2c(DATA_WIDTH_c)-1 downto 0); 

signal MEM_R_CONTENT_c: mem_t :=(others => ( others => '1'));  
signal MEM_Rnew_CONTENT_c: mem_rnew := (others => (others => '0'));
      
signal clk_s: std_logic;   
signal reset_s: std_logic; 
 
  -- Matrix multiplier core's address map   
  constant COL_REG_ADDR_C      : integer  := 0;   
  constant ROW_REG_ADDR_C     : integer  := 4;   
  --constant P_REG_ADDR_C      : integer  := 8;   
  constant CMD_REG_ADDR_C : integer  := 8;   
  constant STATUS_REG_ADDR_C : integer  := 12;     
  -- Matrix multiplier internal memory map   
  constant MEMORY_R_OFFSET_C : integer  := 0;   
  constant MEMORY_C_OFFSET_C : integer  := 524288; --Max value for the last bit is 1. 20th bit (18+2)        
------------------- AXI Interfaces signals -------------------   
-- Parameters of Axi-Lite Slave Bus Interface S00_AXI   
constant C_S00_AXI_DATA_WIDTH_c : integer  := 32;   
constant C_S00_AXI_ADDR_WIDTH_c  : integer  := 4;      
-- Parameters of Axi-Full Slave Bus Interface S01_AXI   
constant C_S01_AXI_ID_WIDTH_c      : integer  := 1;   
constant C_S01_AXI_DATA_WIDTH_c  : integer  := 32;   
constant C_S01_AXI_ADDR_WIDTH_c  : integer  := 20;   
constant C_S01_AXI_AWUSER_WIDTH_c  : integer  := 1;   
constant C_S01_AXI_ARUSER_WIDTH_c   : integer  := 1;   
constant C_S01_AXI_WUSER_WIDTH_c    : integer  := 1;   
constant C_S01_AXI_RUSER_WIDTH_c     : integer  := 1;   
constant C_S01_AXI_BUSER_WIDTH_c     : integer  := 1; 
 --signal en_rnew_ss: std_logic;
  -- Ports of Axi-Lite Slave Bus Interface S01_AXI   
  --signal s00_axi_aclk_s   : std_logic := '0';   
  --signal sel_s             : std_logic;
  signal s00_axi_aresetn_s : std_logic := '1';   
  signal s00_axi_awaddr_s   : std_logic_vector(C_S00_AXI_ADDR_WIDTH_c-1 downto 0) := (others => '0');   
  signal s00_axi_awprot_s   : std_logic_vector(2 downto 0) := (others => '0');   
  signal s00_axi_awvalid_s : std_logic := '0';   
  signal s00_axi_awready_s : std_logic := '0';   
  signal s00_axi_wdata_s   : std_logic_vector(C_S00_AXI_DATA_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s00_axi_wstrb_s   : std_logic_vector((C_S00_AXI_DATA_WIDTH_c/8)-1 downto 0)      := (others => '0');   
  signal s00_axi_wvalid_s   : std_logic := '0';   
  signal s00_axi_wready_s   : std_logic := '0';   
  signal s00_axi_bresp_s   : std_logic_vector(1 downto 0) := (others => '0');   
  signal s00_axi_bvalid_s   : std_logic := '0';   
  signal s00_axi_bready_s   : std_logic := '0';   
  signal s00_axi_araddr_s  : std_logic_vector(C_S00_AXI_ADDR_WIDTH_c-1 downto 0)     := (others => '0');   
  signal s00_axi_arprot_s   : std_logic_vector(2 downto 0) := (others => '0');   
  signal s00_axi_arvalid_s : std_logic := '0';   
  signal s00_axi_arready_s : std_logic := '0';   
  signal s00_axi_rdata_s   : std_logic_vector(C_S00_AXI_DATA_WIDTH_c-1 downto 0) := (others => '0');   
  signal s00_axi_rresp_s   : std_logic_vector(1 downto 0) := (others => '0');   
  signal s00_axi_rvalid_s   : std_logic := '0';   
  signal s00_axi_rready_s   : std_logic := '0';      
  -- Ports of Axi-Full Slave Bus Interface S01_AXI   
  --signal s01_axi_aclk_s   : std_logic := '0';   
  signal s01_axi_aresetn_s : std_logic := '1';   
  signal s01_axi_awid_s   : std_logic_vector(C_S01_AXI_ID_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_awaddr_s   : std_logic_vector(C_S01_AXI_ADDR_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_awlen_s   : std_logic_vector(log2c(4*M_c*N_c)-3 downto 0) := (others => '0');   
  signal s01_axi_awsize_s   : std_logic_vector(2 downto 0) := (others => '0');   
  signal s01_axi_awburst_s : std_logic_vector(1 downto 0) := (others => '0');   
  signal s01_axi_awlock_s   : std_logic := '0';   
  signal s01_axi_awcache_s : std_logic_vector(3 downto 0) := (others => '0');   
  signal s01_axi_awprot_s   : std_logic_vector(2 downto 0) := (others => '0');   
  signal s01_axi_awqos_s   : std_logic_vector(3 downto 0) := (others => '0'); 
  signal s01_axi_awregion_s : std_logic_vector(3 downto 0) := (others => '0');   
  signal s01_axi_awuser_s   : std_logic_vector(C_S01_AXI_AWUSER_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_awvalid_s : std_logic := '0';  
  signal s01_axi_awready_s : std_logic := '0';  
  signal s01_axi_wdata_s   : std_logic_vector(C_S01_AXI_DATA_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_wstrb_s   : std_logic_vector((C_S01_AXI_DATA_WIDTH_c/8)-1 downto 0)      := (others => '0');   
  signal s01_axi_wlast_s   : std_logic := '0';   
  signal s01_axi_wuser_s  : std_logic_vector(C_S01_AXI_WUSER_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_wvalid_s   : std_logic := '0';   
  signal s01_axi_wready_s   : std_logic := '0';   
  signal s01_axi_bid_s   : std_logic_vector(C_S01_AXI_ID_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_bresp_s   : std_logic_vector(1 downto 0) := (others => '0');   
  signal s01_axi_buser_s   : std_logic_vector(C_S01_AXI_BUSER_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_bvalid_s   : std_logic := '0';   
  signal s01_axi_bready_s   : std_logic := '0';   
  signal s01_axi_arid_s   : std_logic_vector(C_S01_AXI_ID_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_araddr_s   : std_logic_vector(C_S01_AXI_ADDR_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_arlen_s   : std_logic_vector(log2c(4*M_c*N_c)-1 downto 0) := (others => '0');   
  signal s01_axi_arsize_s   : std_logic_vector(2 downto 0) := (others => '0');   
  signal s01_axi_arburst_s : std_logic_vector(1 downto 0) := (others => '0');   
  signal s01_axi_arlock_s   : std_logic := '0';   
  signal s01_axi_arcache_s : std_logic_vector(3 downto 0) := (others => '0');   
  signal s01_axi_arprot_s   : std_logic_vector(2 downto 0) := (others => '0');   
  signal s01_axi_arqos_s   : std_logic_vector(3 downto 0) := (others => '0');   
  signal s01_axi_arregion_s : std_logic_vector(3 downto 0) := (others => '0');   
  signal s01_axi_aruser_s   : std_logic_vector(C_S01_AXI_ARUSER_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_arvalid_s : std_logic := '0';   signal s01_axi_arready_s : std_logic := '0';   
  signal s01_axi_rid_s   : std_logic_vector(C_S01_AXI_ID_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_rdata_s   : std_logic_vector(C_S01_AXI_DATA_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_rresp_s   : std_logic_vector(1 downto 0) := (others => '0');  
  signal s01_axi_rlast_s   : std_logic := '0';   
  signal s01_axi_ruser_s   : std_logic_vector(C_S01_AXI_RUSER_WIDTH_c-1 downto 0)      := (others => '0');   
  signal s01_axi_rvalid_s   : std_logic := '0';   
  signal s01_axi_rready_s   : std_logic := '0';

  shared variable acounter: integer:=1; 

  signal axi_read_data_v : std_logic_vector(31 downto 0);
    signal rnew_axi_data_s: std_logic_vector(log2c(DATA_WIDTH_c)-1 DOWNTO 0);  
        file file_VECTOR1 : text;
        file file_VECTOR2 : text;
        file file_VECTOR3 : text;
        
        file file_RESULTS1 : text;
        file file_RESULTS2 : text;
        file file_RESULTS3 : text;

  begin   
  
  
  clk_gen: process	   
	  begin
		clk_s <= '0', '1' after 100 ns;
	  wait for 200 ns;   
  end process; 

   
  
  stimulus_generator: process
   variable v_ILINE     : line;
   variable v_OLINE     : line;
   variable v_ADD_TERM1 : std_logic_vector(log2c(DATA_WIDTH_c)-1 downto 0);    
      
  variable transfer_size_v : integer;   
  begin
         file_open(file_VECTOR1, "C:\Users\aleks\Desktop\Diplomski\PSDS\AXI150x150\FirstDim.txt",  read_mode);  
         file_open(file_VECTOR2, "C:\Users\aleks\Desktop\Diplomski\PSDS\AXI150x150\SecondDim.txt",  read_mode);
         file_open(file_VECTOR3, "C:\Users\aleks\Desktop\Diplomski\PSDS\AXI150x150\ThirdDim.txt",  read_mode);
         
         file_open(file_RESULTS1, "C:\Users\aleks\Desktop\Diplomski\PSDS\AXI150x150\FirstDimnew.txt",  write_mode);
         file_open(file_RESULTS2, "C:\Users\aleks\Desktop\Diplomski\PSDS\AXI150x150\SecondDimNew.txt",  write_mode);
         file_open(file_RESULTS3, "C:\Users\aleks\Desktop\Diplomski\PSDS\AXI150x150\ThirdDimNew.txt",  write_mode); 
  -- Apply system level reset     
		reset_s <= '1';
		     
		wait for 200 ns;     
		reset_s <= '0';     
		wait until falling_edge(clk_s);
  
  ----------------------------------FIRST MATRIX--------------------------
  for j in 0 to M_c-1  loop                  
          for i in 0 to N_c-1 loop
              readline(file_VECTOR1, v_ILINE);
              read(v_ILINE, v_ADD_TERM1);         
              MEM_R_CONTENT_c(i*N_c+j) <=v_ADD_TERM1 ;
                      wait until falling_edge(clk_s);       
              end loop;                 
            end loop;
		
  -- reset AXI-lite interface. Reset will be 10 clock cycles wide 
  --sel_s<='0';
   s00_axi_aresetn_s <= '0';     
   -- wait for 5 falling edges of AXI-lite clock signal    
   for i in 1 to 5 loop      
   wait until falling_edge(clk_s);     
   end loop;     
   -- release reset         
   s00_axi_aresetn_s <= '1';     
   wait until falling_edge(clk_s);         
   ----------------------------------------------------------------------     --               Initialize the Matrix Multiplier core                 --     ----------------------------------------------------------------------     
  -- report "Loading the matrix dimensions information into the Zoom2 core!";     
   -- Set the value for the first dimension (parameter COL) of matrix R and RNEW     
   wait until falling_edge(clk_s);     
   s00_axi_awaddr_s  <= conv_std_logic_vector(COL_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
   s00_axi_awvalid_s <= '1';     
   s00_axi_wdata_s  <= conv_std_logic_vector(N_c, C_S00_AXI_DATA_WIDTH_c);     
   s00_axi_wvalid_s  <= '1';     
   s00_axi_wstrb_s  <= "1111";     
   s00_axi_bready_s  <= '1';     
   wait until s00_axi_awready_s = '1';     
   wait until s00_axi_awready_s = '0';     
   wait until falling_edge(clk_s);     
   s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);--3 downto 0     
   s00_axi_awvalid_s  <= '0';     
   s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
   s00_axi_wvalid_s  <= '0';     
   s00_axi_wstrb_s  <= "0000";     
   wait until s00_axi_bvalid_s = '0';     
   wait until falling_edge(clk_s);            
   s00_axi_bready_s  <= '0';     
   wait until falling_edge(clk_s);        
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop      
	wait until falling_edge(clk_s);     
	end loop;          

  -- Set the value for the second dimension of matrix B and the first dimenzion of matrix Rnew (parameter P)    
  wait until falling_edge(clk_s);     
  s00_axi_awaddr_s  <= conv_std_logic_vector(ROW_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
  s00_axi_awvalid_s  <= '1';     
  s00_axi_wdata_s  <= conv_std_logic_vector(M_c, C_S00_AXI_DATA_WIDTH_c);     
  s00_axi_wvalid_s  <= '1';     
  s00_axi_wstrb_s  <= "1111";     
  s00_axi_bready_s  <= '1';     
  wait until s00_axi_awready_s = '1';     
  wait until s00_axi_awready_s = '0';     
  wait until falling_edge(clk_s);     
  s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);     
  s00_axi_awvalid_s  <= '0';     
  s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
  s00_axi_wvalid_s  <= '0';     
  s00_axi_wstrb_s  <= "0000";     
  wait until s00_axi_bvalid_s = '0';     
  wait until falling_edge(clk_s);            
  s00_axi_bready_s  <= '0';     
  wait until falling_edge(clk_s);
  
 
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);    
	end loop;
	
	-------------------------------------------------------------------------------------------     
	--    Load the element values for matrix R into the Zoom2 core    
	--     -------------------------------------------------------------------------------------------     
	report "Loading matrix R element values into the core!";
	  
	-- reset AXI4 interface. Reset will be 10 clock cycles wide     
	s01_axi_aresetn_s <= '0';     
	-- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);    
	end loop; 
    --report "release reset!";    
	-- release reset         
	s01_axi_aresetn_s <= '1';     
	wait until falling_edge(clk_s);          
	-- Write some data using AXI4 interface and burst mode     
	transfer_size_v := M_c*N_c;     
	wait until falling_edge(clk_s);     
	s01_axi_awaddr_s  <= conv_std_logic_vector(MEMORY_R_OFFSET_C, s01_axi_awaddr_s'length);
    --report "s01_axi_awaddr_s=1!";	
	-- Set the number of data that will be transfered in one burst     
	s01_axi_awlen_s  <= conv_std_logic_vector(transfer_size_v-1,log2c(4*M_c*N_c)-2 );      
	s01_axi_awsize_s  <= "010"; 
	-- Size of each transfer will be 4 bytes    
	s01_axi_awburst_s  <= "01";
    --report "Burst type will be INCR!";		
	-- Burst type will be "INCR"     
	s01_axi_awvalid_s  <= '1';     
	wait until s01_axi_awready_s = '1';     
	wait until s01_axi_awready_s = '0';     
	wait until falling_edge(clk_s);
   -- report "s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(0)), s01_axi_wdata_s'length);";
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(0)), s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '1';     
	s01_axi_wstrb_s  <= "1111";     
	s01_axi_wlast_s  <= '0';     
	s01_axi_bready_s  <= '1';     
	wait until s01_axi_wready_s = '1';    
	wait until falling_edge(clk_s);     
	wait until falling_edge(clk_s);
    --report "for data_counter in 1 to transfer_size_v-2 loop!";	
	for data_counter in 1 to transfer_size_v-2 loop       
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(data_counter)), s01_axi_wdata_s'length);       
	s01_axi_wvalid_s  <= '1';       
	s01_axi_wstrb_s  <= "1111";       
	s01_axi_wlast_s  <= '0';       
	s01_axi_bready_s  <= '1';       
	wait until falling_edge(clk_s);     
	end loop;
    --report "262";	
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(transfer_size_v-1)),s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '1';     
	s01_axi_wstrb_s  <= "1111";     
	s01_axi_wlast_s  <= '1';     
	s01_axi_bready_s  <= '1';    
	wait until falling_edge(clk_s);
	--report "269";
	s01_axi_wdata_s  <= conv_std_logic_vector(0, s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '0';     
	s01_axi_wstrb_s  <= "0000";     
	s01_axi_wlast_s  <= '0';     
	s01_axi_awaddr_s  <= conv_std_logic_vector(0, s01_axi_awaddr_s'length);     
	s01_axi_awlen_s  <= (others => '0');     
	s01_axi_awburst_s  <= "00";    
	s01_axi_awvalid_s  <= '0'; 
    --report "278";
	if (s01_axi_bvalid_s = '1') then       
	wait until s01_axi_bvalid_s = '0';     
	else       
	wait until s01_axi_bvalid_s = '1';       
	wait until s01_axi_bvalid_s = '0';     
	end if;     
	wait until falling_edge(clk_s);            
	s01_axi_bready_s <= '0'; 
 
    
  
    -------------------------------------------------------------------------------------------     
	--                       Start the Zoom2 core                    
	--     -------------------------------------------------------------------------------------------     
	--report "Starting the Zoom2 core!";    
	-- Set the value start bit (bit 0 in the CMD register) to 1     
	wait until falling_edge(clk_s);
 --sel_s<='1'; 
	s00_axi_awaddr_s  <= conv_std_logic_vector(CMD_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '1';
    s00_axi_wdata_s  <= conv_std_logic_vector(1, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '1';     
	s00_axi_wstrb_s  <= "1111";     
	s00_axi_bready_s  <= '1';     
	wait until s00_axi_awready_s = '1';     
	wait until s00_axi_awready_s = '0';     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '0';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '0';     
	s00_axi_wstrb_s  <= "0000";     
	wait until s00_axi_bvalid_s = '0';     
	wait until falling_edge(clk_s);            
	s00_axi_bready_s  <= '0';     
	wait until falling_edge(clk_s);        
 
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);     
	end loop;          
	--report "Clearing the start bit!";     
	-- Set the value start bit (bit 0 in the CMD register) to 0     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(CMD_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '1';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '1';     
	s00_axi_wstrb_s  <= "1111";     
	s00_axi_bready_s  <= '1';    
	wait until s00_axi_awready_s = '1';     
	wait until s00_axi_awready_s = '0';     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);    
	s00_axi_awvalid_s  <= '0';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '0';     
	s00_axi_wstrb_s  <= "0000";    
	wait until s00_axi_bvalid_s = '0';     
	wait until falling_edge(clk_s);            
	s00_axi_bready_s  <= '0';     
	wait until falling_edge(clk_s);        
 

    -------------------------------------------------------------------------------------------     
	--          Wait until  Zoom2 core finishes the process       
	--     -------------------------------------------------------------------------------------------     
	--report "Waiting for the Zoom2  process to complete!";  
	
	loop       
	-- Read the content of the Status register       
	wait until falling_edge(clk_s);       
	s00_axi_araddr_s  <= conv_std_logic_vector(STATUS_REG_ADDR_C, 4);       
	s00_axi_arvalid_s <= '1';       
	s00_axi_rready_s  <= '1'; 
   -- report "s00_axi_araddr_s  <= conv_std_logic_vector(STATUS_REG_ADDR_C, 4); etc...";	
	wait until s00_axi_arready_s = '1';       
	axi_read_data_v  <= s00_axi_rdata_s; 
   -- report "axi_read_data_v  := s00_axi_rdata_s;";	
	wait until s00_axi_arready_s = '0';       
	wait until falling_edge(clk_s);
    s00_axi_araddr_s  <= conv_std_logic_vector(0, 4);       
	s00_axi_arvalid_s <= '0';       
	s00_axi_rready_s  <= '0';
   -- report "s00_axi_araddr_s  <= conv_std_logic_vector(0, 4), etc...";	
	-- Check is the 1st bit of the Status register set to one       
	if (axi_read_data_v(0) = '1') then
  --  report "axi_read_data_v(0) = '1'";	
	-- Zoom2 process completed         
	exit;       
	else         
	wait for 1000 ns;       
	end if;     
	end loop;
    --report "Zoom2 process completed ";	
	-------------------------------------------------------------------------------------------     
	--           Read the elements of Rnew from the Zoom2      
	--     -------------------------------------------------------------------------------------------     
	--report "Reading the results of the Zoom2 process!";     
	-- Read some data using AXI4 interface     
	transfer_size_v  := 4*N_c*M_c;
   -- report "transfer_size_v  := 4*N_c*M_c;";	
	wait until falling_edge(clk_s);     
	s01_axi_araddr_s  <= conv_std_logic_vector(MEMORY_C_OFFSET_C, s01_axi_araddr_s'length);
    --report "s01_axi_araddr_s  <= conv_std_logic_vector(MEMORY_C_OFFSET_C, s01_axi_araddr_s'length);";	
	-- Set the number of data that will be transfered in one burst     
	s01_axi_arlen_s  <= conv_std_logic_vector(transfer_size_v-1, log2c(4*M_c*N_c));
  --  report "s01_axi_arlen_s  <= conv_std_logic_vector(transfer_size_v-1, log2c(4*M_c*N_c));";	
	s01_axi_arsize_s  <= "010";
    --report "s01_axi_arsize_s  <= 010";	
	-- Size of each transfer will be 4 bytes     
	s01_axi_arburst_s  <= "01";
   -- report "s01_axi_arburst_s  <= 01";	
	-- Burst type will be "INCR"     
	s01_axi_arvalid_s  <= '1';
   -- report "s01_axi_arvalid_s  <= '1';";	
	s01_axi_rready_s  <= '1';
   -- report "s01_axi_rready_s  <= '1';";	
	wait until s01_axi_arready_s = '1';
	--report "wait until s01_axi_arready_s = '1';";
	wait until s01_axi_arready_s = '0';
   -- report "wait until s01_axi_arready_s = '0';";	
	wait until falling_edge(clk_s);
	--report "wait until falling_edge(clk_s);";
	s01_axi_araddr_s  <= conv_std_logic_vector(0, s01_axi_araddr_s'length);
    --report "s01_axi_araddr_s  <= conv_std_logic_vector(0, s01_axi_araddr_s'length);";	
	s01_axi_arlen_s  <= (others => '0');
   -- report "s01_axi_arlen_s  <= (others => '0');";	
	s01_axi_arburst_s  <= "00";
   -- report "s01_axi_arburst_s  <= 00";	
	s01_axi_arvalid_s  <= '0';
    --report "s01_axi_arvalid_s  <= '0';";	
	 for data_counter in 0 to (N_Rnew_c*M_Rnew_c)-2 loop	
		acounter:=data_counter;
			MEM_Rnew_CONTENT_c(conv_integer(acounter))<=rnew_axi_data_s;
		  wait until s01_axi_rvalid_s = '1'; 

		  report "wait until s01_axi_rvalid_s = '1'; ";	
		  wait until s01_axi_rvalid_s = '0'; 
		  report "wait until s01_axi_rvalid_s = '0';  ";
	
		  wait until falling_edge(clk_s);
		  report "wait until falling_edge(clk_s); ";
		--assert data_counter = transfer_size_v-1 report "expected value. data_counter = " & integer'image(data_counter);
	  end loop; 
	  
	  MEM_Rnew_CONTENT_c(conv_integer(N_Rnew_c*M_Rnew_c-1))<=rnew_axi_data_s;
	report "-- end loop; ";
	
    for i in 0 to N_Rnew_c-1  loop                  
            for j in 0 to M_Rnew_c-1 loop
			    report "write(v_OLINE, conv_integer(MEM_Rnew_CONTENT_c(i*N_Rnew_c+j)));  ";
                write(v_OLINE, conv_integer(MEM_Rnew_CONTENT_c(i*N_Rnew_c+j)));
                report "write(v_OLINE,' '); ";				
               write(v_OLINE,' ');
               wait until falling_edge(clk_s);       
             end loop; 
             writeline(file_RESULTS1, v_OLINE);                
      end loop;	
	  
	report "-- end loop; ";
	wait until falling_edge(clk_s);
	report "wait until falling_edge(clk_s);";
	s01_axi_rready_s  <= '0'; 
    report "s01_axi_rready_s  <= '0';";
    -- End of the test 
    -- report "-- End of the test ";    

	
	----------------------------------------------------------------------------------------------
	----------------------------------SECOND MATRIX-----------------------------------------------
	----------------------------------------------------------------------------------------------
  for j in 0 to M_c-1  loop                  
          for i in 0 to N_c-1 loop
              readline(file_VECTOR2, v_ILINE);
              read(v_ILINE, v_ADD_TERM1);         
              MEM_R_CONTENT_c(i*N_c+j) <=v_ADD_TERM1 ;
                      wait until falling_edge(clk_s);       
              end loop;                 
            end loop;
		
  -- reset AXI-lite interface. Reset will be 10 clock cycles wide 
  --sel_s<='0';
   s00_axi_aresetn_s <= '0';     
   -- wait for 5 falling edges of AXI-lite clock signal    
   for i in 1 to 5 loop      
   wait until falling_edge(clk_s);     
   end loop;     
   -- release reset         
   s00_axi_aresetn_s <= '1';     
   wait until falling_edge(clk_s);         
   ----------------------------------------------------------------------     --               Initialize the Matrix Multiplier core                 --     ----------------------------------------------------------------------     
  -- report "Loading the matrix dimensions information into the Zoom2 core!";     
   -- Set the value for the first dimension (parameter COL) of matrix R and RNEW     
   wait until falling_edge(clk_s);     
   s00_axi_awaddr_s  <= conv_std_logic_vector(COL_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
   s00_axi_awvalid_s <= '1';     
   s00_axi_wdata_s  <= conv_std_logic_vector(N_c, C_S00_AXI_DATA_WIDTH_c);     
   s00_axi_wvalid_s  <= '1';     
   s00_axi_wstrb_s  <= "1111";     
   s00_axi_bready_s  <= '1';     
   wait until s00_axi_awready_s = '1';     
   wait until s00_axi_awready_s = '0';     
   wait until falling_edge(clk_s);     
   s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);--3 downto 0     
   s00_axi_awvalid_s  <= '0';     
   s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
   s00_axi_wvalid_s  <= '0';     
   s00_axi_wstrb_s  <= "0000";     
   wait until s00_axi_bvalid_s = '0';     
   wait until falling_edge(clk_s);            
   s00_axi_bready_s  <= '0';     
   wait until falling_edge(clk_s);        
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop      
	wait until falling_edge(clk_s);     
	end loop;          

  -- Set the value for the second dimension of matrix B and the first dimenzion of matrix Rnew (parameter P)    
  wait until falling_edge(clk_s);     
  s00_axi_awaddr_s  <= conv_std_logic_vector(ROW_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
  s00_axi_awvalid_s  <= '1';     
  s00_axi_wdata_s  <= conv_std_logic_vector(M_c, C_S00_AXI_DATA_WIDTH_c);     
  s00_axi_wvalid_s  <= '1';     
  s00_axi_wstrb_s  <= "1111";     
  s00_axi_bready_s  <= '1';     
  wait until s00_axi_awready_s = '1';     
  wait until s00_axi_awready_s = '0';     
  wait until falling_edge(clk_s);     
  s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);     
  s00_axi_awvalid_s  <= '0';     
  s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
  s00_axi_wvalid_s  <= '0';     
  s00_axi_wstrb_s  <= "0000";     
  wait until s00_axi_bvalid_s = '0';     
  wait until falling_edge(clk_s);            
  s00_axi_bready_s  <= '0';     
  wait until falling_edge(clk_s);
  
 
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);    
	end loop;
	
	-------------------------------------------------------------------------------------------     
	--    Load the element values for matrix R into the Zoom2 core    
	--     -------------------------------------------------------------------------------------------     
	report "Loading matrix R element values into the core!";
	  
	-- reset AXI4 interface. Reset will be 10 clock cycles wide     
	s01_axi_aresetn_s <= '0';     
	-- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);    
	end loop; 
    --report "release reset!";    
	-- release reset         
	s01_axi_aresetn_s <= '1';     
	wait until falling_edge(clk_s);          
	-- Write some data using AXI4 interface and burst mode     
	transfer_size_v := M_c*N_c;     
	wait until falling_edge(clk_s);     
	s01_axi_awaddr_s  <= conv_std_logic_vector(MEMORY_R_OFFSET_C, s01_axi_awaddr_s'length);
    --report "s01_axi_awaddr_s=1!";	
	-- Set the number of data that will be transfered in one burst     
	s01_axi_awlen_s  <= conv_std_logic_vector(transfer_size_v-1,log2c(4*M_c*N_c)-2 );      
	s01_axi_awsize_s  <= "010"; 
	-- Size of each transfer will be 4 bytes    
	s01_axi_awburst_s  <= "01";
    --report "Burst type will be INCR!";		
	-- Burst type will be "INCR"     
	s01_axi_awvalid_s  <= '1';     
	wait until s01_axi_awready_s = '1';     
	wait until s01_axi_awready_s = '0';     
	wait until falling_edge(clk_s);
   -- report "s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(0)), s01_axi_wdata_s'length);";
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(0)), s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '1';     
	s01_axi_wstrb_s  <= "1111";     
	s01_axi_wlast_s  <= '0';     
	s01_axi_bready_s  <= '1';     
	wait until s01_axi_wready_s = '1';    
	wait until falling_edge(clk_s);     
	wait until falling_edge(clk_s);
    --report "for data_counter in 1 to transfer_size_v-2 loop!";	
	for data_counter in 1 to transfer_size_v-2 loop       
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(data_counter)), s01_axi_wdata_s'length);       
	s01_axi_wvalid_s  <= '1';       
	s01_axi_wstrb_s  <= "1111";       
	s01_axi_wlast_s  <= '0';       
	s01_axi_bready_s  <= '1';       
	wait until falling_edge(clk_s);     
	end loop;
    --report "262";	
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(transfer_size_v-1)),s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '1';     
	s01_axi_wstrb_s  <= "1111";     
	s01_axi_wlast_s  <= '1';     
	s01_axi_bready_s  <= '1';    
	wait until falling_edge(clk_s);
	--report "269";
	s01_axi_wdata_s  <= conv_std_logic_vector(0, s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '0';     
	s01_axi_wstrb_s  <= "0000";     
	s01_axi_wlast_s  <= '0';     
	s01_axi_awaddr_s  <= conv_std_logic_vector(0, s01_axi_awaddr_s'length);     
	s01_axi_awlen_s  <= (others => '0');     
	s01_axi_awburst_s  <= "00";    
	s01_axi_awvalid_s  <= '0'; 
    --report "278";
	if (s01_axi_bvalid_s = '1') then       
	wait until s01_axi_bvalid_s = '0';     
	else       
	wait until s01_axi_bvalid_s = '1';       
	wait until s01_axi_bvalid_s = '0';     
	end if;     
	wait until falling_edge(clk_s);            
	s01_axi_bready_s <= '0'; 
 
    
  
    -------------------------------------------------------------------------------------------     
	--                       Start the Zoom2 core                    
	--     -------------------------------------------------------------------------------------------     
	--report "Starting the Zoom2 core!";    
	-- Set the value start bit (bit 0 in the CMD register) to 1     
	wait until falling_edge(clk_s);
     --sel_s<='1'; 
	s00_axi_awaddr_s  <= conv_std_logic_vector(CMD_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '1';
    s00_axi_wdata_s  <= conv_std_logic_vector(1, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '1';     
	s00_axi_wstrb_s  <= "1111";     
	s00_axi_bready_s  <= '1';     
	wait until s00_axi_awready_s = '1';     
	wait until s00_axi_awready_s = '0';     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '0';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '0';     
	s00_axi_wstrb_s  <= "0000";     
	wait until s00_axi_bvalid_s = '0';     
	wait until falling_edge(clk_s);            
	s00_axi_bready_s  <= '0';     
	wait until falling_edge(clk_s);        
 
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);     
	end loop;          
	--report "Clearing the start bit!";     
	-- Set the value start bit (bit 0 in the CMD register) to 1     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(CMD_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '1';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '1';     
	s00_axi_wstrb_s  <= "1111";     
	s00_axi_bready_s  <= '1';    
	wait until s00_axi_awready_s = '1';     
	wait until s00_axi_awready_s = '0';     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);    
	s00_axi_awvalid_s  <= '0';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '0';     
	s00_axi_wstrb_s  <= "0000";    
	wait until s00_axi_bvalid_s = '0';     
	wait until falling_edge(clk_s);            
	s00_axi_bready_s  <= '0';     
	wait until falling_edge(clk_s);        
 

    -------------------------------------------------------------------------------------------     
	--          Wait until  Zoom2 core finishes the process       
	--     -------------------------------------------------------------------------------------------     
	--report "Waiting for the Zoom2  process to complete!";  
	
	loop       
	-- Read the content of the Status register       
	wait until falling_edge(clk_s);       
	s00_axi_araddr_s  <= conv_std_logic_vector(STATUS_REG_ADDR_C, 4);       
	s00_axi_arvalid_s <= '1';       
	s00_axi_rready_s  <= '1'; 
   -- report "s00_axi_araddr_s  <= conv_std_logic_vector(STATUS_REG_ADDR_C, 4); etc...";	
	wait until s00_axi_arready_s = '1';       
	axi_read_data_v  <= s00_axi_rdata_s; 
   -- report "axi_read_data_v  := s00_axi_rdata_s;";	
	wait until s00_axi_arready_s = '0';       
	wait until falling_edge(clk_s);
    s00_axi_araddr_s  <= conv_std_logic_vector(0, 4);       
	s00_axi_arvalid_s <= '0';       
	s00_axi_rready_s  <= '0';
   -- report "s00_axi_araddr_s  <= conv_std_logic_vector(0, 4), etc...";	
	-- Check is the 1st bit of the Status register set to one       
	if (axi_read_data_v(0) = '1') then
  --  report "axi_read_data_v(0) = '1'";	
	-- Zoom2 process completed         
	exit;       
	else         
	wait for 1000 ns;       
	end if;     
	end loop;
    --report "Zoom2 process completed ";	
	-------------------------------------------------------------------------------------------     
	--           Read the elements of Rnew from the Zoom2      
	--     -------------------------------------------------------------------------------------------     
	--report "Reading the results of the Zoom2 process!";     
	-- Read some data using AXI4 interface     
	transfer_size_v  := 4*N_c*M_c;
   -- report "transfer_size_v  := 4*N_c*M_c;";	
	wait until falling_edge(clk_s);     
	s01_axi_araddr_s  <= conv_std_logic_vector(MEMORY_C_OFFSET_C, s01_axi_araddr_s'length);
    --report "s01_axi_araddr_s  <= conv_std_logic_vector(MEMORY_C_OFFSET_C, s01_axi_araddr_s'length);";	
	-- Set the number of data that will be transfered in one burst     
	s01_axi_arlen_s  <= conv_std_logic_vector(transfer_size_v-1, log2c(4*M_c*N_c));
  --  report "s01_axi_arlen_s  <= conv_std_logic_vector(transfer_size_v-1, log2c(4*M_c*N_c));";	
	s01_axi_arsize_s  <= "010";
    --report "s01_axi_arsize_s  <= 010";	
	-- Size of each transfer will be 4 bytes     
	s01_axi_arburst_s  <= "01";
   -- report "s01_axi_arburst_s  <= 01";	
	-- Burst type will be "INCR"     
	s01_axi_arvalid_s  <= '1';
   -- report "s01_axi_arvalid_s  <= '1';";	
	s01_axi_rready_s  <= '1';
   -- report "s01_axi_rready_s  <= '1';";	
	wait until s01_axi_arready_s = '1';
	--report "wait until s01_axi_arready_s = '1';";
	wait until s01_axi_arready_s = '0';
   -- report "wait until s01_axi_arready_s = '0';";	
	wait until falling_edge(clk_s);
	--report "wait until falling_edge(clk_s);";
	s01_axi_araddr_s  <= conv_std_logic_vector(0, s01_axi_araddr_s'length);
    --report "s01_axi_araddr_s  <= conv_std_logic_vector(0, s01_axi_araddr_s'length);";	
	s01_axi_arlen_s  <= (others => '0');
   -- report "s01_axi_arlen_s  <= (others => '0');";	
	s01_axi_arburst_s  <= "00";
   -- report "s01_axi_arburst_s  <= 00";	
	s01_axi_arvalid_s  <= '0';
    --report "s01_axi_arvalid_s  <= '0';";	
	 for data_counter in 0 to (N_Rnew_c*M_Rnew_c)-2 loop	
		acounter:=data_counter;
			MEM_Rnew_CONTENT_c(conv_integer(acounter))<=rnew_axi_data_s;
		wait until s01_axi_rvalid_s = '1'; 

		  report "wait until s01_axi_rvalid_s = '1'; ";	
		  wait until s01_axi_rvalid_s = '0'; 
		  report "wait until s01_axi_rvalid_s = '0';  ";
	
		  wait until falling_edge(clk_s);
		  report "wait until falling_edge(clk_s); ";
		--assert data_counter = transfer_size_v-1 report "expected value. data_counter = " & integer'image(data_counter);
	  end loop; 
	  
	  MEM_Rnew_CONTENT_c(conv_integer(N_Rnew_c*M_Rnew_c-1))<=rnew_axi_data_s;
	report "-- end loop; ";
	
    for i in 0 to N_Rnew_c-1  loop                  
            for j in 0 to M_Rnew_c-1 loop
			    report "write(v_OLINE, conv_integer(MEM_Rnew_CONTENT_c(i*N_Rnew_c+j)));  ";
                write(v_OLINE, conv_integer(MEM_Rnew_CONTENT_c(i*N_Rnew_c+j)));
                report "write(v_OLINE,' '); ";				
               write(v_OLINE,' ');
               wait until falling_edge(clk_s);       
             end loop; 
             writeline(file_RESULTS2, v_OLINE);                
      end loop;	
	  
	report "-- end loop; ";
	wait until falling_edge(clk_s);
	report "wait until falling_edge(clk_s);";
	s01_axi_rready_s  <= '0'; 
    report "s01_axi_rready_s  <= '0';";
    -- End of the test 
    -- report "-- End of the test ";    
	
	----------------------------------------------------------------------------------------------
	----------------------------------THIRD MATRIX-----------------------------------------------
	----------------------------------------------------------------------------------------------
  for j in 0 to M_c-1  loop                  
          for i in 0 to N_c-1 loop
              readline(file_VECTOR3, v_ILINE);
              read(v_ILINE, v_ADD_TERM1);         
              MEM_R_CONTENT_c(i*N_c+j) <=v_ADD_TERM1 ;
                      wait until falling_edge(clk_s);       
              end loop;                 
            end loop;
		
  -- reset AXI-lite interface. Reset will be 10 clock cycles wide 
  --sel_s<='0';
   s00_axi_aresetn_s <= '0';     
   -- wait for 5 falling edges of AXI-lite clock signal    
   for i in 1 to 5 loop      
   wait until falling_edge(clk_s);     
   end loop;     
   -- release reset         
   s00_axi_aresetn_s <= '1';     
   wait until falling_edge(clk_s);         
   ----------------------------------------------------------------------     --               Initialize the Matrix Multiplier core                 --     ----------------------------------------------------------------------     
  -- report "Loading the matrix dimensions information into the Zoom2 core!";     
   -- Set the value for the first dimension (parameter COL) of matrix R and RNEW     
   wait until falling_edge(clk_s);     
   s00_axi_awaddr_s  <= conv_std_logic_vector(COL_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
   s00_axi_awvalid_s <= '1';     
   s00_axi_wdata_s  <= conv_std_logic_vector(N_c, C_S00_AXI_DATA_WIDTH_c);     
   s00_axi_wvalid_s  <= '1';     
   s00_axi_wstrb_s  <= "1111";     
   s00_axi_bready_s  <= '1';     
   wait until s00_axi_awready_s = '1';     
   wait until s00_axi_awready_s = '0';     
   wait until falling_edge(clk_s);     
   s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);--3 downto 0     
   s00_axi_awvalid_s  <= '0';     
   s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
   s00_axi_wvalid_s  <= '0';     
   s00_axi_wstrb_s  <= "0000";     
   wait until s00_axi_bvalid_s = '0';     
   wait until falling_edge(clk_s);            
   s00_axi_bready_s  <= '0';     
   wait until falling_edge(clk_s);        
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop      
	wait until falling_edge(clk_s);     
	end loop;          

  -- Set the value for the second dimension of matrix B and the first dimenzion of matrix Rnew (parameter P)    
  wait until falling_edge(clk_s);     
  s00_axi_awaddr_s  <= conv_std_logic_vector(ROW_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
  s00_axi_awvalid_s  <= '1';     
  s00_axi_wdata_s  <= conv_std_logic_vector(M_c, C_S00_AXI_DATA_WIDTH_c);     
  s00_axi_wvalid_s  <= '1';     
  s00_axi_wstrb_s  <= "1111";     
  s00_axi_bready_s  <= '1';     
  wait until s00_axi_awready_s = '1';     
  wait until s00_axi_awready_s = '0';     
  wait until falling_edge(clk_s);     
  s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);     
  s00_axi_awvalid_s  <= '0';     
  s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
  s00_axi_wvalid_s  <= '0';     
  s00_axi_wstrb_s  <= "0000";     
  wait until s00_axi_bvalid_s = '0';     
  wait until falling_edge(clk_s);            
  s00_axi_bready_s  <= '0';     
  wait until falling_edge(clk_s);
  
 
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);    
	end loop;
	
	-------------------------------------------------------------------------------------------     
	--    Load the element values for matrix R into the Zoom2 core    
	--     -------------------------------------------------------------------------------------------     
	report "Loading matrix R element values into the core!";
	  
	-- reset AXI4 interface. Reset will be 10 clock cycles wide     
	s01_axi_aresetn_s <= '0';     
	-- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);    
	end loop; 
    --report "release reset!";    
	-- release reset         
	s01_axi_aresetn_s <= '1';     
	wait until falling_edge(clk_s);          
	-- Write some data using AXI4 interface and burst mode     
	transfer_size_v := M_c*N_c;     
	wait until falling_edge(clk_s);     
	s01_axi_awaddr_s  <= conv_std_logic_vector(MEMORY_R_OFFSET_C, s01_axi_awaddr_s'length);
    --report "s01_axi_awaddr_s=1!";	
	-- Set the number of data that will be transfered in one burst     
	s01_axi_awlen_s  <= conv_std_logic_vector(transfer_size_v-1,log2c(4*M_c*N_c)-2 );      
	s01_axi_awsize_s  <= "010"; 
	-- Size of each transfer will be 4 bytes    
	s01_axi_awburst_s  <= "01";
    --report "Burst type will be INCR!";		
	-- Burst type will be "INCR"     
	s01_axi_awvalid_s  <= '1';     
	wait until s01_axi_awready_s = '1';     
	wait until s01_axi_awready_s = '0';     
	wait until falling_edge(clk_s);
   -- report "s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(0)), s01_axi_wdata_s'length);";
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(0)), s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '1';     
	s01_axi_wstrb_s  <= "1111";     
	s01_axi_wlast_s  <= '0';     
	s01_axi_bready_s  <= '1';     
	wait until s01_axi_wready_s = '1';    
	wait until falling_edge(clk_s);     
	wait until falling_edge(clk_s);
    --report "for data_counter in 1 to transfer_size_v-2 loop!";	
	for data_counter in 1 to transfer_size_v-2 loop       
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(data_counter)), s01_axi_wdata_s'length);       
	s01_axi_wvalid_s  <= '1';       
	s01_axi_wstrb_s  <= "1111";       
	s01_axi_wlast_s  <= '0';       
	s01_axi_bready_s  <= '1';       
	wait until falling_edge(clk_s);     
	end loop;
    --report "262";	
	s01_axi_wdata_s  <= conv_std_logic_vector(conv_integer(MEM_R_CONTENT_c(transfer_size_v-1)),s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '1';     
	s01_axi_wstrb_s  <= "1111";     
	s01_axi_wlast_s  <= '1';     
	s01_axi_bready_s  <= '1';    
	wait until falling_edge(clk_s);
	--report "269";
	s01_axi_wdata_s  <= conv_std_logic_vector(0, s01_axi_wdata_s'length);     
	s01_axi_wvalid_s  <= '0';     
	s01_axi_wstrb_s  <= "0000";     
	s01_axi_wlast_s  <= '0';     
	s01_axi_awaddr_s  <= conv_std_logic_vector(0, s01_axi_awaddr_s'length);     
	s01_axi_awlen_s  <= (others => '0');     
	s01_axi_awburst_s  <= "00";    
	s01_axi_awvalid_s  <= '0'; 
    --report "278";
	if (s01_axi_bvalid_s = '1') then       
	wait until s01_axi_bvalid_s = '0';     
	else       
	wait until s01_axi_bvalid_s = '1';       
	wait until s01_axi_bvalid_s = '0';     
	end if;     
	wait until falling_edge(clk_s);            
	s01_axi_bready_s <= '0'; 
 
    
  
    -------------------------------------------------------------------------------------------     
	--                       Start the Zoom2 core                    
	--     -------------------------------------------------------------------------------------------     
	--report "Starting the Zoom2 core!";    
	-- Set the value start bit (bit 0 in the CMD register) to 1     
	wait until falling_edge(clk_s);
  --   sel_s<='1'; 
	s00_axi_awaddr_s  <= conv_std_logic_vector(CMD_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '1';
    s00_axi_wdata_s  <= conv_std_logic_vector(1, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '1';     
	s00_axi_wstrb_s  <= "1111";     
	s00_axi_bready_s  <= '1';     
	wait until s00_axi_awready_s = '1';     
	wait until s00_axi_awready_s = '0';     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '0';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '0';     
	s00_axi_wstrb_s  <= "0000";     
	wait until s00_axi_bvalid_s = '0';     
	wait until falling_edge(clk_s);            
	s00_axi_bready_s  <= '0';     
	wait until falling_edge(clk_s);        
 
    -- wait for 5 falling edges of AXI-lite clock signal     
	for i in 1 to 5 loop       
	wait until falling_edge(clk_s);     
	end loop;          
	--report "Clearing the start bit!";     
	-- Set the value start bit (bit 0 in the CMD register) to 1     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(CMD_REG_ADDR_C, C_S00_AXI_ADDR_WIDTH_c);     
	s00_axi_awvalid_s  <= '1';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '1';     
	s00_axi_wstrb_s  <= "1111";     
	s00_axi_bready_s  <= '1';    
	wait until s00_axi_awready_s = '1';     
	wait until s00_axi_awready_s = '0';     
	wait until falling_edge(clk_s);     
	s00_axi_awaddr_s  <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);    
	s00_axi_awvalid_s  <= '0';     
	s00_axi_wdata_s  <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);     
	s00_axi_wvalid_s  <= '0';     
	s00_axi_wstrb_s  <= "0000";    
	wait until s00_axi_bvalid_s = '0';     
	wait until falling_edge(clk_s);            
	s00_axi_bready_s  <= '0';     
	wait until falling_edge(clk_s);        
 

    -------------------------------------------------------------------------------------------     
	--          Wait until  Zoom2 core finishes the process       
	--     -------------------------------------------------------------------------------------------     
	--report "Waiting for the Zoom2  process to complete!";  
	
	loop       
	-- Read the content of the Status register       
	wait until falling_edge(clk_s);       
	s00_axi_araddr_s  <= conv_std_logic_vector(STATUS_REG_ADDR_C, 4);       
	s00_axi_arvalid_s <= '1';       
	s00_axi_rready_s  <= '1'; 
   -- report "s00_axi_araddr_s  <= conv_std_logic_vector(STATUS_REG_ADDR_C, 4); etc...";	
	wait until s00_axi_arready_s = '1';       
	axi_read_data_v  <= s00_axi_rdata_s; 
   -- report "axi_read_data_v  := s00_axi_rdata_s;";	
	wait until s00_axi_arready_s = '0';       
	wait until falling_edge(clk_s);
    s00_axi_araddr_s  <= conv_std_logic_vector(0, 4);       
	s00_axi_arvalid_s <= '0';       
	s00_axi_rready_s  <= '0';
   -- report "s00_axi_araddr_s  <= conv_std_logic_vector(0, 4), etc...";	
	-- Check is the 1st bit of the Status register set to one       
	if (axi_read_data_v(0) = '1') then
  --  report "axi_read_data_v(0) = '1'";	
	-- Zoom2 process completed         
	exit;       
	else         
	wait for 1000 ns;       
	end if;     
	end loop;
    --report "Zoom2 process completed ";	
	-------------------------------------------------------------------------------------------     
	--           Read the elements of Rnew from the Zoom2      
	--     -------------------------------------------------------------------------------------------     
	--report "Reading the results of the Zoom2 process!";     
	-- Read some data using AXI4 interface     
	transfer_size_v  := 4*N_c*M_c;
   -- report "transfer_size_v  := 4*N_c*M_c;";	
	wait until falling_edge(clk_s);     
	s01_axi_araddr_s  <= conv_std_logic_vector(MEMORY_C_OFFSET_C, s01_axi_araddr_s'length);
    --report "s01_axi_araddr_s  <= conv_std_logic_vector(MEMORY_C_OFFSET_C, s01_axi_araddr_s'length);";	
	-- Set the number of data that will be transfered in one burst     
	s01_axi_arlen_s  <= conv_std_logic_vector(transfer_size_v-1, log2c(4*M_c*N_c));
  --  report "s01_axi_arlen_s  <= conv_std_logic_vector(transfer_size_v-1, log2c(4*M_c*N_c));";	
	s01_axi_arsize_s  <= "010";
    --report "s01_axi_arsize_s  <= 010";	
	-- Size of each transfer will be 4 bytes     
	s01_axi_arburst_s  <= "01";
   -- report "s01_axi_arburst_s  <= 01";	
	-- Burst type will be "INCR"     
	s01_axi_arvalid_s  <= '1';
   -- report "s01_axi_arvalid_s  <= '1';";	
	s01_axi_rready_s  <= '1';
   -- report "s01_axi_rready_s  <= '1';";	
	wait until s01_axi_arready_s = '1';
	--report "wait until s01_axi_arready_s = '1';";
	wait until s01_axi_arready_s = '0';
   -- report "wait until s01_axi_arready_s = '0';";	
	wait until falling_edge(clk_s);
	--report "wait until falling_edge(clk_s);";
	s01_axi_araddr_s  <= conv_std_logic_vector(0, s01_axi_araddr_s'length);
    --report "s01_axi_araddr_s  <= conv_std_logic_vector(0, s01_axi_araddr_s'length);";	
	s01_axi_arlen_s  <= (others => '0');
   -- report "s01_axi_arlen_s  <= (others => '0');";	
	s01_axi_arburst_s  <= "00";
   -- report "s01_axi_arburst_s  <= 00";	
	s01_axi_arvalid_s  <= '0';
    --report "s01_axi_arvalid_s  <= '0';";	
	 for data_counter in 0 to (N_Rnew_c*M_Rnew_c)-2 loop	
		acounter:=data_counter;
			MEM_Rnew_CONTENT_c(conv_integer(acounter))<=rnew_axi_data_s;
		wait until s01_axi_rvalid_s = '1'; 

		  report "wait until s01_axi_rvalid_s = '1'; ";	
		  wait until s01_axi_rvalid_s = '0'; 
		  report "wait until s01_axi_rvalid_s = '0';  ";
	
		  wait until falling_edge(clk_s);
		  report "wait until falling_edge(clk_s); ";
		--assert data_counter = transfer_size_v-1 report "expected value. data_counter = " & integer'image(data_counter);
	  end loop; 
	  
	  MEM_Rnew_CONTENT_c(conv_integer(N_Rnew_c*M_Rnew_c-1))<=rnew_axi_data_s;
	report "-- end loop; ";
	
    for i in 0 to N_Rnew_c-1  loop                  
            for j in 0 to M_Rnew_c-1 loop
			    report "write(v_OLINE, conv_integer(MEM_Rnew_CONTENT_c(i*N_Rnew_c+j)));  ";
                write(v_OLINE, conv_integer(MEM_Rnew_CONTENT_c(i*N_Rnew_c+j)));
                report "write(v_OLINE,' '); ";				
               write(v_OLINE,' ');
               wait until falling_edge(clk_s);       
             end loop; 
             writeline(file_RESULTS3, v_OLINE);                
      end loop;	
	  
	report "-- end loop; ";
	wait until falling_edge(clk_s);
	report "wait until falling_edge(clk_s);";
	s01_axi_rready_s  <= '0'; 
    report "s01_axi_rready_s  <= '0';";
    -- End of the test 
    -- report "-- End of the test ";    
	wait;

	
	end process; 
	
	
	
	
 
  -------------------------------------------------------------------------   
  --                                        DUT                                                 
  --   -------------------------------------------------------------------------   
  zoom2: entity work.IP_ZOOM_AXI_v1_0_150x150(arch_imp)     
  generic map(       
  WIDTH  => DATA_WIDTH_c,       
  SIZE   => SIZE_c)   
  port map (    
  -- Ports of Axi Slave Bus Interface S00_AXI 
  --en_rnew_ss        =>  en_rnew_ss,
  --sel_s             => sel_s,
  reset_s			  => reset_s,  
  s00_axi_lite_aclk   => clk_s,     
  s00_axi_lite_aresetn   => s00_axi_aresetn_s,       
  s00_axi_lite_awaddr   => s00_axi_awaddr_s,       
  s00_axi_lite_awprot   => s00_axi_awprot_s,
   s00_axi_lite_awvalid   => s00_axi_awvalid_s,       
   s00_axi_lite_awready   => s00_axi_awready_s,       
   s00_axi_lite_wdata   => s00_axi_wdata_s,       
   s00_axi_lite_wstrb   => s00_axi_wstrb_s,       
   s00_axi_lite_wvalid   => s00_axi_wvalid_s,       
   s00_axi_lite_wready   => s00_axi_wready_s,      
   s00_axi_lite_bresp   => s00_axi_bresp_s,      
   s00_axi_lite_bvalid   => s00_axi_bvalid_s,      
   s00_axi_lite_bready   => s00_axi_bready_s,       
   s00_axi_lite_araddr   => s00_axi_araddr_s,       
   s00_axi_lite_arprot   => s00_axi_arprot_s,       
   s00_axi_lite_arvalid   => s00_axi_arvalid_s,       
   s00_axi_lite_arready   => s00_axi_arready_s,       
   s00_axi_lite_rdata   => s00_axi_rdata_s,       
   s00_axi_lite_rresp   => s00_axi_rresp_s,       
   s00_axi_lite_rvalid   => s00_axi_rvalid_s,       
   s00_axi_lite_rready   => s00_axi_rready_s,         
   -- Ports of Axi Slave Bus Interface S01_AXI     
   s01_axi_full_aclk   => clk_s,       
   s01_axi_full_aresetn   => s01_axi_aresetn_s,       
   s01_axi_full_awid   => s01_axi_awid_s,       
   s01_axi_full_awaddr   => s01_axi_awaddr_s,       
   s01_axi_full_awlen   => s01_axi_awlen_s,       
   s01_axi_full_awsize   => s01_axi_awsize_s,       
   s01_axi_full_awburst   => s01_axi_awburst_s,       
   s01_axi_full_awlock   => s01_axi_awlock_s,       
   s01_axi_full_awcache   => s01_axi_awcache_s,       
   s01_axi_full_awprot   => s01_axi_awprot_s,       
   s01_axi_full_awqos   => s01_axi_awqos_s,       
   s01_axi_full_awregion => s01_axi_awregion_s,     
   s01_axi_full_awuser   => s01_axi_awuser_s,       
   s01_axi_full_awvalid   => s01_axi_awvalid_s,       
   s01_axi_full_awready   => s01_axi_awready_s,       
   s01_axi_full_wdata   => s01_axi_wdata_s,       
   s01_axi_full_wstrb   => s01_axi_wstrb_s,       
   s01_axi_full_wlast   => s01_axi_wlast_s,       
   s01_axi_full_wuser   => s01_axi_wuser_s,       
   s01_axi_full_wvalid   => s01_axi_wvalid_s,       
   s01_axi_full_wready   => s01_axi_wready_s,       
   s01_axi_full_bid     => s01_axi_bid_s,         
   s01_axi_full_bresp   => s01_axi_bresp_s,       
   s01_axi_full_buser   => s01_axi_buser_s,       
   s01_axi_full_bvalid   => s01_axi_bvalid_s,       
   s01_axi_full_bready   => s01_axi_bready_s,       
   s01_axi_full_arid   => s01_axi_arid_s,       
   s01_axi_full_araddr   => s01_axi_araddr_s,       
   s01_axi_full_arlen   => s01_axi_arlen_s,       
   s01_axi_full_arsize   => s01_axi_arsize_s,       
   s01_axi_full_arburst   => s01_axi_arburst_s,       
   s01_axi_full_arlock   => s01_axi_arlock_s,       
   s01_axi_full_arcache   => s01_axi_arcache_s,       
   s01_axi_full_arprot   => s01_axi_arprot_s,       
   s01_axi_full_arqos   => s01_axi_arqos_s,       
   s01_axi_full_arregion => s01_axi_arregion_s,     
   s01_axi_full_aruser   => s01_axi_aruser_s,       
   s01_axi_full_arvalid   => s01_axi_arvalid_s,       
   s01_axi_full_arready   => s01_axi_arready_s,       
   s01_axi_full_rid     => s01_axi_rid_s,
   s01_axi_full_rdata   => s01_axi_rdata_s,       
   s01_axi_full_rresp   => s01_axi_rresp_s,       
   s01_axi_full_rlast   => s01_axi_rlast_s,       
   s01_axi_full_ruser   => s01_axi_ruser_s,       
   s01_axi_full_rvalid   => s01_axi_rvalid_s,       
   s01_axi_full_rready   => s01_axi_rready_s,
   rnew_axi_data_port	 => rnew_axi_data_s); 
  end Behavioral;    
	
  