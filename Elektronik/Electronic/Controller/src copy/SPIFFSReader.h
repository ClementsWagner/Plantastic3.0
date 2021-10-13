#ifndef SPIFFSReader_H
#define SPIFFSReader_H

#include <ArduinoJson.h>
#include <SD.h>
#include <SPI.h>
#include <SPIFFS.h>
#include <FS.h>
class SPIFFSReader{
	public:
	struct Config{
        char SSID[64];
        char Password[64];;
    };
    public:
    bool loadConfiguration(const char *filename, Config &config);
    bool saveConfiguation(const char *filename, Config &config);
    void printFile(const char *filename);
};

#endif