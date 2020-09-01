#include "tb_vp.hpp"
#include "vp_addr.hpp"
#include <string>
#include <tlm_utils/tlm_quantumkeeper.h>

using namespace sc_core;
using namespace sc_dt;
using namespace std;
using namespace tlm;

SC_HAS_PROCESS(tb_vp);

tb_vp::tb_vp(sc_module_name name):
	sc_module(name)
{
	SC_THREAD(test);
	SC_REPORT_INFO("tb_vp", "Test bench is constructed");
}

void tb_vp::test()
{
	sc_time loct;
	tlm_generic_payload pl;
	tlm_utils::tlm_quantumkeeper qk;
	qk.reset();


		sc_dt::sc_uint<8> val=0;
		cout<<"Setting val..., line 29 "<<val<<endl;
		//Send informations to MyIP in order to read a picture
		pl.set_address(VP_ADDR_MYIP);
		pl.set_command(TLM_WRITE_COMMAND);
		pl.set_data_length(1);
		pl.set_data_ptr((unsigned char*)&val);
		
		cout<<"Peparing for b_transport..., line 36"<<endl;
		isoc->b_transport(pl, loct);
		qk.set_and_sync(loct);
		cout<<"The message function is beginning..., line 39"<<endl;
		msg(pl);
		cout<<"msg(pl) is ended, line 41"<<endl;
		loct += sc_time(5, SC_NS);
		//End of writing cycle

		val = 1;
		cout<<"Setting val, line 46 "<<val<<endl;
		//Send informations to MyIP in order to write a  resized picture
		pl.set_address(VP_ADDR_MYIP);
		pl.set_command(TLM_WRITE_COMMAND);
		pl.set_data_length(1);
		pl.set_data_ptr((unsigned char*)&val);

		cout<<"Peparing for b_transport..., line 53"<<endl;
		isoc->b_transport(pl, loct);
		qk.set_and_sync(loct);
		cout<<"The message function is beginning..., line 56"<<endl;
		msg(pl);
		cout<<"msg(pl) is ended, line 58"<<endl;
		loct += sc_time(5, SC_NS);
		//End of reading cycle
		
		//Get Informations from MyIP
		pl.set_address(VP_ADDR_MYIP);
		pl.set_command(TLM_READ_COMMAND);
		pl.set_data_length(1);

		cout<<"Peparing for b_transport..., line 67"<<endl;
		isoc->b_transport(pl, loct);
		qk.set_and_sync(loct);
		
		cout<<"Receiving val from MyIP..., line 71"<<endl;
		val = *((sc_uint<8>*)pl.get_data_ptr());
		cout<<"The val is "<<val<<", line 73"<<endl;
		cout<<"The message function is beginning..., line 74"<<endl;
		msg(pl);
		cout<<"msg(pl) is ended, line 76 "<<endl;
		loct += sc_time(5, SC_NS);
		
		if(val==10)
		{
			cout<<"The reading,resizing,writing process has finished for sure"<<endl;
		}
		else
		cout<<"The val is "<<val<<endl;
		cout<<"Test Bench has finished, line 61"<<val<<endl;
		
		
	

	
	qk.inc(sc_time(1, SC_US));
	qk.sync();
	sc_stop();
}


void tb_vp::msg(const pl_t& pl)
{
	
	static int trcnt = 0;
	stringstream ss;
	ss << hex << pl.get_address();
	sc_uint<8> val = *((sc_uint<8>*)pl.get_data_ptr());
	cout<<"tb_vp msg function, line 104"<<endl;

	string msg = "val: " + to_string((int)val) + " adr: " + ss.str();
	msg += " @ " + sc_time_stamp().to_string();

	SC_REPORT_INFO("TB", msg.c_str());
	trcnt++;
	SC_REPORT_INFO("TB", ("------------" + to_string(trcnt)).c_str());
}
