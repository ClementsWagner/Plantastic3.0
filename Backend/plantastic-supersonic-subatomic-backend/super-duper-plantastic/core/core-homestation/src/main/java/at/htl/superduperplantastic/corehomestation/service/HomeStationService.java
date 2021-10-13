package at.htl.superduperplantastic.corehomestation.service;

import at.htl.superduperplantastic.corehomestation.client.KeycloakService;
import at.htl.superduperplantastic.corehomestation.dto.HomeStation;
import at.htl.superduperplantastic.corehomestation.dto.RegisterData;
import at.htl.superduperplantastic.corehomestation.dto.User;
import at.htl.superduperplantastic.corehomestation.dto.mapper.HomeStationMapper;
import at.htl.superduperplantastic.corehomestation.helper.SecurityUtils;
import at.htl.superduperplantastic.corehomestation.model.HomeStationModel;
import at.htl.superduperplantastic.corehomestation.repository.HomeStationRepository;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.NotFoundException;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.stream.Collectors;

@ApplicationScoped
public class HomeStationService {

    @Inject
    HomeStationMapper homeStationMapper;

    @Inject
    HomeStationRepository homeStationRepository;

    @Inject
    @RestClient
    KeycloakService keycloakService;

    public List<HomeStation> getHomeStations() {
        return homeStationRepository
                .listAll()
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }
    public List<HomeStation> getHomeStationsByUser(String userId) {
        return homeStationRepository
                .listAll()
                .stream()
                .filter(h -> h.getUsers().contains(userId))
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    public HomeStation getHomeStation(UUID id) {
        return toDto(getHomeStationById(id));
    }

    public HomeStation getHomeStationByMac(String mac) {
        return toDto(findHomeStationByMac(mac));
    }

    @Transactional
    public HomeStation addHomeStation(HomeStation homeStation) {
        HomeStationModel model = homeStationMapper.toEntity(homeStation);
        homeStationRepository.persist(model);
        return toDto(model);
    }

    @Transactional
    public void addCredentialsToHomeStation(UUID id, String password) throws NoSuchAlgorithmException {
        var homeStation = getHomeStationById(id);

        byte[] salt = SecurityUtils.getSalt();
        byte[] passwordHash = SecurityUtils.getSaltedHashSHA512(password, salt);
        homeStation.setPasswordHash(passwordHash);
        homeStation.setPasswordSalt(salt);
        homeStationRepository.persist(homeStation);
    }

    @Transactional
    public boolean registerHomeStation(RegisterData registerData, String userId) {
        var homeStation = findHomeStationByMac(registerData.getMac());

        byte[] comparePassword = SecurityUtils.getSaltedHashSHA512(registerData.getPassword(), homeStation.getPasswordSalt());
        if (Arrays.equals(homeStation.getPasswordHash(), comparePassword)) {
            homeStation.getUsers().add(userId);
            homeStationRepository.persist(homeStation);
            return true;
        } else {
            return false;
        }
    }

    @Transactional
    public void unRegisterHomeStation(UUID id, String userId) {
       var homeStation = getHomeStationById(id);
       homeStation.getUsers().remove(userId);
       homeStationRepository.persist(homeStation);
    }

    @Transactional
    public void updateHomeStation(HomeStation homeStation) {
        var entity = getHomeStationById(homeStation.getId());
        entity.setName(homeStation.getName());
        homeStationRepository.persist(entity);
    }

    public List<User> getMembersFromHomeStation(UUID id) {
        var homeStation = homeStationRepository.findById(id);
        List<User> members = new ArrayList<>();
        for (var userId: homeStation.getUsers()) {
            members.add(keycloakService.getUserById(userId));
        }
        return members;
    }

    private HomeStationModel getHomeStationById(UUID id) {
        return Optional.of(homeStationRepository.findById(id))
                .orElseThrow(() -> new NotFoundException("HomeStation with id not found!"));
    }

    private HomeStationModel findHomeStationByMac(String mac) {
        return Optional.of(homeStationRepository.findByMac(mac))
                .orElseThrow(() -> new NotFoundException("HomeStation with id not found!"));
    }

    private HomeStation toDto(HomeStationModel model) {
        return homeStationMapper.toDto(model);
    }
}
