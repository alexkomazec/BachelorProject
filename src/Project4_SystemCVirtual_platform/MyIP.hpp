#ifndef _MYIP_H_
#define _MYIP_H_

#include <tlm>
#include <tlm_utils/simple_target_socket.h>
#include <Magick++.h>
#include <iostream>
using namespace std;
using namespace Magick;



class MyIP : public sc_core::sc_module
{
public:
	//Events
	sc_core::sc_event ewrite,eread,can_continueWrite,can_continueRead;
	MyIP(sc_core::sc_module_name);

	tlm_utils::simple_target_socket<MyIP> soc;

	inline void set_period(sc_core::sc_time&);
	Image a,b;
protected:
	int rcount=0;
	void ImageResizing();
	sc_core::sc_time period;
	sc_dt::sc_uint<8> val;
	int IRprocess=0;
	typedef tlm::tlm_base_protocol_types::tlm_payload_type pl_t;

	void b_transport(pl_t&, sc_core::sc_time&);
	void msg(const pl_t&);
};

void MyIP::set_period(sc_core::sc_time& t)
{
	period = t;
}

#endif
