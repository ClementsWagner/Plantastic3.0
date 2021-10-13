package at.htl.superduperplantastic.coresensor.service;

import at.htl.superduperplantastic.coresensor.dto.HomeStation;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.UUID;

@Path("v1/homestations")
@RegisterRestClient
public interface HomeStationService {

    @GET
    @Path("/byMac/{mac}")
    @Produces(MediaType.APPLICATION_JSON)
    HomeStation getHomeStationByMac(@PathParam("mac") String mac);
}
