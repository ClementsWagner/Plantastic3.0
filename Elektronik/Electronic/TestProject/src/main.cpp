#include <Arduino.h>

#include <SPIFFS.h>
#include <ArduinoJson.h>
#include <FS.h>
#include "SPIFFSReader.h"

SPIFFSReader fileReader = SPIFFSReader();

SPIFFSReader::Config config;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  if(!SPIFFS.begin()){
    Serial.println("Failed to mount file system");
    return;
  }
  /*
  if(!fileReader.saveConfiguation("/wifi.json",config)){
    Serial.println("Failed to save config");
  }
  else
  {
    Serial.println("Config saved");
  }
  
  if(!fileReader.loadConfiguration("/wifi.json",config)){
    Serial.println("Failed to load config");
  }
  else {
    Serial.println("Config load");
    Serial.println(config.SSID);
  }*/
  fileReader.printFile("/wifi.json");
}

void loop() {
  // put your main code here, to run repeatedly:
  
}