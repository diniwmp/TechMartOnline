package lk.tmart.ejb;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.dto.CartItemDTO;
import lk.tmart.core.dto.NotificationDTO;
import lk.tmart.core.dto.OrderDTO;
import lk.tmart.core.dto.OrderItemDTO;
import lk.tmart.core.model.*;
import lk.tmart.core.service.OrderServiceRemote;
import lk.tmart.ejb.interceptor.PerformanceLoggingInterceptor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Stateless
@Interceptors(PerformanceLoggingInterceptor.class)
public class OrderServiceBean implements OrderServiceRemote {

    private static final double SHIPPING_FEE = 250.0;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @EJB
    private InventorySyncBean inventorySyncBean;

    @EJB
    private AsyncNotificationBean asyncNotificationBean;

    @EJB
    private OrderEventProducer orderEventProducer;

    @Override
    public OrderDTO createOrder(String userEmail, String shippingName, String shippingPhone,
                                String shippingAddress, String shippingCity,
                                List<CartItemDTO> selectedItems) throws Exception {

        if (selectedItems == null || selectedItems.isEmpty()) {
            throw new Exception("No items selected for checkout.");
        }

        double subtotal = 0;
        for (CartItemDTO item : selectedItems) {
            if (item.getQty() > item.getAvailableStock()) {
                throw new Exception(item.getName() + " only has " + item.getAvailableStock() + " left in stock.");
            }
            subtotal += item.getSubtotal();
        }

        Order order = new Order();
        order.setUserEmail(userEmail);
        order.setOrderStatus("PENDING");
        order.setPaymentStatus("PENDING");
        order.setSubtotal(subtotal);
        order.setShippingFee(SHIPPING_FEE);
        order.setTotalAmount(subtotal + SHIPPING_FEE);
        order.setShippingName(shippingName);
        order.setShippingPhone(shippingPhone);
        order.setShippingAddress(shippingAddress);
        order.setShippingCity(shippingCity);
        order.setOrderDate(LocalDateTime.now());
        em.persist(order);


        em.flush();

        for (CartItemDTO item : selectedItems) {
            Stock stock = em.find(Stock.class, item.getStockId());
            if (stock == null) continue;

            OrderItem oi = new OrderItem();
            oi.setOrder(order);
            oi.setStock(stock);
            oi.setOiQty(item.getQty());
            oi.setOiPrice(item.getPrice());
            em.persist(oi);

            inventorySyncBean.adjustStock(stock.getStockId(), -item.getQty());
        }

        orderEventProducer.publishOrderEvent("ORDER_PLACED", order.getOrderId(), userEmail, order.getTotalAmount());

        return toDTO(order, true);
    }

    @Override
    public void markOrderPaid(int orderId) {
        Order order = em.find(Order.class, orderId);
        if (order != null) {
            order.setOrderStatus("PAID");
            order.setPaymentStatus("COMPLETED");
            em.merge(order);

            asyncNotificationBean.sendOrderConfirmation(order.getUserEmail(), orderId, order.getTotalAmount());
            orderEventProducer.publishOrderEvent("ORDER_PAID", orderId, order.getUserEmail(), order.getTotalAmount());
        }
    }

    @Override
    public void markOrderFailed(int orderId) {
        Order order = em.find(Order.class, orderId);
        if (order != null) {
            order.setPaymentStatus("FAILED");
            em.merge(order);
        }
    }

    @Override
    public void markOrderPaidIfPending(int orderId) {
        Order order = em.find(Order.class, orderId);
        if (order != null && "PENDING".equals(order.getPaymentStatus())) {
            order.setOrderStatus("PAID");
            order.setPaymentStatus("COMPLETED");
            em.merge(order);

            asyncNotificationBean.sendOrderConfirmation(order.getUserEmail(), orderId, order.getTotalAmount());
            orderEventProducer.publishOrderEvent("ORDER_PAID", orderId, order.getUserEmail(), order.getTotalAmount());
        }
    }

