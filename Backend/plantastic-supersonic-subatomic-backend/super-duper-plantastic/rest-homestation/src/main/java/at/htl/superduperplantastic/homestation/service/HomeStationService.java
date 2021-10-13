package at.htl.superduperplantastic.homestation.service;

import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import at.htl.superduperplantastic.homestation.dto.HomeStation;
import at.htl.superduperplantastic.homestation.service.model.RegisterDataModel;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.UUID;

@Path("v1/homestations")
@RegisterRestClient
public interface HomeStationService {

    @GET
    List<HomeStation> getHomeStations();

    @GET
    @Path("/user/{id}")
    List<HomeStation> getHomeStationsByUser(@PathParam("id") String userId);

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
    Response registerHomeStation(RegisterDataModel registerData);

    @GET
    @Path("{id}/unregister")
    @Consumes(MediaType.APPLICATION_JSON)
    Response unRegisterHomeStation(@PathParam("id") UUID id);

    @GET
    @Path("{id}/members")
    @Produces(MediaType.APPLICATION_JSON)
    Response getAllHomeStationMembers(@PathParam("id") UUID id);
}
