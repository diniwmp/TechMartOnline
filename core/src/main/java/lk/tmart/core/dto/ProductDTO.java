package lk.tmart.core.dto;

import java.io.Serializable;

public class ProductDTO implements Serializable {

    private Integer id;
    private String name;
    private String description;
    private String imagePath;
    private String categoryName;
    private String brandName;
    private Double price;
    private Integer availableQty;
    private boolean inStock;

    public ProductDTO() {}

    public ProductDTO(Integer id, String name, String description, String imagePath,
                      String categoryName, String brandName, Double price, Integer availableQty) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.imagePath = imagePath;
        this.categoryName = categoryName;
        this.brandName = brandName;
        this.price = price;
        this.availableQty = availableQty;
        this.inStock = availableQty != null && availableQty > 0;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public Integer getAvailableQty() { return availableQty; }
    public void setAvailableQty(Integer availableQty) { this.availableQty = availableQty; }
    public boolean isInStock() { return inStock; }
    public void setInStock(boolean inStock) { this.inStock = inStock; }
}