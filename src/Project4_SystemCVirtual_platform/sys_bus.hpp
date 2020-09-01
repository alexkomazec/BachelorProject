#ifndef _SYS_BUS_HPP_
#define _SYS_BUS_HPP_

#include <systemc>
#include <tlm>
#include <tlm_utils/simple_target_socket.h>
#include <tlm_utils/simple_initiator_socket.h>

class sys_bus :
	public sc_core::sc_module
{
public:
	sys_bus(sc_core::sc_module_name);

	tlm_utils::simple_target_socket<sys_bus> s_cpu;
	tlm_utils::simple_initiator_socket<sys_bus> s_myiproc;

protected:
	typedef tlm::tlm_base_protocol_types::tlm_payload_type pl_t;
	void b_transport(pl_t&, sc_core::sc_time&);
	void msg(const pl_t&);
};

#endif
