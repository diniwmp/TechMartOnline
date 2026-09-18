package lk.tmart.core.model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "categories")
public class Category implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cat_id")
    private Integer catId;

    @Column(name = "cat_name")
    private String catName;

    public Category() {}

    public Integer getCatId() { return catId; }
    public void setCatId(Integer catId) { this.catId = catId; }
    public String getCatName() { return catName; }
    public void setCatName(String catName) { this.catName = catName; }
}
