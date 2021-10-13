package at.htl.superduperplantastic.keycloak.dto.mapper;


import at.htl.superduperplantastic.keycloak.dto.User;
import org.keycloak.representations.idm.UserRepresentation;
import org.mapstruct.Mapper;

@Mapper(config = QuarkusMapper.class)
public interface UserMapper {

    User toDto(UserRepresentation userRepresentation);

    UserRepresentation toEntity(User userRepresentationDto);
}

