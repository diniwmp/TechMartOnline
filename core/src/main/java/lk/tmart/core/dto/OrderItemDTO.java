package lk.tmart.core.dto;

import java.io.Serializable;

public class OrderItemDTO implements Serializable {

    private String productName;
    private String imagePath;
    private Integer qty;
    private Double unitPrice;

    public OrderItemDTO() {}

    public OrderItemDTO(String productName, String imagePath, Integer qty, Double unitPrice) {
        this.productName = productName;
        this.imagePath = imagePath;
        this.qty = qty;
        this.unitPrice = unitPrice;
    }

    public double getLineTotal() {
        return (unitPrice != null ? unitPrice : 0) * (qty != null ? qty : 0);
    }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public Integer getQty() { return qty; }
    public void setQty(Integer qty) { this.qty = qty; }
    public Double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(Double unitPrice) { this.unitPrice = unitPrice; }
}