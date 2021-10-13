package at.htl.superduperplantastic.corehomestation.dto.mapper;

import at.htl.superduperplantastic.corehomestation.dto.HomeStation;
import at.htl.superduperplantastic.corehomestation.model.HomeStationModel;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(config = QuarkusMappingConfig.class)
public interface HomeStationMapper {
    HomeStation toDto(HomeStationModel homeStationModel);

    HomeStationModel toEntity(HomeStation homeStation);

    void copy(HomeStationModel source, @MappingTarget HomeStationModel target);
}
