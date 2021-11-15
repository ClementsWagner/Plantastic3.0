#include <Arduino.h>
#include <ArduinoJson.h>
#include <FS.h>
#include <SPIFFSReader.h>
#include <TLS.h>
#include <time.h>
#include <ESPAsyncWebServer.h>
#include <ESPAsyncTCP.h>
#include <ESP8266WiFiMulti.h>
#include <ESPAsyncWiFiManager.h>


#define dataListSize 100

ESP8266WiFiMulti WiFiMulti;
int postCount = 0;
uint8_t *postData;
size_t dataSize;

String dataArr[dataListSize];
TLS con = TLS();

const char* ssid = "PlantasticController";
const char* password = "123456789";
//Server address for development
String address = "localhost:3000";
//Real server address
//String address = "192.88.24.215"; 



String token;
// Create AsyncWebServer object on port 80
AsyncWebServer server(80);
DNSServer dns;

BearSSL::WiFiClientSecure client;

SPIFFSReader reader = SPIFFSReader();
SPIFFSReader::Config config;

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
  return String(json);
}

void getApiToken(){
  client = con.activateFingerprint();
  //String data("{ \"mac\": \""+WiFi.macAddress()+"\", \"password\": \"123456789\"}");
  String data("{ \"mac\": \"3e:90:5e:e4:02:22\", \"password\": \"123456789\"}");
  String response = con.postServer(&client, address, 443, String("/api/Homestadion/authenticate"), data, "");
  Serial.print("Authentication: ");
  Serial.println(data);
  int pos = response.indexOf("token");
  token = response.substring(pos+8, response.length()-2);
  Serial.print("Token: ");
  Serial.println(token);
}

void connectWifi(){
  WiFi.mode(WIFI_STA);
  WiFiMulti.addAP(config.SSID, config.Password);

  while((WiFiMulti.run() != WL_CONNECTED)) { 
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi");
  getApiToken();
}

void setupAccessPoint(){
  Serial.print("Setting AP (Access Point)…");
  // Remove the password parameter, if you want the AP (Access Point) to be open
  WiFi.softAP(ssid, "1234");

  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);
}

void setupWifi(){
  AsyncWiFiManager wifiManager(&server,&dns);
  wifiManager.autoConnect("PlantasticController");
}

void setup(){
  // Serial port for debugging purposes
  Serial.begin(115200);
  Serial.println();

  Serial.print("Mac Address: ");
  Serial.println(WiFi.macAddress());

  setupWifi();

  while(!WiFi.isConnected()){
    delay(100);
  }

  //API Token has not been implemented server side
  //getApiToken();
  
  
  // Setting the ESP as an access point
  setupAccessPoint();
  

  for(int i=0;i<dataListSize;i++){
    dataArr[i]="";  
  }

  delay(1000);
  server.on("/post",HTTP_POST,[](AsyncWebServerRequest * request){},NULL,[](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
    addStringToArray(dataArr, len, uintToString(data,len));
    Serial.println();
    request->send_P(200, "text/plain", "Es funktioniert");
  });
  server.on("/wifi",HTTP_POST,[](AsyncWebServerRequest * request){},NULL,[](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
    DynamicJsonDocument doc(1024);

    String input = uintToString(data,len);
    deserializeJson(doc, input);
    strlcpy(config.SSID,                  // <- destination
          doc["SSID"] | "",  // <- source
          sizeof(config.SSID));  
    strlcpy(config.Password,                  // <- destination
    doc["Password"] | "",  // <- source
    sizeof(config.Password));  
    if(reader.saveConfiguation("/wifi.json",config)){
      connectWifi();
    }
  });
  // Start server
  server.begin();
}

void loop() {
  
  //String route = "/api/Measurement";

  //Route for development on json-server
  String route = "/measurements";
  delay(200);
  if(WiFi.isConnected()){
    String data = popStringArray(dataArr, dataListSize);
    if(data!=""){
      String tmp = getJsonFromData(data);
      Serial.print("POST: ");
      Serial.println(tmp);
      con.postServer(&client, address, 443, route, tmp, token);
    }
  }
}