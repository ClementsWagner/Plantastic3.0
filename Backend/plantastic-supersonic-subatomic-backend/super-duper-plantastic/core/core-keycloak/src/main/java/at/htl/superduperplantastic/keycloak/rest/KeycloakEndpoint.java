package at.htl.superduperplantastic.keycloak.rest;

import at.htl.superduperplantastic.keycloak.dto.User;
import at.htl.superduperplantastic.keycloak.exception.UserNotFoundException;
import at.htl.superduperplantastic.keycloak.service.KeycloakService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;
import java.util.UUID;

@Path("/v1/keycloak")
public class KeycloakEndpoint {

    @Inject
    KeycloakService keycloakService;

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public User getUserById(@PathParam("id") String id) throws UserNotFoundException {
        return keycloakService.getUserByUUID(id);
    }
}
