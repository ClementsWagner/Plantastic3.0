#include "FileManager.h"

FileManager::FileManager(){
    if(!SPIFFS.begin()){
        Serial.println(F("Failed to mount file system"));
    }
}

bool FileManager::loadConfig(const char*filename, StaticJsonDocument<512> &doc){
    File file = SPIFFS.open(filename,"r");
    if(!file){
        Serial.println(F("Failed to open file. Path or filename might be wrong!"));
        return false;
    }

    DeserializationError error = deserializeJson(doc,file);
    if(error){
        Serial.println(F("Failed to read file, using default configuration!"));
    }
    file.close();
    return true;
}

bool FileManager::saveConfig(const char*filename, StaticJsonDocument<512> &doc){
    SPIFFS.remove(filename);

    File file = SPIFFS.open(filename,"r");
    if(!file){
        Serial.println(F("Faild to create file!"));
        return false;
    }
    if(serializeJson(doc,file) == 0){
        Serial.println(F("Failed to write to file"));
        return false;
    }
    file.close();
    return true;
}

void FileManager::printConfig(const char*filename){
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