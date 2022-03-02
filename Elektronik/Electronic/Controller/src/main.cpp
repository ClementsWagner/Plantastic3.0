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
#include <string>
#include <WiFiClient.h>
#include <ESP8266HTTPClient.h>

#define dataListSize 100
#define RED D4
#define GREEN D5
#define BLUE D6


ESP8266WiFiMulti WiFiMulti;
int postCount = 0;
uint8_t *postData;
size_t dataSize;

String dataArr[dataListSize];
//TLS con = TLS();

const char* ssid = "PlantasticController";
const char* password = "123456789";
//Server address for development
//ID: 45r34-1638277687
String address = "http://wag.familyds.org:8080";
//String address = "http://demo7253786.mockable.io/plantastic";
//Real server address
//String address = "192.88.24.215"; 



String token;
// Create AsyncWebServer object on port 80
AsyncWebServer server(80);
DNSServer dns;

//BearSSL::WiFiClientSecure client;
WiFiClient httpClient;

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
  char json[64];
  //sprintf(json, "{\"Value\":%d,\"Time\":\"%s\",\"SensorId\":1}",humidity, getTime().c_str());
  return data;
}

/*void getApiToken(){
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
}*/

void connectWifi(){
  WiFi.mode(WIFI_STA);
  WiFiMulti.addAP(config.SSID, config.Password);

  while((WiFiMulti.run() != WL_CONNECTED)) { 
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi");
  //getApiToken();
}

void setupAccessPoint(){
  Serial.print("Setting AP (Access Point)…");
  // Remove the password parameter, if you want the AP (Access Point) to be open
  WiFi.softAP(ssid);

  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);
}

void setupWifi(){
  AsyncWiFiManager wifiManager(&server,&dns);
  wifiManager.autoConnect("Plantastic-Setup");
}

int postServerUnsecureDemo(WiFiClient client, String host, const uint16_t port, String path,String data) {
  HTTPClient http;
  String url = String(host+path);
  Serial.println("Open Connection");
  http.begin(client, url);
  http.addHeader("Content-Type","application/json");
  http.addHeader("Host", host);
  http.addHeader("Content-Length", String(strlen(data.c_str())));
  int httpCode = http.POST(data);

  Serial.printf("Trying: "); Serial.println(url);
  Serial.printf("Http response: %d",httpCode);

  http.end();
  return httpCode;
}

void setup(){
  // Serial port for debugging purposes
  pinMode(RED, OUTPUT);
  pinMode(BLUE, OUTPUT);
  pinMode(GREEN, OUTPUT);
  Serial.begin(115200);
  Serial.println();
  digitalWrite(RED, HIGH);
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, LOW);

  Serial.print("Mac Address: ");
  Serial.println(WiFi.macAddress());

  Serial.println("Setup Wifi...");

  digitalWrite(RED, LOW);
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, HIGH);

  setupWifi();

  while(!WiFi.isConnected()){
    delay(100);
  }

    Serial.println("Wifi Setup");
  //API Token has not been implemented server side
  //getApiToken();
  
  
  // Setting the ESP as an access point

  setupAccessPoint();

  for(int i=0;i<dataListSize;i++){
    dataArr[i]="";  
  }

  Serial.println("Acesspoint Setup");
  digitalWrite(RED, LOW);
  digitalWrite(GREEN, HIGH);
  digitalWrite(BLUE, LOW);

  delay(1000);
  server.on("/post",HTTP_POST,[](AsyncWebServerRequest * request){},NULL,[](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
    addStringToArray(dataArr, len, uintToString(data,len));
    Serial.println();
    Serial.println("POST receive");
    request->send_P(200, "text/plain", "Es funktioniert");
  });
  server.on("/wifi",HTTP_POST,[](AsyncWebServerRequest * request){},NULL,[](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
    DynamicJsonDocument doc(1024);

    String input = uintToString(data,len);
    deserializeJson(doc, input);
    /*strlcpy(config.SSID,                  // <- destination
          doc["SSID"] | "",  // <- source
          sizeof(config.SSID));  
    strlcpy(config.Password,                  // <- destination
    doc["Password"] | "",  // <- source
    sizeof(config.Password));  */
    strcpy(config.SSID,                  
          doc["SSID"] | "");
    strcpy(config.Password,                 
    doc["Password"] | "");

    Serial.print("SSID:");Serial.println(config.SSID);
    Serial.print("Password");Serial.println(config.Password);

    if(reader.saveConfiguation("/wifi.json",config)){
      connectWifi();
    }
  });
  
  // Start server
  //server.begin();
  Serial.println("Server start");

  //Deactivate auth
  token = "";

 
}

void loop() {
  
  //String route = "/api/Measurement";
  //Route for development on json-server
  //String route = "/post";
  delay(200);
  if(WiFi.isConnected()){
    String data = popStringArray(dataArr, dataListSize);
    if(data!=""){
      String tmp = data;
      Serial.print("POST: ");
      Serial.println(tmp);
      //con.postServer(&client, address, 80, route, tmp, token);
      Serial.println("Post to Server:");
      postServerUnsecureDemo(httpClient, address, 8080, "/data.php", tmp);
    }
  }
}