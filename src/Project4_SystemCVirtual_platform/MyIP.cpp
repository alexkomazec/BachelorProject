#include "MyIP.hpp"
#include <tlm>
#include <tlm_utils/tlm_quantumkeeper.h>


using namespace sc_core;
using namespace sc_dt;
using namespace std;
using namespace tlm;

SC_HAS_PROCESS(MyIP);

MyIP::MyIP(sc_module_name name):
	sc_module(name),
	soc("soc"),
	period(1, SC_NS)
{
	soc.register_b_transport(this, &MyIP::b_transport);
	SC_THREAD(ImageResizing);
}

void MyIP::b_transport(pl_t& pl, sc_time& offset)
{
	cout<<"b_transport, line 24"<<endl;
	cout<<"The value of value is "<<val<<"line 25"<<endl;
	tlm_command    cmd  = pl.get_command();
	uint64         addr = pl.get_address();
	unsigned char* data = pl.get_data_ptr();
    cout<<"The value of value is "<<val<<"line 29"<<endl;

	if (addr < 0x7)
	{
		switch(cmd)
		{
			case TLM_WRITE_COMMAND:
		{
			val = *((sc_uint<8>*)pl.get_data_ptr());
			cout<<"The value of value is "<<val<<"line 38"<<endl;
			switch(val)
			{
			//Write the resized image
				case 1:
					cout<<"The value of rcount is "<<rcount<<endl;
					if(rcount>=1)
						{
						cout<<"rcount is "<<rcount<<"line 46"<<endl;;
						ewrite.notify(1, sc_core::SC_NS);
						cout<<"ImageResizing() can continue writing on 151, line 48 "<<endl;
						wait(can_continueWrite);
						rcount--;
						cout<<"rcount is "<<rcount<<"line 51"<<endl;
						}
					else
						{
						SC_REPORT_ERROR("Myip", "Frist, you must read the picture");			
						}
					break;
				//Read the resized image
			    case 0:
						cout<<"rcount is "<<rcount<<"line 60"<<endl;
						eread.notify(1, sc_core::SC_NS);
						cout<<"ImageResizing() can continue reading on 138 line, line 62"<<endl;
						wait(can_continueRead);
						rcount++;
						cout<<"rcount is "<<rcount<<"line 65"<<endl;
						val=1;
					break;
				default:
					SC_REPORT_WARNING("Myip", "Wrong val");
					cout<<"Because the value of value is "<<val<<",line 70"<<endl;
			}
			pl.set_response_status( TLM_OK_RESPONSE);
			msg(pl);
			break;
		}
		case TLM_READ_COMMAND:
		{
			if(IRprocess==1)
			{
				//*data = (unsigned char) val;
				pl.set_response_status( TLM_OK_RESPONSE );
				cout<<"The process has finished reading, line 82"<<endl;
				msg(pl);
			}
			else if(IRprocess==2)
			{
				//*data = (unsigned char) val;
				val=10;
				pl.set_data_ptr((unsigned char*)&val);
				pl.set_response_status( TLM_OK_RESPONSE );
				cout<<"The process has finished writing, line 91"<<endl;
				cout<<"The Val is "<<val<<" line 92"<<endl;
				msg(pl);			
			}
			else
			{
			   SC_REPORT_ERROR("Myip", "IRprocess bad value");
			}
			break;
		}
		default:
			pl.set_response_status( TLM_COMMAND_ERROR_RESPONSE );
			SC_REPORT_ERROR("Myip", "TLM bad command");
		}
	}
	else
		SC_REPORT_WARNING("Myip", "TLM wrong address");
	offset += sc_time(3, SC_NS);

	msg(pl);
	offset += sc_time(4, SC_NS);
}

void MyIP::msg(const pl_t& pl)
{
	stringstream ss;
	ss << hex << pl.get_address();
	sc_uint<8> val1 = *((sc_uint<8>*)pl.get_data_ptr());
	string cmd  = pl.get_command() == TLM_READ_COMMAND ? "read  " : "write ";

	string msg = cmd + "Function val: " + to_string((int)val1) + " adr: " + ss.str();
	msg += " @ " + sc_time_stamp().to_string();

	SC_REPORT_INFO("MyIP", msg.c_str());

}

void  MyIP::ImageResizing()
{
	 Image a,b;
	 try {
	 cout<<"Waiting for eread... , line 132"<<endl;
     // Read a file into an image object
	 wait(eread);
	
	 cout<<"Preparing for reading..., line 136"<<endl;
     a.read( "/home/aleksandar/Desktop/ARMcap/grabber005.ppm");
	 
	 cout<<"Preparing for displaying..., line 139"<<endl;
     a.display();
	 
	 cout<<"Setting IRproces..., "<<IRprocess<<" line 142"<<endl;
     IRprocess=1;
	 
     can_continueRead.notify(1, sc_core::SC_NS);
	 b = a;
	 
	 cout<<"Resizing a picture and waititing..., line 148"<<endl;
     b.resize("200x100");
     wait(ewrite);
	 
	 cout<<"Preparing for displaying resized picture..., line 152"<<endl;
     b.display();
	 
     // Write the image to a file
	 cout<<"Writing the image to a file, line 156"<<endl;
     b.write( "/home/aleksandar/Desktop/ARMcap/resized.ppm" );
	
	 cout<<"Setting IRproces..., "<<IRprocess<<" line 159"<<endl;
     IRprocess=2;
	
     can_continueWrite.notify(1, sc_core::SC_NS);
	
    
  }
  catch( Exception &error_ )
    {
      cout << "Caught exception: " << error_.what() << endl;
    }

}
