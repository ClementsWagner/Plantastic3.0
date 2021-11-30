#include "SPIFFSReader.h"


bool SPIFFSReader::loadConfiguration(const char *filename, Config &config){
    File file = SPIFFS.open(filename,"r");
    if(!file){
        Serial.println("Failed to open config file");
        return false;
    }

    StaticJsonDocument<512> doc;

    // Deserialize the JSON document
    DeserializationError error = deserializeJson(doc, file);
    if (error){
        Serial.println(F("Failed to read file, using default configuration"));
        return false;
    }
  // Copy values from the JsonDocument to the Config
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

    file.close();
    return true;
}

bool SPIFFSReader::saveConfiguation(const char *filename, Config &config){
    SPIFFS.remove(filename);

    File file = SPIFFS.open(filename, "w");
    if(!file){
        Serial.println(F("Failed to create file"));
        return false;
    }

    StaticJsonDocument<256> doc;

    doc["SSID"] = config.SSID;
    doc["Password"] = config.Password;

    if(serializeJson(doc,file) == 0){
        Serial.println(F("Failed to write to File"));
    }
    file.close();
    return true;
}

void SPIFFSReader::printFile(const char *filename) {
  // Open file for reading
  File file = SPIFFS.open(filename,"r");
  if (!file) {
    Serial.println(F("Failed to read file"));
    return;
  }

  // Extract each characters by one by one
  while (file.available()) {
    Serial.print((char)file.read());
  }
  Serial.println();

  // Close the file
  file.close();
}