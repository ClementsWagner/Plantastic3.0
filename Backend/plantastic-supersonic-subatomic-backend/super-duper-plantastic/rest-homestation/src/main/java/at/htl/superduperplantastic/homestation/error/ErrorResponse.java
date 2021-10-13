package at.htl.superduperplantastic.homestation.error;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class ErrorResponse {
    private List<Error> errors = new ArrayList<>();
}
