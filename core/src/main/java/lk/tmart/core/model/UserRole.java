package lk.tmart.core.model;

import jakarta.persistence.*;
import java.io.Serializable;

/**
 * Maps to the `user_roles` table.
 * Example rows: (1, 'CUSTOMER'), (2, 'ADMIN')
 */
@Entity
@Table(name = "user_roles")
public class UserRole implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "value", nullable = false, length = 30)
    private String value;

    public UserRole() {
    }

    public UserRole(Integer id, String value) {
        this.id = id;
        this.value = value;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
