package lk.tmart.core.model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "order_item")
public class OrderItem implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "oi_id")
    private Integer oiId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne
    @JoinColumn(name = "stock_id")
    private Stock stock;

    @Column(name = "oi_qty")
    private Integer oiQty;

    @Column(name = "oi_price")
    private Double oiPrice;

    public OrderItem() {}

    public Integer getOiId() { return oiId; }
    public void setOiId(Integer oiId) { this.oiId = oiId; }
    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }
    public Stock getStock() { return stock; }
    public void setStock(Stock stock) { this.stock = stock; }
    public Integer getOiQty() { return oiQty; }
    public void setOiQty(Integer oiQty) { this.oiQty = oiQty; }
    public Double getOiPrice() { return oiPrice; }
    public void setOiPrice(Double oiPrice) { this.oiPrice = oiPrice; }
}