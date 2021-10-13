package at.htl.superduperplantastic.corehomestation.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RegisterData {
    private String mac;
    private String password;
    private String userId;
}
