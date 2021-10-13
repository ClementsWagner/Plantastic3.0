package at.htl.superduperplantastic.homestation.exception.mapper;

import at.htl.superduperplantastic.homestation.error.Error;
import at.htl.superduperplantastic.homestation.error.ErrorCodes;
import at.htl.superduperplantastic.homestation.error.ErrorResponse;
import at.htl.superduperplantastic.homestation.exception.ResourceNotFoundException;
import org.jboss.logging.Logger;

import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class ResourceNotFoundExceptionMapper implements ExceptionMapper<ResourceNotFoundException> {

    private static final Logger LOGGER = Logger.getLogger(ResourceNotFoundExceptionMapper.class);

    @Override
    public Response toResponse(ResourceNotFoundException e) {
        LOGGER.error(String.format("No resource found exception occurred: %s ", e.getMessage()));

        ErrorResponse error = new ErrorResponse();
        error.getErrors().add(
            new Error(
                ErrorCodes.ERR_RESOURCE_NOT_FOUND,
                "Resource not found",
                e.getMessage()
            )
        );

        return Response.status(Response.Status.NOT_FOUND).entity(error).build();
    }
}
