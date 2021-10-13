package at.htl.superduperplantastic.homestation.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class HomeStation {
    private UUID id;
    private String mac;
    private String name;
}
