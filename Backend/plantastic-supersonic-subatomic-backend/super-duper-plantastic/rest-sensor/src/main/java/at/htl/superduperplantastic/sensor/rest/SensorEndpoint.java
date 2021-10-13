package at.htl.superduperplantastic.sensor.rest;

import at.htl.superduperplantastic.sensor.dto.RegisterSensorData;
import at.htl.superduperplantastic.sensor.dto.RegisterSensorDataMac;
import at.htl.superduperplantastic.sensor.dto.Sensor;
import at.htl.superduperplantastic.sensor.service.SensorService;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.net.URI;
import java.util.UUID;

@Path("/api/v1/sensors")
public class SensorEndpoint {

    @Inject
    @RestClient
    SensorService sensorService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllSensors() {
        return Response.ok(sensorService.getAllSensors()).build();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/homestation/{homeStationId}")
    public Response getAllSensorsByHomeStation(@PathParam("homeStationId") UUID homeStationId) {
        return Response.ok(sensorService.getAllSensorsByHomeStation(homeStationId)).build();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/register")
    public Response registerSensor(RegisterSensorData registerSensorData, @Context UriInfo uriInfo) {
        var response = sensorService.registerSensor(registerSensorData);
        if(response != null) {
            var builder = uriInfo.getAbsolutePathBuilder().path(response.toString());
            return Response.created(builder.build()).build();
        }
        return Response.serverError().build();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/register/mac")
    public Response registerSensorWithMac(RegisterSensorDataMac registerSensorDataMac, @Context UriInfo uriInfo) {
        var response = sensorService.registerSensorWithMac(registerSensorDataMac);
        if(response != null) {
            var builder = uriInfo.getAbsolutePathBuilder().path(response.toString());
            return Response.created(builder.build()).build();
        }
        return Response.serverError().build();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createSensor(Sensor sensor) {
        return sensorService.createSensor(sensor);
    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateSensor(Sensor sensor) {return sensorService.updateSensor(sensor);}
}
