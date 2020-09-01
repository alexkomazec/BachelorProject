#include "vp.hpp"
#include <iostream>

using namespace sc_core;

vp::vp(sc_module_name name) :
	sc_module(name),
	sb("sys_bus"),
	t("MyIP")
{
	s_cpu.register_b_transport(this, &vp::b_transport);
	cout<<"vp, Binding ==initiator==s_bus( Interconnect) to s_cpu( Test bench), line 12"<<endl;
	s_bus.bind(sb.s_cpu);
	cout<<"vp, Binding Interconnect and MyIP, line 12"<<endl;
	sb.s_myiproc.bind(t.soc);
	SC_REPORT_INFO("VP", "Platform is constructed");
}

void vp::b_transport(pl_t& pl, sc_time& delay)
{
	s_bus->b_transport(pl, delay);
	SC_REPORT_INFO("VP", "Transaction passes...");
}
