package at.htl.superduperplantastic.keycloak.service;

import at.htl.superduperplantastic.keycloak.config.KeycloakClientConfiguration;
import at.htl.superduperplantastic.keycloak.dto.User;
import at.htl.superduperplantastic.keycloak.dto.mapper.UserMapper;
import at.htl.superduperplantastic.keycloak.exception.KCServerConnectionException;
import at.htl.superduperplantastic.keycloak.exception.UserNotFoundException;

import org.jboss.logging.Logger;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.GroupRepresentation;
import org.keycloak.representations.idm.UserRepresentation;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@ApplicationScoped
public class KeycloakService {

    private KeycloakClientConfiguration configuration;
    private Keycloak keycloak;

    @Inject
    UserMapper userMapper;

    @Inject
    Logger logger;

    private RealmResource realmResource = null;
    private UsersResource usersResource = null;

    public KeycloakService(KeycloakClientConfiguration configuration) throws KCServerConnectionException {
        this.configuration = configuration;
        keycloak = KeycloakBuilder.builder()
                .serverUrl(configuration.serverUrl())
                .realm(configuration.realm())
                .clientId(configuration.clientId())
                .username(configuration.username())
                .password(configuration.password()).build();
        getUsersResource();
    }

    private void getRealmResource() throws KCServerConnectionException {
        if (keycloak == null) {
            throw new KCServerConnectionException("Realm Resource not available");
        }
        realmResource = keycloak.realm(configuration.realm());
    }

    private void getUsersResource() throws KCServerConnectionException {
        if (realmResource == null) {
            getRealmResource();
        }
        usersResource = realmResource.users();
    }

    public User getUserByUUID(String uuid) throws UserNotFoundException {
        return toDto(findUserByUUID(uuid));
    }

    /***
     * Find a user by UUID
     * @param uuid : User Id
     * @return the correspondent UserRepresentation or a new empty one as fallback
     */
    private UserRepresentation findUserByUUID(String uuid) throws UserNotFoundException {
        Optional<UserResource> userResource = Optional.of(usersResource.get(uuid));

        Optional.of(userResource.get().toRepresentation())
                .orElseThrow(() -> new UserNotFoundException(String.format("User with UUID : %s not found!", uuid)));
        return userResource.get().toRepresentation();
    }

    /**
     * Delete a user by UUID
     *
     * @param uuid : User Identifier
     */
    public void deleteUserByUUID(String uuid) throws UserNotFoundException {
        UserResource userResource = getUserResourceByUuid(uuid);
        Response.StatusType status = usersResource.delete(userResource.toRepresentation().getId()).getStatusInfo();
        if (status.getStatusCode() == Response.Status.NO_CONTENT.getStatusCode()) {
            logger.info("User has been removed ! \n");
        } else {
            logger.error(String.format("Failed to remove user , Reason : %s %n", status.getReasonPhrase()));
        }
    }

    public List<User> getAllUsers() {
        return usersResource
                .list()
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    private User toDto(UserRepresentation userRepresentation) {
        return userMapper.toDto(userRepresentation);
    }

    private UserResource getUserResourceByUuid(String uuid) throws UserNotFoundException {
        UserResource userResource = realmResource
                .users()
                .get(uuid);
        if (userResource == null) {
            throw new UserNotFoundException(String.format("User with uuid %s not found!", uuid));
        }
        return userResource;
    }
}
