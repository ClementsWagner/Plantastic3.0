package at.htl.superduperplantastic.homestation.service.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class RegisterDataModel {
    public String mac;
    public String password;
    public String userId;
}
