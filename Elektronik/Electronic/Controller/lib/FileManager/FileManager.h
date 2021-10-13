#ifndef FileManager_H
#define FileManager_H
#include <ArduinoJson.h>
#include <FS.h>

class FileManager{
    public:
    bool loadConfig(const char*filename, StaticJsonDocument<512> &doc);
    bool saveConfig(const char*filename, StaticJsonDocument<512> &doc);
    void printConfig(const char*filename);
    FileManager();
};
#endif