    @Override
    public OrderDTO getOrderById(int orderId) {
        Order order = em.find(Order.class, orderId);
        return order == null ? null : toDTO(order, true);
    }

    @Override
    public List<OrderDTO> listOrdersByUser(String userEmail) {
        List<Order> orders = em.createQuery(
                        "SELECT o FROM Order o WHERE o.userEmail = :email ORDER BY o.orderDate DESC", Order.class)
                .setParameter("email", userEmail)
                .getResultList();

        List<OrderDTO> result = new ArrayList<>();
        for (Order order : orders) {
            result.add(toDTO(order, false));
        }
        return result;
    }

    @Override
    public void updateOrderStatus(int orderId, String newStatus) throws Exception {
        Order order = em.find(Order.class, orderId);
        if (order == null) {
            throw new Exception("Order not found.");
        }
        order.setOrderStatus(newStatus);
        em.merge(order);
        String jmsMessage = "ORDER_STATUS_CHANGED|" + order.getOrderId() + "|" + order.getUserEmail() + "|" + newStatus;
        orderEventProducer.publishRawTextMessage(jmsMessage);
    }

    @Override
    public List<OrderDTO> listAllOrders() {
        List<Order> orders = em.createQuery(
                "SELECT o FROM Order o ORDER BY o.orderDate DESC", Order.class).getResultList();
        List<OrderDTO> result = new ArrayList<>();
        for (Order order : orders) {
            result.add(toDTO(order, false));
        }
        return result;
    }

    @Override
    public List<OrderDTO> listOrdersByStatus(String status) {
        List<Order> orders = em.createQuery(
                        "SELECT o FROM Order o WHERE o.orderStatus = :status ORDER BY o.orderDate DESC", Order.class)
                .setParameter("status", status)
                .getResultList();
        List<OrderDTO> result = new ArrayList<>();
        for (Order order : orders) {
            result.add(toDTO(order, false));
        }
        return result;
    }

    @Override
    public List<NotificationDTO> listMessagesForUser(String userEmail) {
        List<Notification> items = em.createQuery(
                        "SELECT n FROM Notification n WHERE n.userEmail = :email ORDER BY n.createdAt DESC",
                        Notification.class)
                .setParameter("email", userEmail)
                .getResultList();

        List<NotificationDTO> result = new ArrayList<>();
        for (Notification n : items) {
            result.add(new NotificationDTO(
                    n.getNotifiId(),
                    n.getMessage(),
                    n.getNotifiType(),
                    n.getCreatedAt() != null ? n.getCreatedAt().format(DATE_FORMATTER) : ""
            ));
        }
        return result;
    }

    private OrderDTO toDTO(Order order, boolean includeItems) {
        List<OrderItemDTO> itemDTOs = new ArrayList<>();

        if (includeItems) {
            List<OrderItem> items = em.createQuery(
                            "SELECT oi FROM OrderItem oi WHERE oi.order.orderId = :orderId", OrderItem.class)
                    .setParameter("orderId", order.getOrderId())
                    .getResultList();

            for (OrderItem oi : items) {
                Product product = oi.getStock().getProduct();
                itemDTOs.add(new OrderItemDTO(
                        product.getPName(),
                        product.getPath(),
                        oi.getOiQty(),
                        oi.getOiPrice()
                ));
            }
        }

        OrderDTO dto = new OrderDTO(
                order.getOrderId(),
                order.getOrderStatus(),
                order.getPaymentStatus(),
                order.getSubtotal(),
                order.getShippingFee(),
                order.getTotalAmount(),
                order.getShippingName(),
                order.getShippingPhone(),
                order.getShippingAddress(),
                order.getShippingCity(),
                order.getOrderDate() != null ? order.getOrderDate().format(DATE_FORMATTER) : "",
                itemDTOs
        );
        dto.setUserEmail(order.getUserEmail());
        return dto;
    }
}