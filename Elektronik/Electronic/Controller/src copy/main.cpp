#include <Arduino.h>
#ifdef ESP32
#include <WiFi.h>
#include <AsyncTCP.h>
#elif defined(ESP8266)
#include <ESP8266WiFiMulti.h>
#include <ESPAsyncTCP.h>
#endif
#include <ESPAsyncWebServer.h>
#include "TLS.h"
#include <time.h>

#define dataListSize 100

ESP8266WiFiMulti WiFiMulti;
int postCount = 0;
uint8_t *postData;
size_t dataSize;

String dataArr[dataListSize];
TLS con = TLS();

const char* ssid = "PlantasticController";
const char* password = "123456789";
String address = "192.88.24.215"; 

String token;
// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

BearSSL::WiFiClientSecure client;

String uintToString(uint8_t *data, size_t len){
  String tmp = "";
    for (size_t i = 0; i < len; i++) {
        tmp += (char)data[i];
    }
    return tmp;
}

String httpget(){  
  String result = "";
  return result;
}

void addStringToArray(String d[], size_t len, String item){
  int i = 0;
  while(d[i]!=""&&i<len){
    i++;
  }
  d[i] = item;
}

void printArray(String d[], size_t len){
  for(int i=0;i<len;i++){
    Serial.println(d[i]);
  }
}

String popStringArray(String d[], size_t len){
  String result = d[0];
  for(int i=0;i<len-1;i++){
    d[i]=d[i+1];
    d[i+1]="";
  }
  return result;
}

String getTime(){
  configTime(3 * 3600, 0, "pool.ntp.org", "time.nist.gov");
  time_t now = time(nullptr);
  while (now < 8 * 3600 * 2) {
    delay(500);
    now = time(nullptr);
  }
  struct tm timeinfo;
  gmtime_r(&now, &timeinfo);
  char t[90];
  //2020-03-31T15:54:57.782Z
  //2020-3-20T16:48:54.000Z
  String data = String(asctime(&timeinfo));
  int year = data.substring(data.length()-5, data.length()).toInt();
  sprintf(t, "%d-%02d-%02dT%02d:%02d:%02d.000Z", year, timeinfo.tm_mon, timeinfo.tm_mday, timeinfo.tm_hour, timeinfo.tm_min, timeinfo.tm_sec);
  return String(t);
}

String getJsonFromData(String data){
  data.indexOf(';');
  //Serial.print("Mois: ");
  int humidity = data.substring(0, data.indexOf(';')).toInt();
  //Serial.print("Light: ");
  //Serial.println(data.substring(data.indexOf(';')+1, data.length()));
  char json[64];
  sprintf(json, "{\"Value\":%d,\"Time\":\"%s\",\"SensorId\":1}",humidity, getTime().c_str());
  return String(json);;
}

void setup(){
  // Serial port for debugging purposes
  Serial.begin(115200);
  Serial.println();

  WiFi.mode(WIFI_STA);
  //WiFiMulti.addAP("OnePlus 6", "a31506382fba");
  //WiFiMulti.addAP("HUAWEI Mate 10 lite", "06becb51bed1");
  WiFiMulti.addAP("SMCL_WAG24", "67Nec+-73");
  while((WiFiMulti.run() != WL_CONNECTED)) { 
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("Connected to WiFi");
  
  // Setting the ESP as an access point
  Serial.print("Setting AP (Access Point)…");
  // Remove the password parameter, if you want the AP (Access Point) to be open
  WiFi.softAP(ssid, password);

  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);

  for(int i=0;i<dataListSize;i++){
    dataArr[i]="";  
  }

  Serial.print("Time: ");
  Serial.println(getTime());

  delay(10000);
  server.on("/post",HTTP_POST,[](AsyncWebServerRequest * request){},NULL,[](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
    addStringToArray(dataArr, len, uintToString(data,len));
    Serial.println();
    request->send_P(200, "text/plain", "Es funktioniert");
  });

  // Start server
  server.begin();

  client = con.activateFingerprint();
  String data("{ \"mac\": \"3e:90:5e:e4:02:22\", \"password\": \"123456789\"}");
  String response = con.postServer(&client, address, 443, String("/api/Homestadion/authenticate"), data, "");
  int pos = response.indexOf("token");
  token = response.substring(pos+8, response.length()-2);
  Serial.print("Token: ");
  Serial.println(token);
}

void loop() {

  delay(200);
  String data = popStringArray(dataArr, dataListSize);
  
  if(data!=""){
    String tmp = getJsonFromData(data);
    Serial.print("POST: ");
    Serial.println(tmp);
    con.postServer(&client, address, 443, "/api/Measurement", tmp, token);
  }
}