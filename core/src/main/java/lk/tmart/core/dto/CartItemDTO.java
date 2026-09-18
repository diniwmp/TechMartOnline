package lk.tmart.core.dto;

import java.io.Serializable;

public class CartItemDTO implements Serializable {

    private Integer cartItemId;
    private Integer productId;
    private Integer stockId;
    private String name;
    private String imagePath;
    private Double price;
    private String brandName;
    private Integer qty;
    private Integer availableStock;

    public CartItemDTO() {}

    public CartItemDTO(Integer cartItemId, Integer productId, Integer stockId, String name, String imagePath,
                       Double price, String brandName, Integer qty, Integer availableStock) {
        this.cartItemId = cartItemId;
        this.productId = productId;
        this.stockId = stockId;
        this.name = name;
        this.imagePath = imagePath;
        this.price = price;
        this.brandName = brandName;
        this.qty = qty;
        this.availableStock = availableStock;
    }

    public double getSubtotal() {
        return (price != null ? price : 0) * (qty != null ? qty : 0);
    }

    public Integer getCartItemId() { return cartItemId; }
    public void setCartItemId(Integer cartItemId) { this.cartItemId = cartItemId; }
    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }
    public Integer getStockId() { return stockId; }
    public void setStockId(Integer stockId) { this.stockId = stockId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }
    public Integer getQty() { return qty; }
    public void setQty(Integer qty) { this.qty = qty; }
    public Integer getAvailableStock() { return availableStock; }
    public void setAvailableStock(Integer availableStock) { this.availableStock = availableStock; }
}