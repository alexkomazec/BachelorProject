library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
 
use work.utils_pkg.all; 
 
entity mem_subsystem_150x150 is   
generic (     
			WIDTH  : integer := 256;     
			SIZE   : integer :=150
		);   
port(     
		clk:   in  std_logic;     
		reset: in  std_logic; 
 
    -- Interface to the AXI controllers     
	reg_data_i 		: in  std_logic_vector(log2c(SIZE)-1 downto 0);
	--cmd_data_i 		: in  std_logic;
	col_wr_i		: in  std_logic;     
	row_wr_i        : in  std_logic;        
	cmd_wr_i      	: in  std_logic; 
 
    col_axi_o       : out std_logic_vector(log2c(SIZE)-1 downto 0);     
	row_axi_o       : out std_logic_vector(log2c(SIZE)-1 downto 0);         
	cmd_axi_o       : out std_logic;     
	status_axi_o  	: out std_logic; 
 
    mem_addr_i      : in  std_logic_vector(log2c(SIZE*SIZE)+2 downto 0);     
	mem_data_i    	: in  std_logic_vector(log2c(WIDTH)-1 downto 0);     
	mem_wr_i      	: in  std_logic; 
 
    rnewdata_axi_data_o 	: out std_logic_vector(log2c(WIDTH)-1 downto 0);     
	rdata_axi_data_o 		: out std_logic_vector(log2c(WIDTH)-1 downto 0);     
 
    -- Interface to the matrix zoom2 module     
	col_o        : out std_logic_vector(log2c(SIZE)-1 downto 0);     
	row_o        : out std_logic_vector(log2c(SIZE)-1 downto 0);          
	start_o      : out std_logic;     
	ready_i      : in  std_logic; 
 
    r_addr_i     : in  std_logic_vector(log2c(SIZE*SIZE) downto 0);       
	r_data_o     : out std_logic_vector(log2c(WIDTH)-1 downto 0);
	r_wr_i		 : in std_logic;
  
    rnew_addr_i  : in std_logic_vector(log2c(SIZE*SIZE)+1 downto 0);     
	rnew_wr_i    : in std_logic;     
	rnew_data_i  : in std_logic_vector(log2c(WIDTH)-1 downto 0);
	
	--sel:    in std_logic;
	
	controlR	 : out std_logic
   -- en_rnew_ss: out std_logic
  ); 
  end mem_subsystem_150x150; 
 
architecture struct of mem_subsystem_150x150 is
	constant RnewBit: integer:= log2c(SIZE*SIZE)+2;
	constant RBit: integer:= log2c(SIZE*SIZE);
	constant RnewSize: integer:= SIZE*2;
   
	signal col_s, row_s : std_logic_vector(log2c(SIZE)-1 downto 0);   
	signal cmd_s, status_s: std_logic;      
	signal en_r_s, en_rnew_s: std_logic; 

	signal dias    :   std_logic_vector(log2c(WIDTH)-1 downto 0);     
	signal dibs    :   std_logic_vector(log2c(WIDTH)-1 downto 0);
	signal s: std_logic_vector(log2c(WIDTH)-1 downto 0);
begin   
	col_o      <= col_s;   
	row_o      <= row_s;    
	start_o    <= cmd_s; 
 
  ---------------------- REGISTERS ----------------------   
  col_axi_o 	    <= col_s;   
  row_axi_o         <= row_s;     
  cmd_axi_o         <= cmd_s;
  status_axi_o		<= status_s; 
 
  -- col register   
	process(clk)   
	begin     
		if clk'event and clk = '1' then       
			if reset = '1' then         
				col_s <= (others => '0');       
			elsif col_wr_i = '1' then         
				col_s <= reg_data_i;       
			end if;     
		end if;   
	end process; 
 
  -- row register   
  process(clk)   
	begin     
	if clk'event and clk = '1' then       
		if reset = '1' then         
			row_s <= (others => '0');       
		elsif row_wr_i = '1' then        
			row_s <= reg_data_i;       
		end if;     
	end if;   
  end process; 
 
 
  -- CMD register   
  process(clk)
	begin     
		if clk'event and clk = '1' then       
			if reset = '1' then         
				cmd_s <= '0';       
		elsif cmd_wr_i = '1' then        
				cmd_s <= reg_data_i(0);       
		end if;     
	 end if;   
	end process; 
 
  -- STATUS register   
  process(clk)   
	begin     
		if clk'event and clk = '1' then       
			if reset = '1' then         
				status_s <= '0';       
			else         
				status_s <= ready_i;       
			end if;     
		end if;   
  end process; 
 
  ---------------------- MEMORIES ----------------------
  -- Address decoder   
  addr_dec: 
  process (mem_addr_i)   
  begin     
	  -- Default assignments     
	  en_r_s <= '0';         
	  en_rnew_s <= '0';     
  
	  case mem_addr_i(log2c(SIZE*SIZE)+2) is  -- Zadnji bit     
		when '0' =>         
			en_r_s <= '1';
			en_rnew_s <= '0';             
		when others =>         
			en_rnew_s <= '1';
			en_r_s <= '0';     
	  end case;   
  end process;

 -- en_rnew_ss<=en_rnew_s;     
  -- Memory for storing the elements of matrix R   
  r_memory: entity work.Rdp_bram_150x150(beh)     
  generic map (       
				WIDTH => WIDTH,       
				SIZE   => SIZE,
				HowManyBits => RBit
			  )     
  port map ( 
  ckla   => clk,
  clkb   => clk,
  contb  => controlR,       
  ena    => en_r_s,
  enb    => '1',      
  wea    => mem_wr_i,
  web    => r_wr_i,      
  addra  => mem_addr_i(log2c(SIZE*SIZE) downto 0),
  addrb  => r_addr_i,       
  dia   =>mem_data_i,       
  doa    => rdata_axi_data_o, 
  dob    => r_data_o     ); 
 
 
  -- Memory for storing the elements of matrix Rnew   
  Rnew_memory: entity work.Rnewdp_bram_150x150(beh)     
  generic map (       
  WIDTH	   => WIDTH,       
  SIZE     => RnewSize,
  HowManyBits	=> RnewBit  )     
  port map ( 
	  ckla   => clk,
	  clkb   => clk,       
	  ena    => en_rnew_s,             
	  addra  => mem_addr_i(log2c(SIZE*SIZE)+1 downto 0),             
	  doa    => rnewdata_axi_data_o,       
	  enb    => '1', 
	  contb  => open,
	  web    => rnew_wr_i,       
	  addrb  => rnew_addr_i,      
	  dib    => rnew_data_i,       
	  dob    => open     );

    	  
  end struct; 
