package plantastic.Classes;

import java.util.UUID;

enum PlantType{
    Kaktus,
    Gemüse,
    Obst,
    Blumen
}

public class Sensor {

    private UUID id;
    private UUID homeStationId;
    private String mac;
    private String displayName;
    private PlantType plantType;
}