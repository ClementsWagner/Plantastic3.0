package at.htl.superduperplantastic.homestation.rest;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;
import at.htl.superduperplantastic.homestation.dto.*;

@Path("api/v1/homestations")
@Produces(MediaType.APPLICATION_JSON)
public interface IHomeStation {

    @GET
    @RolesAllowed("user")
    Response getHomeStations();

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed("admin")
    Response createHomeStation(HomeStation homeStation);

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed("user")
    Response updateHomeStation(HomeStation homeStation);

    @POST
    @Path("{id}/credentials")
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed("admin")
    Response addCredential(@PathParam("id") UUID id, String password) throws NoSuchAlgorithmException;

    @POST
    @Path("register")
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed("user")
    Response registerHomeStation(RegisterData registerData);

    @GET
    @Path("{id}/unregister")
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed("user")
    Response unRegisterHomeStation(@PathParam("id") UUID id);

    @GET
    @Path("{id}/members")
    @Produces(MediaType.APPLICATION_JSON)
    Response getAllHomeStationMembers(@PathParam("id") UUID id);
}
