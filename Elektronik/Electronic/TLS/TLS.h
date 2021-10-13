#ifndef TLS_h
#define TLS_h

#include "Arduino.h"
#include <WiFiClientSecure.h>

class TLS{
	public:
	void activateCertAuthority();
	String postServer(BearSSL::WiFiClientSecure *client, String host, const uint16_t port, String path,String data);
	private:
	void setClock();
};

#endif