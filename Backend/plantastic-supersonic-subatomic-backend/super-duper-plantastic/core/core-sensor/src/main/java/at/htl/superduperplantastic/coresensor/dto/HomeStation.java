package at.htl.superduperplantastic.coresensor.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class HomeStation {
    private UUID id;
    private String mac;
    private String name;
}
