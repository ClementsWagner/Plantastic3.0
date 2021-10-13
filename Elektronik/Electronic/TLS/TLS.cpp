
#include "Arduino.h"
#include <StackThunk.h>
#include <time.h>
#include <WiFiClientSecure.h>
#include "TLS.h"

void TLS::setClock() {
  configTime(3 * 3600, 0, "pool.ntp.org", "time.nist.gov");

  Serial.print("Waiting for NTP time sync: ");
  time_t now = time(nullptr);
  while (now < 8 * 3600 * 2) {
    delay(500);
    Serial.print(".");
    now = time(nullptr);
  }
  Serial.println("");
  struct tm timeinfo;
  gmtime_r(&now, &timeinfo);
  Serial.print("Current time: ");
  Serial.print(asctime(&timeinfo));
}

String TLS::postServer(BearSSL::WiFiClientSecure *client, String host, const uint16_t port, String path, String data) {
  String output("NA");
  if (!path) {
    path = "/";
  }

  ESP.resetFreeContStack();
  uint32_t freeStackStart = ESP.getFreeContStack();
  Serial.printf("Trying: %s:443...", host);
  client->connect(host, port);
  if (!client->connected()) {
    Serial.printf("*** Can't connect. ***\n-------\n");
    return output;
  }
  Serial.printf("Connected!\n-------\n");
  //String message = "POST "+String(path)+" HTTP/1.0\r\nHost: "+String(host)+"\r\nUser-Agent: ESP8266\r\nContent-Type: application/json\r\n\r\n"+String(payload);
  client->write("POST ");
  client->write(path.c_str());
  client->write(" HTTP/1.0\r\nHost: ");
  client->write(host.c_str());
  client->write("\r\nUser-Agent: ESP8266\r\n");
  client->write("Content-Length: ");
  client->write(String(data.length()).c_str());
  client->write("\r\nContent-Type: application/json\r\n");
  client->write("\r\n");
  client->write(data.c_str());
  uint32_t to = millis() + 5000;
  if (client->connected()) {
    do {
      char tmp[32];
      memset(tmp, 0, 32);
      int rlen = client->read((uint8_t*)tmp, sizeof(tmp) - 1);
      yield();
      if (rlen < 0) {
        break;
      }
      // Only print out first line up to \r, then abort connection
      char *nl = strchr(tmp, '\r');
      if (nl) {
        *nl = 0;
        Serial.print(tmp);
        output = String(tmp);
        break;
      }
      Serial.print(tmp);
    } while (millis() < to);
  }
  client->stop();
  uint32_t freeStackEnd = ESP.getFreeContStack();
  Serial.printf("\nCONT stack used: %d\n", freeStackStart - freeStackEnd);
  Serial.printf("BSSL stack used: %d\n-------\n\n", stack_thunk_get_max_usage());
  return output;
}

void TLS::activateCertAuthority(){
  static const char digicert[] PROGMEM = R"EOF(
-----BEGIN CERTIFICATE-----
MIIEAzCCAuugAwIBAgIUAhQrwCTnfhJ+rUHbOKvE/7Oqi4IwDQYJKoZIhvcNAQEL
BQAwgZAxCzAJBgNVBAYTAkFUMRAwDgYDVQQIDAdBdXN0cmlhMREwDwYDVQQHDAhM
ZW9uZGluZzEMMAoGA1UECgwDSHRsMQwwCgYDVQQLDANIVGwxGDAWBgNVBAMMD0No
cmlzdGlhbiBCYWNobDEmMCQGCSqGSIb3DQEJARYXY2hyaXNpYmFjaGwxM0BnbWFp
bC5jb20wHhcNMjAwMzMxMTEyOTAwWhcNMjEwMzMxMTEyOTAwWjCBkDELMAkGA1UE
BhMCQVQxEDAOBgNVBAgMB0F1c3RyaWExETAPBgNVBAcMCExlb25kaW5nMQwwCgYD
VQQKDANIdGwxDDAKBgNVBAsMA0hUbDEYMBYGA1UEAwwPQ2hyaXN0aWFuIEJhY2hs
MSYwJAYJKoZIhvcNAQkBFhdjaHJpc2liYWNobDEzQGdtYWlsLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAN5yTkWG4Y96DR+D89hziCsRkxnJWMtP
uiYhKlABFPIFSFwbUUzB3ui8tg9YqjUTGieDQCYOkRovObh/hqHB6mMTbqPjjEHy
Q7loQ4acl1WXjNq85elKsro4NiR2f33OjoKTkSBmWF54Wz09NdblfOZqZCv5GDTx
2S2iqi4X+kbzguzIAS9mdu0AAU1zRLDgXtXDJfttcVdPL5yqOh+YOP3aTVu+psBv
M7d4WlRDVXcvq2blwbBQUU3zwwVlOErJsKvCLzzWzBpcOQQ3aYHpiHxt+PHPE4zS
RnZ32GOVh/nPYKQode1jP7aUyXHAAjuL8dIeYW42jOrx9+VOvBAXZSkCAwEAAaNT
MFEwHQYDVR0OBBYEFBZX5+sqilHlq7kXbe6JtCBvpd9CMB8GA1UdIwQYMBaAFBZX
5+sqilHlq7kXbe6JtCBvpd9CMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQEL
BQADggEBADqKt7iaEr34EA6iY+H7uXZODWVkEc5ataYqCnIuo8u9F6j93/nr+0P1
ddnTz4lt3qRQucmnLAwoFxS9nErqo6+reb0Np8Qjs2qTKK7KGxp0XctEp3dPWRZy
1wGVbyAlUAk80Aer9SKba7Fs46g0DDM0e9twEHr33GWxpCktk2KzgQVHSQHVu3vb
e9a/HRjvBvmHR7OMq5AqAFMjuMjcchgO1fX0Rlfa3K7zlq7gDy1pKx8EFRi/kCEX
Rffryqg1H0yTz4UJ3rxNZhUDHLubyAlfTHP79Pi0Z32109KjuU5O+hurhO9xujrQ
EBhN2bnmoLz3ohCWVVFmzQRts6kLNHw=
-----END CERTIFICATE-----
)EOF";

  BearSSL::WiFiClientSecure client;
  BearSSL::X509List cert(digicert);
  client.setTrustAnchors(&cert);
  setClock();
}