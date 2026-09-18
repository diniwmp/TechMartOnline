package lk.tmart.core.model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "user")
public class User implements Serializable {

    @Id
    private String email;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    private String mobile;

    private String password;

    @ManyToOne
    @JoinColumn(name = "user_roles_id")
    private UserRole userRole;

    public User() {}

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public UserRole getUserRole() { return userRole; }
    public void setUserRole(UserRole userRole) { this.userRole = userRole; }
}
