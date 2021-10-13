package at.htl.superduperplantastic.coresensor.dto.mapper;

import at.htl.superduperplantastic.coresensor.dto.Sensor;
import at.htl.superduperplantastic.coresensor.model.SensorModel;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(config = QuarkusMappingConfig.class)
public interface SensorMapper {
    Sensor toDto(SensorModel sensorModel);

    SensorModel toEntity(Sensor sensor);

    void copy(SensorModel source, @MappingTarget SensorModel target);
}
