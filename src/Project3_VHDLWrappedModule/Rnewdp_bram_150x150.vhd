library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
use work.utils_pkg.all; 
 
entity Rnewdp_bram_150x150 
is   
    generic (   
                WIDTH: integer := 256;   
                SIZE : integer := 300;
                HowManyBits: integer:=20       
             );   
port (     
ckla : in  std_logic;     
clkb   : in  std_logic;
contb  : out std_logic;     
ena    : in  std_logic;     
enb    : in  std_logic;         
web    : in  std_logic;     
addra  : in  std_logic_vector(HowManyBits-1 downto 0);     
addrb  : in  std_logic_vector(HowManyBits-1 downto 0);          
dib    : in  std_logic_vector(log2c(WIDTH)-1 downto 0);     
doa    : out std_logic_vector(log2c(WIDTH)-1 downto 0);     
dob    : out std_logic_vector(log2c(WIDTH)-1 downto 0)   ); 
end Rnewdp_bram_150x150; 
 
architecture beh of Rnewdp_bram_150x150 is   
type ram_type is array (0 to SIZE*SIZE-1)  of std_logic_vector(log2c(WIDTH)-1 downto 0);   
--shared variable RAM: ram_type;
signal sRAM: ram_type;
begin   
	process(ckla)   
	begin     
	if ckla'event and ckla = '1' then       
		if ena = '1' then
			--contb<= '0';
		doa <= sRAM(conv_integer(addra)); --last changes
		--doa <= RAM(conv_integer(addra));
  
		  end if;       
		  end if;     
		   end process; 
 
  process(clkb)   
  begin     
  if clkb'event and clkb = '1' then       
  if enb = '1' then
  contb<= '1';  
      dob <= sRAM(conv_integer(addrb)); --Last changes
    --dob <= RAM(conv_integer(addrb));
  if web = '1' then
	--contb<= '0';
  sRAM(conv_integer(addrb))<=dib; --RAM(conv_integer(addrb)); --last changes
  
 end if;       
  end if;    
   end if;   
   end process; 
   end beh; 