package lk.tmart.core.model;


import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "products")
public class Product implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "p_id")
    private Integer pId;

    @Column(name = "p_name")
    private String pName;

    private String description;

    private String path;

    @ManyToOne
    @JoinColumn(name = "categories_cat_id")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "brand_brand_id")
    private Brand brand;

    @OneToOne(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Stock stock;

    public Product() {}

    public Integer getPId() { return pId; }
    public void setPId(Integer pId) { this.pId = pId; }
    public String getPName() { return pName; }
    public void setPName(String pName) { this.pName = pName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
    public Brand getBrand() { return brand; }
    public void setBrand(Brand brand) { this.brand = brand; }
    public Stock getStock() { return stock; }
    public void setStock(Stock stock) { this.stock = stock; }
}
