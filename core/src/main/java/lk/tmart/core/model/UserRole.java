package lk.tmart.core.model;


import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "user_roles")
public class UserRole implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String value;

    public UserRole() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getValue() { return value; }
    public void setValue(String value) { this.value = value; }
}