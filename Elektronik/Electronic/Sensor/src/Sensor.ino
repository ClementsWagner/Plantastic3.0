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
#include <Adafruit_BMP280.h>

#define BMP_SCK  (13)
#define BMP_MISO (12)
#define BMP_MOSI (11)
#define BMP_CS   (10)

#define humidityDelta (float)10
#define lightDelta (float)30
#define tempDelta (float)1
#define maxTemp (float)55

ESP8266WiFiMulti WiFiMulti;

int AnalogPin = A0;    // select the input pin for the hydrometer
BH1750 lightMeter;
Adafruit_BMP280 bmp;

const char* ssid = "PlantasticController";
const char* password = "";

int counter = 0;

unsigned long previousMillis = 0;
const long interval = 5000; 

float lastSent[3] = {(float)0, (float)0, (float)0};

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
   lightMeter.begin(BH1750::ONE_TIME_HIGH_RES_MODE); //init lightmetersensor
   setupBMP();
}

void loop() {
  unsigned long currentMillis = millis();
  String data;
  if(currentMillis - previousMillis >= interval) {
    counter++;
     // Check WiFi connection status
    if ((WiFiMulti.run() == WL_CONNECTED)) {
      //httpPOSTRequest("http://192.168.4.1/post", String(counter));
      if(readSensorData(data)){
        Serial.println(data);
        httpPOSTRequest("http://192.168.4.1/post", data);
      }    
      // save the last HTTP GET Request
      previousMillis = currentMillis;
    }
    else {
      Serial.println("WiFi Disconnected");
    }
  }
}

bool readSensorData(String& result){
  bool send = false;
  float lux, temp, pressure;
  int humidity = analogRead(AnalogPin);
  lux = readLightLevel();
  temp = readTemp();
  pressure = readPressure();
  //int humidity = random(500,1000);
  //uint16_t lux = 300;

  if(absolute(lastSent[0]-((float)humidity)) >= humidityDelta){
    lastSent[0] = (float)humidity;
    send = true;
  }
  if(absolute(lastSent[1]-lux) >= lightDelta){
    lastSent[1] = lux;
    send = true;
  }
  if((absolute(lastSent[2]-temp) >= tempDelta) && temp < maxTemp){
    lastSent[2] = temp;
    send = true;
  }

  char tmp[64];
  //sprintf(tmp, "%d;%f", humidity,lux);
  String mac = String(WiFi.macAddress());
  sprintf(tmp, "{\"humidity\":%d,\"light\":%.2f,\"temperature\":%.2f,\"mac\":\"%s\"}", humidity,lux,temp,mac.c_str());
  printf("Humidity:%d; Light:%.2f; Temp:%.2f; Pressure:%.2f\n", humidity,lux, temp, pressure);
  result = tmp;
  return send;
}

float absolute(float value){
  if(value<0){
    value = value*-1;
  }
  return value;
}

float readLightLevel(){
   while (!lightMeter.measurementReady(true)) {
    yield();
  }
  float lux = lightMeter.readLightLevel();
  lightMeter.configure(BH1750::ONE_TIME_HIGH_RES_MODE);
  return lux;
}

float readTemp(){
  return bmp.readTemperature();
}

float readPressure(){
  return bmp.readPressure();
}

void setupBMP(){

  unsigned status = bmp.begin();
  int i = 0;
  if (!status) {
    Serial.println(F("Could not find a valid BMP280 sensor, check wiring or "
                      "try a different address!"));
    Serial.print("SensorID was: 0x"); Serial.println(bmp.sensorID(),16);
    Serial.print("        ID of 0xFF probably means a bad address, a BMP 180 or BMP 085\n");
    Serial.print("   ID of 0x56-0x58 represents a BMP 280,\n");
    Serial.print("        ID of 0x60 represents a BME 280.\n");
    Serial.print("        ID of 0x61 represents a BME 680.\n");
    while (i<10){
      delay(10);
      i++;
    } 
  }
  /* Default settings from datasheet. */
  bmp.setSampling(Adafruit_BMP280::MODE_NORMAL,     /* Operating Mode. */
                  Adafruit_BMP280::SAMPLING_X2,     /* Temp. oversampling */
                  Adafruit_BMP280::SAMPLING_X16,    /* Pressure oversampling */
                  Adafruit_BMP280::FILTER_X16,      /* Filtering. */
                  Adafruit_BMP280::STANDBY_MS_500); /* Standby time. */
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
