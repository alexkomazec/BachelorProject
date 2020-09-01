library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  
use ieee.numeric_std.all; 

use work.utils_pkg.all;
 
entity Zoom2_150x150 is   
generic (     N: integer := 150;
			  M: integer := 150;
			  WIDTHD: integer := 256
			  );   
port (     --------------- Clocking and reset interface ---------------
     clk:  in std_logic;     
	 reset: in std_logic;     
	 ------------------- Input data interface -------------------     
	 -- Matrix R memory interface     
	 Raddress:  out std_logic_vector(log2c(M*N) downto 0);     
	 Rdata:    in std_logic_vector(log2c(WIDTHD)-1 downto 0);     
	 RWR:     out std_logic; 

    controlR: in std_logic;
	 
	 -- Matrix dimensions definition interface     
	 col:          in std_logic_vector(log2c(M)-1 downto 0);     
	 row:          in std_logic_vector(log2c(N)-1 downto 0);         
	 ------------------- Output data interface ------------------     
	 -- Matrix Rnew memory interface     
	 Rnewaddress: out std_logic_vector(log2c(M*N)+1 downto 0);
	 Rnewdata:    out std_logic_vector(log2c(WIDTHD)-1 downto 0);     
	 RnewWR:     out std_logic;     
	 --------------------- Command interface --------------------     
	 start:          in std_logic;     
	 --------------------- Status interface ---------------------     
	 ready:        out std_logic
	 
	 ); 
	 
end entity; 
 
architecture Behavioral of Zoom2_150x150 is
	------------------- All used states -------------------
	type state_type is (Idle,additionalClockRow,additionalClock,Prepare,WriteToRaddressLastBit, WriteToRaddressCOL, WriteToRaddressROW,WriteToRnewaddressCOL,WriteToRnewaddressROW,WriteToRnewaddressEmpty);   
	signal state_reg, state_next: state_type;
	 ------------------- Input Signal interface -------------------
	 -- Matrix R signals interface
    signal Raddress_next, Raddress_reg: unsigned(log2c(M*N) downto 0);
	signal RaddressR_next, RaddressR_reg: unsigned(log2c(M*N) downto 0);
	signal counter_next, counter_reg: unsigned(log2c(M*N)+1 downto 0);
	------------------- Output data interface ------------------
	-- Matrix Rnew signals interface
	signal Rnewaddress_next,Rnewaddress_reg: unsigned(log2c(M*N)+1 downto 0);
	
	------------------- Inner signal registers and constants------------------
	--c is used for columns and r is used for rows
	signal c_reg, c_next: unsigned(log2c(M)-1 downto 0);
	signal r_reg, r_next: unsigned(log2c(N)-1 downto 0);
	--startOffsetx constants represent starting position of every RnewaddressXXXXXX that is used for receiving and transmitting important informations 
	constant startOffset1:unsigned(8 downto 0):="000000000";
	constant startOffset2:unsigned(8 downto 0):="000000001";
	constant startOffset3:unsigned(8 downto 0):="100101100";
	constant startOffset4:unsigned(8 downto 0):="100101101";
	
	constant two:unsigned(1 downto 0):="10";
	
	constant r0cend:unsigned(8 downto 0):="100101010";
	constant MaxRow_plus_2: unsigned(8 downto 0):="100101110";
	
	signal NumberMatrix_reg,NumberMatrix_next: unsigned(2 downto 0);

	--mem_zoom2 is a signal that is represented as 2D array that collects informations from original picture
    type mem_t is array (0 to N*M-1) of std_logic_vector(log2c(WIDTHD)-1 downto 0); 	
	signal mem_zoom2: mem_t;
	signal mem_in, mem_out: std_logic_vector(log2c(WIDTHD)-1 downto 0);
	signal mem_out_reg,mem_out_next: std_logic_vector(log2c(WIDTHD)-1 downto 0);
