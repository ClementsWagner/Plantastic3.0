package at.htl.superduperplantastic.corehomestation.client;

import at.htl.superduperplantastic.corehomestation.dto.User;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.UUID;

@Path("v1/keycloak")
@RegisterRestClient
public interface KeycloakService {

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    User getUserById(@PathParam("id") String id);
}
