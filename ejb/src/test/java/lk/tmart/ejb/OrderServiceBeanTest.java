package lk.tmart.ejb;

import lk.tmart.core.dto.CartItemDTO;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class OrderServiceBeanTest {

    private final OrderServiceBean orderServiceBean = new OrderServiceBean();

    @Test
    void createOrder_throwsException_whenNoItemsSelected() {
        Exception ex = assertThrows(Exception.class, () ->
                orderServiceBean.createOrder("user@example.com", "John Doe", "0771234567",
                        "123 Main St", "Colombo", new ArrayList<>()));

        assertEquals("No items selected for checkout.", ex.getMessage());
    }

    @Test
    void createOrder_throwsException_whenSelectedItemsIsNull() {
        Exception ex = assertThrows(Exception.class, () ->
                orderServiceBean.createOrder("user@example.com", "John Doe", "0771234567",
                        "123 Main St", "Colombo", null));

        assertEquals("No items selected for checkout.", ex.getMessage());
    }

    @Test
    void createOrder_throwsException_whenQuantityExceedsAvailableStock() {
        CartItemDTO item = new CartItemDTO(1, 10, 20, "Galaxy A54", "galaxy.jpg", 1500.0, "Samsung", 5, 2);
        List<CartItemDTO> items = List.of(item);

        Exception ex = assertThrows(Exception.class, () ->
                orderServiceBean.createOrder("user@example.com", "John Doe", "0771234567",
                        "123 Main St", "Colombo", items));

        assertTrue(ex.getMessage().contains("only has 2 left in stock"));
    }

}