begin   
-- State and data registers   
	process (clk)   
	begin
	   if(clk'event and clk = '1') then    
		if (reset = '1') then 
			mem_out_reg<=(others=>'0');
			state_reg <= Idle;
			Raddress_reg<=to_unsigned(0,log2c(M*N)+1);
			counter_reg<=to_unsigned(0,log2c(M*N)+2);
			Rnewaddress_reg<=to_unsigned(0,log2c(M*N)+2);
			RaddressR_reg<=to_unsigned(0,log2c(M*N)+1);
			c_reg<= to_unsigned(0,log2c(M));
			r_reg<= to_unsigned(0,log2c(N));
			NumberMatrix_reg<=(others=>'0');
	    else
			mem_out_reg<=mem_out_next;
			counter_reg<=counter_next;
			state_reg <= state_next;
			Raddress_reg<=Raddress_next;
			Rnewaddress_reg<=Rnewaddress_next;
			RaddressR_reg<=RaddressR_next;
			c_reg <= c_next;
			r_reg <= r_next;
			NumberMatrix_reg <= NumberMatrix_next;
		end if;	
	 end if;   
	end process;
	
-- Combinatorial circuits   
--process (state_reg, start, Rdata, c_reg, r_reg, c_next, r_next,Rnewaddress_reg,row,col, mem_out,RaddressR_reg,counter_reg,mem_out_reg,Raddress_reg,NumberMatrix_reg,controlR,NumberMatrix_next)      
process (state_reg, start, Rdata, c_reg, r_reg, c_next, r_next,Rnewaddress_reg,row,col,mem_in, mem_out,RaddressR_reg,counter_reg,mem_out_reg,Raddress_reg,NumberMatrix_reg,controlR)
begin       
-- Default assignments
    --16.11.2018
    Rnewdata<=(others=>'0');
    RnewWR<= '0';
    RWR<='0';
    -- mem_zoom2 <=(others => (others => '0'));
    ---------------
	mem_out_next <= mem_out_reg;
	counter_next <= counter_reg;
    c_next <= c_reg;     
    r_next <= r_reg;
	RaddressR_next<=RaddressR_reg;
    Raddress_next <= Raddress_reg;
    ready <='0';		
	Rnewaddress_next<=Rnewaddress_reg;

	NumberMatrix_next<=NumberMatrix_reg;
 	mem_in <= Rdata;
 	
	case state_reg is
	
		when Idle =>
			Rnewdata<= mem_out; 
		    mem_in <= Rdata;
            ready<='1';
			if(counter_reg="10101111110010000") then --90000
				RnewWR<='1';
				counter_next<=counter_reg+1;
			else
				RnewWR<= '0';
			end if;
			 
				if start = '1' then 
					c_next<=to_unsigned(0,log2c(M));
					r_next<=to_unsigned(0,log2c(N));
					state_next <= Prepare;
				else 
				
					state_next <= Idle;         
				end if;
		when Prepare =>
			--Rnewdata<= mem_out; 
			--Raddress_next<=((r_reg*unsigned(row)))+("00"&c_reg);
			mem_in <= Rdata; 			
			state_next <= WriteToRaddressCOL;
		when WriteToRaddressCOL =>
		    counter_next<=counter_reg+1;
		    RWR<='1';
			Rnewdata<= mem_out;
			if(controlR='1') then
		    Raddress_next<=((r_reg*unsigned(row)))+("00"&c_reg);
			RaddressR_next<=Raddress_reg;
			end if;
			
			if(counter_reg>"00000000000000000") then 
				mem_in <= Rdata;
			end if;
		    c_next<=c_reg+1; 
			if(c_next=unsigned(col)) then 
			
				state_next <= WriteToRaddressROW;
			else
			
				state_next <= WriteToRaddressCOL;
			end if; 
	when WriteToRaddressROW =>
	    counter_next<=(others=>'0');
        RWR<='1';	
        mem_in <= Rdata; 
		r_next<=r_reg+1;
		c_next <= to_unsigned(0, log2c(M));
		--Rnewdata<= mem_out; 
		if (r_reg = unsigned(row)-1)  then
				--state_next <= WriteToRnewaddressCOL;
				-- mem_zoom2(conv_integer(std_logic_vector(Raddress_reg))) <= Rdata;
				state_next <= WriteToRaddressLastBit;
				if(controlR='1') then
				Raddress_next<=to_unsigned(0,16);
				RaddressR_next<=Raddress_reg;
				end if;
                r_next<=to_unsigned(0, log2c(M));  
		else
		
				state_next <= WriteToRaddressCOL;             
		end if;
	when  WriteToRaddressLastBit =>
		  mem_in <= Rdata;
		 state_next <= WriteToRnewaddressCOL;
		 
	when WriteToRnewaddressCOL =>
		counter_next<=counter_reg+1;
		mem_in <= Rdata; 
		if(NumberMatrix_reg="000") then 
		    Raddress_next<=((r_reg*unsigned(row)))+("00"&c_reg);
			RaddressR_next<=Raddress_reg;
			
			Rnewaddress_next<=((((r_reg*MaxRow_plus_2)+((r_reg*r0cend))))    +    ("00000000"&startOffset1+("00"&(c_reg*two))));
			Rnewdata<= mem_out;
			if(c_reg="00000000") and (r_reg="00000000")  then
				
			     RnewWR<='0';
			     
			else
			     RnewWR<='1';

		    end if;
		elsif(NumberMatrix_reg="001") then
			Raddress_next<=((r_reg*unsigned(row)))+("00"&c_reg);
			RaddressR_next<=Raddress_reg;
			Rnewaddress_next<=((((r_reg*MaxRow_plus_2)+((r_reg*r0cend))))    +    ("00000000"&startOffset2+("00"&(c_reg*two))));                
			Rnewdata<= mem_out;
			if(c_reg="00000000") and (r_reg="00000000") and (counter_reg/="101011111100100") then  --counter_reg/4=22500
                             RnewWR<='0';
                        else
                             RnewWR<='1';
                        end if;
		elsif(NumberMatrix_reg="010") then
			Raddress_next<=((r_reg*unsigned(row)))+("00"&c_reg);
			RaddressR_next<=Raddress_reg;
			Rnewaddress_next<=((((r_reg*MaxRow_plus_2)+((r_reg*r0cend))))    +    ("00000000"&startOffset3+("00"&(c_reg*two))));                  
			Rnewdata<= mem_out;
			if(c_reg="00") and (r_reg="00") and (counter_reg/="1010111111001000") then --(counter_reg/4)*2=45000
                             RnewWR<='0';
                        else
                             RnewWR<='1';
                        end if;
		else
			Raddress_next<=((r_reg*unsigned(row)))+("00"&c_reg);
			Rnewaddress_next<=((((r_reg*MaxRow_plus_2)+((r_reg*r0cend))))    +    ("00000000"&startOffset4+("00"&(c_reg*two))));                  
			Rnewdata<= mem_out;
			if(c_reg="00") and (r_reg="00") and (counter_reg/="10000011110101100") then --(counter_reg/4)*3=67500
                             RnewWR<='0';
            else
                             RnewWR<='1';
             end if;
		end if;	
		c_next<=c_reg+1;			
		if(c_next=unsigned(col)) then 
		
		    state_next <= WriteToRnewaddressROW;
	    else
		
			state_next <= additionalClock;
	    end if;
	when additionalClock =>
		state_next <= WriteToRnewaddressCOL;
		mem_in <= Rdata;
	


	
	when WriteToRnewaddressROW =>
		--counter_next<=(others=>'0');
		Rnewdata<= mem_out; 
		RnewWR<='1';
		mem_in <= Rdata;
		r_next<=r_reg+1;
		c_next <= to_unsigned(0, log2c(M));
	
		
		
		if (r_reg = unsigned(row)-1)  then
			
			
			if(NumberMatrix_reg="100") then
				state_next <=  WriteToRnewaddressEmpty;
				r_next<=to_unsigned(0, log2c(M));
				--Raddress_next<=(others=>'0');	
			else
				--if(Rnewaddress_reg=((N*M)-1)) then
			if(c_reg=M) then
				r_next<=to_unsigned(0, log2c(M));
				Raddress_next<=to_unsigned(22500-1, log2c(M*N)+1);
				NumberMatrix_next<=NumberMatrix_reg+1;
				state_next <=  additionalClockRow;
				--Raddress_next<=(others=>'0');
				else
				   state_next <=  additionalClockRow; 
			    end if;
	        end if;
	     else
			state_next <= additionalClockRow;             
		end if;
		
		when additionalClockRow =>
		RnewWR<='1';
		Raddress_next<=to_unsigned(0, log2c(M*N)+1);
		state_next <= WriteToRnewaddressCOL;
	
		
	when WriteToRnewaddressEmpty=>
		NumberMatrix_next<=(others=>'0');
		RnewWR<='1';
		mem_in <= Rdata;
	    Rnewdata<=mem_out_reg;
		Raddress_next<=(others=>'0');		
		state_next <=  Idle;
	end case;   
end process;

    process(clk)
    begin
        if rising_edge(clk) then
				if(state_reg=WriteToRaddressCOL or state_reg=WriteToRaddressROW or state_reg=WriteToRaddressLastBit) then
				mem_zoom2( conv_integer(std_logic_vector(RaddressR_reg) ) ) <= mem_in;
				end if;
				
				mem_out <= mem_zoom2( conv_integer(std_logic_vector(Raddress_reg) ) );
        end if;
    end process;
	
	
	Raddress<=std_logic_vector(Raddress_reg);
	Rnewaddress<=std_logic_vector(Rnewaddress_reg);

		 
end Behavioral;  