package at.htl.superduperplantastic.homestation.exception.mapper;

import at.htl.superduperplantastic.homestation.error.Error;
import at.htl.superduperplantastic.homestation.error.ErrorCodes;
import at.htl.superduperplantastic.homestation.error.ErrorResponse;
import at.htl.superduperplantastic.homestation.exception.RegisterDataException;
import at.htl.superduperplantastic.homestation.exception.ResourceNotFoundException;
import org.jboss.logging.Logger;

import javax.ws.rs.NotFoundException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class RegisterDataExceptionMapper implements ExceptionMapper<RegisterDataException> {
    private static final Logger LOGGER = Logger.getLogger(RegisterDataException.class);

    @Override
    public Response toResponse(RegisterDataException e) {
        LOGGER.error(String.format("Register data exception occurred: %s ", e.getMessage()));

        ErrorResponse error = new ErrorResponse();
        error.getErrors().add(
                new Error(
                        ErrorCodes.ERR_REGISTER_DATA_WRONG,
                        "Credentials for HomeStation are wrong",
                        e.getMessage()
                )
        );

        return Response.status(Response.Status.NOT_FOUND).entity(error).build();
    }
}
