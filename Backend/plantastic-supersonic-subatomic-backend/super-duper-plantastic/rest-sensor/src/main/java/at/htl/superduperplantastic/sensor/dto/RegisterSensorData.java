package at.htl.superduperplantastic.sensor.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class RegisterSensorData {
    private UUID homeStationId;
    private UUID sensorId;
}
