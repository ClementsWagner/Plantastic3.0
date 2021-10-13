package at.htl.superduperplantastic.homestation.error;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Error {
    private int code;
    private String message;
    private String description;
}
