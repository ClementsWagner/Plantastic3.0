package at.htl.superduperplantastic.keycloak.error;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NonNull;

@Data
@AllArgsConstructor
public class Error {
    @NonNull
    private int code;
    @NonNull
    private String message;
    @NonNull
    private String description;
}
