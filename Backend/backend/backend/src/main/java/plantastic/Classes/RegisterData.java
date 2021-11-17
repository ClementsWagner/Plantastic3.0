package plantastic;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class RegisterData {

    private UUID id;
    private UUID userId;
    private int homeStationId;
    private boolean notification;
}