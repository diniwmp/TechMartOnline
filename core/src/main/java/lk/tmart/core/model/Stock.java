package lk.tmart.core.model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "stock")
public class Stock implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stock_id")
    private Integer stockId;

    private Double price;


    @Column(name = "qty")
    private Integer qty;

    private String status;

    @OneToOne
    @JoinColumn(name = "products_p_id")
    private Product product;

    public Stock() {}

    public Integer getStockId() { return stockId; }
    public void setStockId(Integer stockId) { this.stockId = stockId; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public Integer getQty() { return qty; }
    public void setQty(Integer qty) { this.qty = qty; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
}
