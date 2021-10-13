package at.htl.superduperplantastic.sensor.service;

import at.htl.superduperplantastic.sensor.dto.RegisterSensorData;
import at.htl.superduperplantastic.sensor.dto.RegisterSensorDataMac;
import at.htl.superduperplantastic.sensor.dto.Sensor;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.print.attribute.standard.Media;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.UUID;

@Path("v1/sensors")
@RegisterRestClient
public interface SensorService {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    List<Sensor> getAllSensors();

    @GET
    @Path("/{homeStationId}")
    @Produces(MediaType.APPLICATION_JSON)
    List<Sensor> getAllSensorsByHomeStation(@PathParam("homeStationId") UUID homeStationId);

    @POST
    @Path("/register")
    @Consumes(MediaType.APPLICATION_JSON)
    UUID registerSensor(RegisterSensorData registerSensorData);

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    Response createSensor(Sensor sensor);

    @POST
    @Path("/register/mac")
    @Consumes(MediaType.APPLICATION_JSON)
    Response registerSensorWithMac(RegisterSensorDataMac registerSensorDataMac);

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    Response updateSensor(Sensor sensor);
}
