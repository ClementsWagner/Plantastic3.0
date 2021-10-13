package at.htl.superduperplantastic.coresensor.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class RegisterSensorData {
    private UUID sensorId;
    private UUID homeStationId;
}
