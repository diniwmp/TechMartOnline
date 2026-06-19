package lk.tmart.core.dto;

import java.io.Serializable;

/**
 * Returned by AuthServiceRemote after a login attempt.
 * Encapsulates success/failure plus the minimal user info the web tier needs
 * to populate the HttpSession (we never put the JPA entity in the session).
 */
public class LoginResultDTO implements Serializable {

    private boolean success;
    private String message;
    private String email;
    private String firstName;
    private String lastName;
    private String roleName;

    public LoginResultDTO() {
    }

    public static LoginResultDTO failure(String message) {
        LoginResultDTO dto = new LoginResultDTO();
        dto.success = false;
        dto.message = message;
        return dto;
    }

    public static LoginResultDTO success(String email, String firstName,
                                         String lastName, String roleName) {
        LoginResultDTO dto = new LoginResultDTO();
        dto.success = true;
        dto.message = "Login successful";
        dto.email = email;
        dto.firstName = firstName;
        dto.lastName = lastName;
        dto.roleName = roleName;
        return dto;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
