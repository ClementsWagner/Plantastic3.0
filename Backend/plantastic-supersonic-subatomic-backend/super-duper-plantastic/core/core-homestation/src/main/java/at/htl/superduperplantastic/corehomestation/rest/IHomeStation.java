package at.htl.superduperplantastic.corehomestation.rest;

import at.htl.superduperplantastic.corehomestation.dto.HomeStation;
import at.htl.superduperplantastic.corehomestation.dto.RegisterData;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

@Path("v1/homestations")
@Produces(MediaType.APPLICATION_JSON)
public interface IHomeStation {

    @GET
    String hello();

    @GET
    Response getHomeStations();

    @GET
    @Path("/user/{id}")
    Response getHomeStations(@PathParam("id") String userId);

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    Response createHomeStation(HomeStation homeStation);

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    Response updateHomeStation(HomeStation homeStation);

    @POST
    @Path("{id}/credentials")
    @Consumes(MediaType.APPLICATION_JSON)
    Response addCredential(@PathParam("id") UUID id, String password) throws NoSuchAlgorithmException;

    @POST
    @Path("register")
    @Consumes(MediaType.APPLICATION_JSON)
    Response registerHomeStation(RegisterData registerData);

    @GET
    @Path("{id}/unregister")
    @Consumes(MediaType.APPLICATION_JSON)
    Response unRegisterHomeStation(@PathParam("id") UUID id);

    @GET
    @Path("{id}/members")
    @Produces(MediaType.APPLICATION_JSON)
    Response getAllHomeStationMembers(@PathParam("id") UUID id);

    @GET
    @Path("/byMac/{mac}")
    @Produces(MediaType.APPLICATION_JSON)
    Response getHomeStationByMac(@PathParam("mac") String mac);
}
