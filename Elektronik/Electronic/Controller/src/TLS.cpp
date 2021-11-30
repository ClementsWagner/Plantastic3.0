
#include "Arduino.h"
#include <StackThunk.h>
#include <time.h>
//#include <WiFiClientSecure.h>
#include "TLS.h"
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>

String postServerUnsecure(WiFiClient *client, String host, const uint16_t port, String path,String data) {
  HTTPClient http;
  String url = String("http://"+host+path);
  http.begin(*client, url);
  int httpCode = http.POST(data);

  Serial.printf("Trying: %s%s",host,path);
  Serial.printf("Http response: %d",httpCode);

  http.end();
  return String("t");
}

/*
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

String TLS::postServer(BearSSL::WiFiClientSecure *client, String host, const uint16_t port, String path, String data, String token) {
  setClock();
  String output("NA");
  if (!path) {
    path = "/";
  }

  ESP.resetFreeContStack();
  uint32_t freeStackStart = ESP.getFreeContStack();
  Serial.printf("Trying: %s:%u...", host.c_str(), port);
  int result = client->connect(host.c_str(), port);
  
  if (!client->connected()) {
    Serial.printf("\n*** Can't connect. Error: %d ***\n-------\n", result);
    delay(1000);
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
  if(token!=NULL&&token!="")
  {
    client->write(String("Authorization: Bearer " + token + "\r\n").c_str());
  }
  client->write("\r\n");
  client->write(data.c_str());
  uint32_t to = millis() + 5000;
  char tmp[32];
  if (client->connected()) {
    do {
      memset(tmp, 0, 32);
      int rlen = client->read((uint8_t*)tmp, sizeof(tmp) - 1);
      yield();

      Serial.println(tmp);
      if (rlen < 0) {
        Serial.println("Empty response");
        break;
      }
      else if(rlen > 0){
        output += String(tmp);
      }

    } while (millis() < to);
  }
  client->stop();
  uint32_t freeStackEnd = ESP.getFreeContStack();
  Serial.printf("\nCONT stack used: %d\n", freeStackStart - freeStackEnd);
  Serial.printf("BSSL stack used: %d\n-------\n\n", stack_thunk_get_max_usage());
  return output;
}

BearSSL::WiFiClientSecure TLS::activateFingerprint(){
  String fingerprint = "93 95 56 A0 48 47 FC 9F B0 03 D1 1C FD 07 FC CD FE 6D AC B1";
  BearSSL::WiFiClientSecure client;
  client.setFingerprint(fingerprint.c_str());
  return client;
}

BearSSL::WiFiClientSecure TLS::activateCertAuthority(){
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
  //client.setTrustAnchors(&cert);
  client.setInsecure();
  //setClock();
  
  //postServer(&client, String("192.88.24.215"), 443, 
  //String("/api/Homestadion/authenticate"),
  //String("{ \"mac\": \"3e:90:5e:e4:02:22\", \"password\": \"123456789\"}"));

  return client;
}*/