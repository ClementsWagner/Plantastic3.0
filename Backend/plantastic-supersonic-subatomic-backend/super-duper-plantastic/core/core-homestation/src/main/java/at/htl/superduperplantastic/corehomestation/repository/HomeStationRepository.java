package at.htl.superduperplantastic.corehomestation.repository;

import at.htl.superduperplantastic.corehomestation.model.HomeStationModel;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;

import javax.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class HomeStationRepository implements PanacheRepositoryBase<HomeStationModel, UUID>{
    public HomeStationModel findByMac(String mac) {
        return find("mac", mac).firstResult();
    }
}
