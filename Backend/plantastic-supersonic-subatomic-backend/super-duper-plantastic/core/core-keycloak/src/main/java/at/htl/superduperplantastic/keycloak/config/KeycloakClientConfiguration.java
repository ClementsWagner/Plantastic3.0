package at.htl.superduperplantastic.keycloak.config;

import io.quarkus.arc.config.ConfigProperties;
import org.eclipse.microprofile.config.inject.ConfigProperty;

@ConfigProperties(prefix = "keycloak-client")
public interface KeycloakClientConfiguration {
    @ConfigProperty(name = "server-url")
    String serverUrl();

    @ConfigProperty(name = "realm")
    String realm();

    @ConfigProperty(name = "client-id")
    String clientId();

    @ConfigProperty(name = "username")
    String username();

    @ConfigProperty(name = "password")
    String password();
}
