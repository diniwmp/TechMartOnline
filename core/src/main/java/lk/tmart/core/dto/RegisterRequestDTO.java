package lk.tmart.core.dto;

import java.io.Serializable;

/**
 * Carries registration form data across the Web -> EJB tier boundary.
 *
 * Design note (for your critical analysis report):
 * We never pass the JPA `User` entity itself across remote EJB calls.
 * DTOs decouple the web tier from persistence-layer changes and avoid
 * serializing lazy-loaded JPA proxies, which is a common source of
 * LazyInitializationException / performance overhead in EJB remote calls.
 */
public class RegisterRequestDTO implements Serializable {

    private String email;
    private String firstName;
    private String lastName;
    private String mobile;
    private String password;

    public RegisterRequestDTO() {
    }

    public RegisterRequestDTO(String email, String firstName, String lastName,
                              String mobile, String password) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.mobile = mobile;
        this.password = password;
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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
