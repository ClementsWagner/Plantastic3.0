package plantastic;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

enum PlantType{
    Kaktus,
    Gemüse,
    Obst,
    Blumen
}

@Getter
@Setter
public class Sensor {

    private UUID id;
    private UUID homeStationId;
    private String mac;
    private String displayName;
    private PlantType plantType;
}

@Getter
@Setter
public class SensorData {

    private UUID id;
    private UUID sensorId;
    private double power;
    private double moisture;
    private boolean available;
    private double light;
}