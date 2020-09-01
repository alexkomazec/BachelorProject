#include <systemc>
#include "MyIP.hpp"
#include "tb_vp.hpp"
#include "vp.hpp"

using namespace sc_core;

int sc_main(int argc, char* argv[])
{
	cout<<"sc_main, Creating an object of vp, line 10"<<endl;
    vp uut("uut");
	cout<<"sc_main, Creating an object of tb_vp, line 12"<<endl;
	tb_vp tb("tb_vp");
	cout<<"sc_main, Binding tb and s_cpu, line 14"<<endl;
	tb.isoc.bind(uut.s_cpu);
	cout<<"sc_main, global time set, line 16"<<endl;
	tlm::tlm_global_quantum::instance().set(sc_time(100, SC_NS));
	cout<<"sc_main,start, line 18"<<endl;
	sc_start();

    return 0;
}
