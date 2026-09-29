
package lk.tmart.ejb;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import lk.tmart.core.model.Cart;
import lk.tmart.core.model.CartItem;
import lk.tmart.core.model.Product;
import lk.tmart.core.model.Stock;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

class CartBeanTest {

    private EntityManager em;
    private InventorySyncBean inventorySyncBean;
    private CartBean cartBean;

    @BeforeEach
    void setUp() throws Exception {
        em = mock(EntityManager.class);
        inventorySyncBean = mock(InventorySyncBean.class);
        cartBean = new CartBean();

        var emField = CartBean.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(cartBean, em);

        var inventoryField = CartBean.class.getDeclaredField("inventorySyncBean");
        inventoryField.setAccessible(true);
        inventoryField.set(cartBean, inventorySyncBean);

        cartBean.init("user@example.com");
    }

    @Test
    void addItem_throwsException_whenProductNotFound() {
        when(em.find(Product.class, 1)).thenReturn(null);

        Exception ex = assertThrows(Exception.class, () ->
                cartBean.addItem(1, 2));

        assertEquals("Product not found.", ex.getMessage());
    }

    @Test
    void addItem_throwsException_whenProductHasNoStockRecord() {
        Product product = mock(Product.class);
        when(product.getStock()).thenReturn(null);
        when(em.find(Product.class, 1)).thenReturn(product);

        Exception ex = assertThrows(Exception.class, () ->
                cartBean.addItem(1, 2));

        assertEquals("Product not found.", ex.getMessage());
    }

    @Test
    void addItem_throwsException_whenOutOfStock() {
        Product product = mock(Product.class);
        Stock stock = mock(Stock.class);
        when(stock.getStockId()).thenReturn(10);
        when(product.getStock()).thenReturn(stock);
        when(em.find(Product.class, 1)).thenReturn(product);
        when(inventorySyncBean.getAvailableQty(10)).thenReturn(0);

        Exception ex = assertThrows(Exception.class, () ->
                cartBean.addItem(1, 2));

        assertEquals("This product is out of stock.", ex.getMessage());
    }

    @Test
    void addItem_succeeds_whenProductInStock() throws Exception {
        Product product = mock(Product.class);
        Stock stock = mock(Stock.class);
        when(stock.getStockId()).thenReturn(10);
        when(product.getStock()).thenReturn(stock);
        when(em.find(Product.class, 1)).thenReturn(product);
        when(inventorySyncBean.getAvailableQty(10)).thenReturn(5);

        // An existing cart is already on file for this user.
        Cart existingCart = mock(Cart.class);
        when(existingCart.getCartId()).thenReturn(100);

        @SuppressWarnings("unchecked")
        TypedQuery<Cart> cartQuery = mock(TypedQuery.class);
        when(em.createQuery(anyString(), eq(Cart.class))).thenReturn(cartQuery);
        when(cartQuery.setParameter(anyString(), any())).thenReturn(cartQuery);
        when(cartQuery.getResultList()).thenReturn(List.of(existingCart));

        // No existing cart item yet for this product's stock row.
        @SuppressWarnings("unchecked")
        TypedQuery<CartItem> cartItemQuery = mock(TypedQuery.class);
        when(em.createQuery(anyString(), eq(CartItem.class))).thenReturn(cartItemQuery);
        when(cartItemQuery.setParameter(anyString(), any())).thenReturn(cartItemQuery);
        when(cartItemQuery.getResultList()).thenReturn(new ArrayList<>());

        when(em.getReference(Cart.class, 100)).thenReturn(existingCart);

        cartBean.addItem(1, 2);

        verify(em).persist(any(CartItem.class));
    }
}




