package lk.tmart.core.dto;

import java.io.Serializable;

public class UserDTO implements Serializable {

    private String email;
    private String firstName;
    private String lastName;
    private String mobile;
    private String roleName; // "ADMIN" or "USER"

    public UserDTO() {}

    public UserDTO(String email, String firstName, String lastName,
                   String mobile, String roleName) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.mobile = mobile;
        this.roleName = roleName;
    }

    public boolean isAdmin() { return "ADMIN".equals(roleName); }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String f) { this.firstName = f; }
    public String getLastName() { return lastName; }
    public void setLastName(String l) { this.lastName = l; }
    public String getMobile() { return mobile; }
    public void setMobile(String m) { this.mobile = m; }
    public String getRoleName() { return roleName; }
    public void setRoleName(String r) { this.roleName = r; }
}