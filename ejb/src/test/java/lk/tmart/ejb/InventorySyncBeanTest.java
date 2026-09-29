package lk.tmart.ejb;

import jakarta.persistence.EntityManager;
import lk.tmart.core.model.Stock;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class InventorySyncBeanTest {

    private EntityManager em;
    private InventorySyncBean inventorySyncBean;

    @BeforeEach
    void setUp() throws Exception {
        inventorySyncBean = new InventorySyncBean();
        em = mock(EntityManager.class);

        var emField = InventorySyncBean.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(inventorySyncBean, em);


        Map<Integer, Integer> cache = new HashMap<>();
        cache.put(10, 7);

        var cacheField = InventorySyncBean.class.getDeclaredField("stockCache");
        cacheField.setAccessible(true);
        cacheField.set(inventorySyncBean, cache);
    }

    @Test
    void getAvailableQty_returnsZero_forNullStockId() {
        assertEquals(0, inventorySyncBean.getAvailableQty(null));
    }

    @Test
    void getAvailableQty_returnsZero_forUnknownStockId() {
        assertEquals(0, inventorySyncBean.getAvailableQty(999));
    }

    @Test
    void getAvailableQty_returnsCachedValue_forKnownStockId() {
        assertEquals(7, inventorySyncBean.getAvailableQty(10));
    }

    @Test
    void adjustStock_neverGoesBelowZero() {
        Stock stock = mock(Stock.class);
        when(em.find(Stock.class, 10)).thenReturn(stock);

        inventorySyncBean.adjustStock(10, -50);

        assertEquals(0, inventorySyncBean.getAvailableQty(10));
        verify(stock).setQty(0);
        verify(em).merge(stock);
    }

    @Test
    void adjustStock_increasesCache_withPositiveDelta() {
        Stock stock = mock(Stock.class);
        when(em.find(Stock.class, 10)).thenReturn(stock);

        inventorySyncBean.adjustStock(10, 5);

        assertEquals(12, inventorySyncBean.getAvailableQty(10));
        verify(stock).setQty(12);
    }
}