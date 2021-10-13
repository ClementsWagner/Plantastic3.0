package at.htl.superduperplantastic.homestation.exception.mapper;

import at.htl.superduperplantastic.homestation.error.ErrorCodes;
import at.htl.superduperplantastic.homestation.error.ErrorResponse;
import at.htl.superduperplantastic.homestation.exception.ImageUploadException;
import at.htl.superduperplantastic.homestation.error.Error;
import org.jboss.logging.Logger;

import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class ImageUploadExceptionMapper implements ExceptionMapper<ImageUploadException> {

    private static final Logger LOGGER = Logger.getLogger(ImageUploadExceptionMapper.class);

    @Override
    public Response toResponse(ImageUploadException e) {
        LOGGER.error(String.format("Storage exception occurred: %s ", e.getMessage()), e);

        ErrorResponse error = new ErrorResponse();

        if (e.getCode() == ErrorCodes.ERR_IMAGE_UPLOAD_INVALID_FORMAT) {
            error.getErrors().add(
                    new Error(
                            ErrorCodes.ERR_IMAGE_UPLOAD_INVALID_FORMAT,
                            "Uploaded image is not of a valid format",
                            e.getMessage()
                    )
            );
            return Response.status(Response.Status.BAD_REQUEST).entity(error).build();
        } else {
            error.getErrors().add(
                    new Error(
                            ErrorCodes.ERR_IMAGE_UPLOAD_FAILED,
                            "Error occurred while uploading image",
                            e.getMessage()
                    )
            );
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(error).build();
        }
    }
}
