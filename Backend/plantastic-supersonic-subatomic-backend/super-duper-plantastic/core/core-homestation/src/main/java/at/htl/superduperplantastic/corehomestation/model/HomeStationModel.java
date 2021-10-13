package at.htl.superduperplantastic.corehomestation.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity(name = "homestation")
@Getter
@Setter
@NoArgsConstructor
public class HomeStationModel {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Type(type = "pg-uuid")
    private UUID id;

    @Column(name="mac")
    private String mac;

    @Column(name="name")
    private String name;

    @Column(name="password_hash")
    private byte[] passwordHash;

    @Column(name="password_salt")
    private byte[] passwordSalt;

    @ElementCollection(fetch=FetchType.EAGER)
    @CollectionTable(name="homestation_users", joinColumns=@JoinColumn(name="homestation_id"))
    @Column(name = "user_id")
    private Set<String> users = new HashSet<>();
}
