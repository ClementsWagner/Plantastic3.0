package at.htl.superduperplantastic.coresensor.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class Sensor {
    private UUID id;

    private String displayName;

    private String mac;

    private double power;

    private boolean available;

    private double moisture;

    private double light;
}
