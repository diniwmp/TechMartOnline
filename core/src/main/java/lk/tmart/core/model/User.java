package lk.tmart.core.model;

import jakarta.persistence.*;
import java.io.Serializable;

/**
 * Maps to the `users` table.
 * email is the primary key (business key) as per the schema you designed.
 */
@Entity
@Table(name = "users")
public class User implements Serializable {

    @Id
    @Column(name = "email", nullable = false, length = 100)
    private String email;

    @Column(name = "first_name", nullable = false, length = 60)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 60)
    private String lastName;

    @Column(name = "mobile", length = 20)
    private String mobile;

    @Column(name = "password", nullable = false, length = 255)
    private String password; // stored as a SHA-256 hash, never plain text

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_roles_id", referencedColumnName = "id", nullable = false)
    private UserRole userRole;

    public User() {
    }

    public User(String email, String firstName, String lastName, String mobile,
                String password, UserRole userRole) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.mobile = mobile;
        this.password = password;
        this.userRole = userRole;
    }

    // --- Getters & Setters ---

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

    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }
}
