package lk.tmart.ejb;

import jakarta.persistence.EntityManager;
import lk.tmart.core.dto.ProductDTO;
import lk.tmart.core.model.Brand;
import lk.tmart.core.model.Category;
import lk.tmart.core.model.Product;
import lk.tmart.core.model.Stock;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ProductServiceBeanTest {

    private EntityManager em;
    private InventorySyncBean inventorySyncBean;
    private ProductServiceBean productServiceBean;

    @BeforeEach
    void setUp() throws Exception {
        em = mock(EntityManager.class);
        inventorySyncBean = mock(InventorySyncBean.class);
        productServiceBean = new ProductServiceBean();

        var emField = ProductServiceBean.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(productServiceBean, em);

        var inventoryField = ProductServiceBean.class.getDeclaredField("inventorySyncBean");
        inventoryField.setAccessible(true);
        inventoryField.set(productServiceBean, inventorySyncBean);
    }

    @Test
    void getProductById_returnsNull_whenProductNotFound() {
        when(em.find(Product.class, 99)).thenReturn(null);

        assertNull(productServiceBean.getProductById(99));
    }

    @Test
    void getProductById_mapsEntityFieldsCorrectly_whenProductFound() {
        Product product = mock(Product.class);
        Category category = mock(Category.class);
        Brand brand = mock(Brand.class);
        Stock stock = mock(Stock.class);

        when(stock.getStockId()).thenReturn(10);
        when(stock.getPrice()).thenReturn(1500.0);
        when(category.getCatName()).thenReturn("Smartphones");
        when(brand.getBrandName()).thenReturn("Samsung");

        when(product.getPId()).thenReturn(5);
        when(product.getPName()).thenReturn("Galaxy A54");
        when(product.getDescription()).thenReturn("Mid-range smartphone");
        when(product.getPath()).thenReturn("galaxy-a54.jpg");
        when(product.getCategory()).thenReturn(category);
        when(product.getBrand()).thenReturn(brand);
        when(product.getStock()).thenReturn(stock);

        when(em.find(Product.class, 5)).thenReturn(product);
        when(inventorySyncBean.getAvailableQty(10)).thenReturn(7);

        ProductDTO dto = productServiceBean.getProductById(5);

        assertNotNull(dto);
        assertEquals("Galaxy A54", dto.getName());
        assertEquals("Samsung", dto.getBrandName());
        assertEquals("Smartphones", dto.getCategoryName());
        assertEquals(7, dto.getAvailableQty());
        assertTrue(dto.isInStock());
    }

    @Test
    void getProductById_marksOutOfStock_whenAvailableQtyIsZero() {
        Product product = mock(Product.class);
        Stock stock = mock(Stock.class);
        when(stock.getStockId()).thenReturn(20);
        when(stock.getPrice()).thenReturn(800.0);
        when(product.getStock()).thenReturn(stock);
        when(em.find(Product.class, 6)).thenReturn(product);
        when(inventorySyncBean.getAvailableQty(20)).thenReturn(0);

        ProductDTO dto = productServiceBean.getProductById(6);

        assertNotNull(dto);
        assertFalse(dto.isInStock());
    }
}