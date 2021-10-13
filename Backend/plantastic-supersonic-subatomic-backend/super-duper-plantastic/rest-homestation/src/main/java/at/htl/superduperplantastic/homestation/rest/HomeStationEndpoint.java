package at.htl.superduperplantastic.homestation.rest;

import at.htl.superduperplantastic.homestation.dto.*;
import at.htl.superduperplantastic.homestation.service.HomeStationService;
import at.htl.superduperplantastic.homestation.service.model.RegisterDataModel;
import org.eclipse.microprofile.jwt.JsonWebToken;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.core.Response;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

@RequestScoped
public class HomeStationEndpoint implements IHomeStation {


    @Inject
    JsonWebToken jwt;

    @Inject
    @RestClient
    HomeStationService homeStationService;

    @Override
    public Response registerHomeStation(RegisterData registerData) {
        var model = new RegisterDataModel();
        model.mac = registerData.getMac();
        model.password = registerData.getPassword();
        model.userId = jwt.getSubject();
        return homeStationService.registerHomeStation(model);
    }

    @Override
    public Response getHomeStations() {
        // Get user object from token
        var userId = jwt.getSubject();
        var homeStations = homeStationService.getHomeStationsByUser(jwt.getSubject());
        return Response.ok(homeStations).build();
    }

    @Override
    public Response createHomeStation(HomeStation homeStation) {
        return homeStationService.createHomeStation(homeStation);
    }

    @Override
    public Response updateHomeStation(HomeStation homeStation) {
        return homeStationService.updateHomeStation(homeStation);
    }


    @Override
    public Response addCredential(UUID id, String password) throws NoSuchAlgorithmException {
        return homeStationService.addCredential(id, password);
    }

    @Override
    public Response unRegisterHomeStation(UUID id) {
        return homeStationService.unRegisterHomeStation(id);
    }

    public Response getAllHomeStationMembers(UUID id) {
        return homeStationService.getAllHomeStationMembers(id);
    }

}
