package at.htl.superduperplantastic.coresensor.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterSensorDataMac {
    private String homeStationMac;
    private String sensorMac;
}
