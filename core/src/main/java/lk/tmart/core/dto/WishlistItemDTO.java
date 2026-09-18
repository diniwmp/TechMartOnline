package lk.tmart.core.dto;

import java.io.Serializable;

public class WishlistItemDTO implements Serializable {

    private Integer productId;
    private String name;
    private String imagePath;
    private Double price;
    private String brandName;
    private boolean inStock;

    public WishlistItemDTO() {}

    public WishlistItemDTO(Integer productId, String name, String imagePath,
                           Double price, String brandName, boolean inStock) {
        this.productId = productId;
        this.name = name;
        this.imagePath = imagePath;
        this.price = price;
        this.brandName = brandName;
        this.inStock = inStock;
    }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }
    public boolean isInStock() { return inStock; }
    public void setInStock(boolean inStock) { this.inStock = inStock; }
}