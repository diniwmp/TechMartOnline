package lk.tmart.core.dto;

import java.io.Serializable;

public class UserDTO implements Serializable {

    private String email;
    private String firstName;
    private String lastName;
    private String mobile;
    private String roleName;

    public UserDTO() {}

    public UserDTO(String email, String firstName, String lastName, String mobile, String roleName) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.mobile = mobile;
        this.roleName = roleName;
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
}