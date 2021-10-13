/*#ifndef Config_H
#define Config_H
#include <ArduinoJson.h>
#include <FileManager.h>

class Config{
    public:
    struct Wifi{
        char SSID[64];
        char Password[64];
    };
    public:
    bool loadWifiConfig(Wifi &wifiConfig);
    bool saveWifiConfig(Wifi &wifiConfig);
    bool loadPassword(String &password);
};
#endif*/