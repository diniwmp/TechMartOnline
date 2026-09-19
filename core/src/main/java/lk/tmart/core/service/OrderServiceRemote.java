package lk.tmart.core.service;

import jakarta.ejb.Remote;
import lk.tmart.core.dto.CartItemDTO;
import lk.tmart.core.dto.NotificationDTO;
import lk.tmart.core.dto.OrderDTO;

import java.util.List;

@Remote
public interface OrderServiceRemote {
    OrderDTO createOrder(String userEmail, String shippingName, String shippingPhone,
                         String shippingAddress, String shippingCity,
                         List<CartItemDTO> selectedItems) throws Exception;
    void markOrderPaid(int orderId);
    void markOrderFailed(int orderId);
    void markOrderPaidIfPending(int orderId);
    OrderDTO getOrderById(int orderId);
    List<OrderDTO> listOrdersByUser(String userEmail);

    void updateOrderStatus(int orderId, String newStatus) throws Exception;
    List<OrderDTO> listAllOrders();
    List<OrderDTO> listOrdersByStatus(String status);

    List<NotificationDTO> listMessagesForUser(String userEmail);
}