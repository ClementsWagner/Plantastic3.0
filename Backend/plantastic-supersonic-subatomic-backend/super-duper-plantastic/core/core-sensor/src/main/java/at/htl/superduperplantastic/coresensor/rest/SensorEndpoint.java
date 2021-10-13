package at.htl.superduperplantastic.coresensor.rest;

import at.htl.superduperplantastic.coresensor.dto.RegisterSensorData;
import at.htl.superduperplantastic.coresensor.dto.RegisterSensorDataMac;
import at.htl.superduperplantastic.coresensor.dto.Sensor;
import at.htl.superduperplantastic.coresensor.service.SensorService;

import javax.inject.Inject;
import javax.print.attribute.standard.Media;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.UUID;

@Path("/v1/sensors")
public class SensorEndpoint {

    @Inject
    SensorService sensorService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllSensors() {
        return Response.ok(sensorService.getAllSensors()).build();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/{homeStationId}")
    public Response getAllSensorsByHomeStation(@PathParam("homeStationId") UUID homeStationId) {
        return Response.ok(sensorService.getSensorsByHomeStation(homeStationId)).build();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createSensor(Sensor sensor) {
        return Response.ok(sensorService.createSensor(sensor)).build();
    }

    @POST
    @Path("register")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response registerSensor(RegisterSensorData registerSensorData) {
        return Response.ok(sensorService.registerSensor(registerSensorData)).build();
    }

    @POST
    @Path("register/mac")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response registerSensorWithMac(RegisterSensorDataMac registerSensorDataMac) {
        return Response.ok(sensorService.registerSensorWithMac(registerSensorDataMac)).build();
    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateSensor(Sensor sensor) {
        sensorService.updateSensor(sensor);
        return Response.ok().build();
    }
}
