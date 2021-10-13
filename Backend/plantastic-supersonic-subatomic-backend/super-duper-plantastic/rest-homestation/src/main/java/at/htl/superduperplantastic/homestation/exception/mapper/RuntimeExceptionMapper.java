package at.htl.superduperplantastic.homestation.exception.mapper;

import at.htl.superduperplantastic.homestation.error.Error;
import at.htl.superduperplantastic.homestation.error.ErrorCodes;
import at.htl.superduperplantastic.homestation.error.ErrorResponse;
import org.jboss.logging.Logger;

import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class RuntimeExceptionMapper implements ExceptionMapper<RuntimeException> {
    private static final Logger LOGGER = Logger.getLogger(RuntimeExceptionMapper.class);

    @Override
    public Response toResponse(RuntimeException e) {

        LOGGER.error("Runtime exception occurred while processing the request", e);

        ErrorResponse error = new ErrorResponse();
        error.getErrors().add(
            new Error(
                ErrorCodes.ERR_RUNTIME,
                "Internal Server Error",
                "Error occurred while processing your request. Please try again !!"
            )
        );
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(error).build();
    }
}
