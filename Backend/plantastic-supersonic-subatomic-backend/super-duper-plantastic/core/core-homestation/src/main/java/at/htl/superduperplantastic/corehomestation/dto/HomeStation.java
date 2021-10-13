package at.htl.superduperplantastic.corehomestation.dto;

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
