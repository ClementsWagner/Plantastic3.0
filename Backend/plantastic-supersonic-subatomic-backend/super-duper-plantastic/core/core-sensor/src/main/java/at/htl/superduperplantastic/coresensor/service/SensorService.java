package at.htl.superduperplantastic.coresensor.service;

import at.htl.superduperplantastic.coresensor.dto.RegisterSensorData;
import at.htl.superduperplantastic.coresensor.dto.RegisterSensorDataMac;
import at.htl.superduperplantastic.coresensor.dto.Sensor;
import at.htl.superduperplantastic.coresensor.dto.mapper.SensorMapper;
import at.htl.superduperplantastic.coresensor.model.SensorModel;
import at.htl.superduperplantastic.coresensor.repository.SensorRepository;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class SensorService {

    @Inject
    SensorRepository sensorRepository;

    @Inject
    @RestClient
    HomeStationService homeStationService;

    @Inject
    SensorMapper sensorMapper;

    @Transactional
    public Sensor createSensor(Sensor sensor){
        var entity = sensorMapper.toEntity(sensor);
        sensorRepository.persist(entity);
        return sensorMapper.toDto(entity);
    }

    @Transactional
    public UUID registerSensor(RegisterSensorData registerSensorData) {
        var sensor = sensorRepository.findById(registerSensorData.getSensorId());
        sensor.setHomeStationId(registerSensorData.getHomeStationId());
        sensorRepository.persist(sensor);
        return sensor.getId();
    }

    public List<Sensor> getSensorsByHomeStation(UUID homeStationId) {
        return sensorRepository.list("homeStationId", homeStationId)
                .stream()
                .map(s -> sensorMapper.toDto(s))
                .collect(Collectors.toList());
    }

    public List<Sensor> getAllSensors() {
        return sensorRepository
                .listAll()
                .stream().map(s -> sensorMapper.toDto(s))
                .collect(Collectors.toList());
    }

    @Transactional
    public UUID registerSensorWithMac(RegisterSensorDataMac registerSensorDataMac) {
        var sensor = sensorRepository.find("mac", registerSensorDataMac.getSensorMac()).firstResult();
        var homeStation = homeStationService.getHomeStationByMac(registerSensorDataMac.getHomeStationMac());
        sensor.setHomeStationId(homeStation.getId());
        sensorRepository.persist(sensor);
        return sensor.getId();
    }

    @Transactional
    public void updateSensor(Sensor sensor) {
        var sensorToUpdate = sensorRepository.findById(sensor.getId());
        sensorMapper.copy(sensorMapper.toEntity(sensor),sensorToUpdate);
        sensorRepository.persist(sensorToUpdate);
    }
}
