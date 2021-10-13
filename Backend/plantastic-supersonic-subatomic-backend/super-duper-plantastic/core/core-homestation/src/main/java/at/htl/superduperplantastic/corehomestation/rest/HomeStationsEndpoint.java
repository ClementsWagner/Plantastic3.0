package at.htl.superduperplantastic.corehomestation.rest;

import at.htl.superduperplantastic.corehomestation.dto.HomeStation;
import at.htl.superduperplantastic.corehomestation.dto.RegisterData;
import at.htl.superduperplantastic.corehomestation.dto.User;
import at.htl.superduperplantastic.corehomestation.service.HomeStationService;

import javax.inject.Inject;

import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class HomeStationsEndpoint implements IHomeStation {

    @Inject
    HomeStationService homeStationService;

    @Override
    public String hello() {
        return null;
    }

    @Override
    public Response registerHomeStation(RegisterData registerData) {

        var isRegister = homeStationService.registerHomeStation(registerData, registerData.getUserId());
        // Response should be the added station
        if (!isRegister) {
            return Response.status(Response.Status.NOT_FOUND).entity("Wrong password").build();
        }
        return Response.ok().build();
    }

    @Override
    public Response getHomeStations() {
        // Get user object from token
        var homeStations = homeStationService.getHomeStations();
        // Get all homeStations from service
        return Response.ok(homeStations).build();
    }

    @Override
    public Response getHomeStations(String userId) {
        // Get user object from token
        var homeStations = homeStationService.getHomeStationsByUser(userId);
        // Get all homeStations from service
        return Response.ok(homeStations).build();
    }


    @Override
    public Response createHomeStation(HomeStation homeStation) {
        return Response.ok(homeStationService.addHomeStation(homeStation)).build();
    }

    @Override
    public Response updateHomeStation(HomeStation homeStation) {
        homeStationService.updateHomeStation(homeStation);
        return Response.noContent().build();
    }

    @Override
    public Response addCredential(UUID id, String password) throws NoSuchAlgorithmException {
        homeStationService.addCredentialsToHomeStation(id,password);
        return Response.ok().build();
    }

    @Override
    public Response unRegisterHomeStation(UUID id) {
        // Remove association
        homeStationService.unRegisterHomeStation(id, null);
        return Response.ok().build();
    }

    @Override
    public Response getAllHomeStationMembers(UUID id) {
        return Response.ok(homeStationService.getMembersFromHomeStation(id)).build();
    }

    @Override
    public Response getHomeStationByMac(String mac) {
        return Response.ok(homeStationService.getHomeStationByMac(mac)).build();
    }

}
