package at.htl.superduperplantastic.homestation.error;

public class ErrorCodes {
    /**
     * Error code for Runtime Exception
     */
    public static final int ERR_RUNTIME = 1000;

    /**
     * Error code for Handler not found
     */
    public static final int ERR_HANDLER_NOT_FOUND = 1010;

    /**
     * Error code for Resource not found
     */
    public static final int ERR_RESOURCE_NOT_FOUND = 1020;

    /**
     * Error code for validation failed exceptions
     */
    public static final int ERR_REQUEST_PARAMS_BODY_VALIDATION_FAILED = 1030;

    /**
     * Error code for Constraint check exceptions
     */
    public static final int ERR_CONSTRAINT_CHECK_FAILED = 1040;

    /**
     * Error code for Storage Exception
     */
    public static final int ERR_IMAGE_UPLOAD_FAILED = 1050;

    /**
     * Error code for Invalid image format
     */
    public static final int ERR_IMAGE_UPLOAD_INVALID_FORMAT = 1060;

    public static final int ERR_REGISTER_DATA_WRONG = 1060;
}
