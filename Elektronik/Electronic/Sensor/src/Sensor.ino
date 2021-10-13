/*
  Rui Santos
  Complete project details at https://RandomNerdTutorials.com/esp8266-client-server-wi-fi/
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files.
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
*/

#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <Wire.h>
#include <BH1750.h>
#include <ESP8266WiFiMulti.h>

ESP8266WiFiMulti WiFiMulti;

int AnalogPin = A0;    // select the input pin for the hydrometer
BH1750 lightMeter;

const char* ssid = "PlantasticController";
const char* password = "";

int counter = 0;

unsigned long previousMillis = 0;
const long interval = 5000; 

void setup() {
  Serial.begin(115200);
  Serial.println();
  
  WiFi.mode(WIFI_STA);
  WiFiMulti.addAP(ssid, password);
  while((WiFiMulti.run() != WL_CONNECTED)) { 
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("Connected to WiFi");

   Wire.begin(); //init i2c Bus
   lightMeter.begin(); //init lightmetersensor
}

void loop() {
  unsigned long currentMillis = millis();
  
  if(currentMillis - previousMillis >= interval) {
    counter++;
     // Check WiFi connection status
    if ((WiFiMulti.run() == WL_CONNECTED)) {
      //httpPOSTRequest("http://192.168.4.1/post", String(counter));
      Serial.println(readSensorData());
      httpPOSTRequest("http://192.168.4.1/post", readSensorData());
      // save the last HTTP GET Request
      previousMillis = currentMillis;
    }
    else {
      Serial.println("WiFi Disconnected");
    }
  }
}

String readSensorData(){
  int humidity = analogRead(AnalogPin);
  uint16_t lux = lightMeter.readLightLevel();
  //int humidity = 11;
  //uint16_t lux = 20;
  char tmp[64];
  sprintf(tmp, "%d;%u", humidity,lux);
  String result = tmp;
  return result;
}

String httpGETRequest(const char* serverName) {
  WiFiClient client;
  HTTPClient http;
    
  // Your IP address with path or Domain name with URL path 
  http.begin(client, serverName);
  
  // Send HTTP POST request
  int httpResponseCode = http.GET();
  
  String payload = "--"; 
  
  if (httpResponseCode>0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    payload = http.getString();
  }
  else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }
  // Free resources
  http.end();

  return payload;
}

String httpPOSTRequest(const char* serverName, String body){
  WiFiClient client;
  HTTPClient http;
    
  // Your IP address with path or Domain name with URL path 
  http.begin(client, serverName);
  // Send HTTP POST request
  int httpResponseCode = http.POST(body);
  
  String payload = "--"; 
  
  if (httpResponseCode>0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    payload = http.getString();
  }
  else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }
  // Free resources
  http.end();

  return payload;
}
