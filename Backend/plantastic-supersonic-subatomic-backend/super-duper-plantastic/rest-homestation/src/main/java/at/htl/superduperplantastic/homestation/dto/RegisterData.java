package at.htl.superduperplantastic.homestation.dto;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RegisterData {
    private String mac;
    private String password;
}
