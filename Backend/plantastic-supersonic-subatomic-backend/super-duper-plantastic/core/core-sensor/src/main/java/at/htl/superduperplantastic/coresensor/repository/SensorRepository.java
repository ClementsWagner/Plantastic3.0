package at.htl.superduperplantastic.coresensor.repository;

import at.htl.superduperplantastic.coresensor.dto.Sensor;
import at.htl.superduperplantastic.coresensor.model.SensorModel;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;

import javax.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class SensorRepository implements PanacheRepositoryBase<SensorModel, UUID> {
}
