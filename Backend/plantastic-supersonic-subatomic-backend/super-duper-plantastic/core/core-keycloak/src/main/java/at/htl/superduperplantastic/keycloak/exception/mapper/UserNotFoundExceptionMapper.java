package at.htl.superduperplantastic.keycloak.exception.mapper;

import at.htl.superduperplantastic.keycloak.error.Error;
import at.htl.superduperplantastic.keycloak.error.ErrorCodes;
import at.htl.superduperplantastic.keycloak.error.ErrorResponse;
import at.htl.superduperplantastic.keycloak.exception.UserNotFoundException;
import org.jboss.logging.Logger;

import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;

public class UserNotFoundExceptionMapper implements ExceptionMapper<UserNotFoundException> {
    private static final Logger LOGGER = Logger.getLogger(UserNotFoundExceptionMapper.class);

    @Override
    public Response toResponse(UserNotFoundException e) {
        LOGGER.error(String.format("No user resource found exception occurred: %s ", e.getMessage()));

        ErrorResponse error = new ErrorResponse();
        error.getErrors().add(
                new Error(
                        ErrorCodes.ERR_RESOURCE_NOT_FOUND,
                        e.getMessage(),
                        "User Resource not found"
                )
        );

        return Response.status(Response.Status.NOT_FOUND).entity(error).build();
    }

}
