package lk.tmart.ejb;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import lk.tmart.core.model.Product;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

class WishlistServiceBeanTest {

    private EntityManager em;
    private WishlistServiceBean wishlistServiceBean;

    @BeforeEach
    void setUp() throws Exception {
        em = mock(EntityManager.class);
        wishlistServiceBean = new WishlistServiceBean();

        var emField = WishlistServiceBean.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(wishlistServiceBean, em);
    }

    @SuppressWarnings("unchecked")
    private TypedQuery<Long> mockCountQuery(long countToReturn) {
        TypedQuery<Long> query = mock(TypedQuery.class);
        when(em.createQuery(anyString(), eq(Long.class))).thenReturn(query);
        when(query.setParameter(anyString(), any())).thenReturn(query);
        when(query.getSingleResult()).thenReturn(countToReturn);
        return query;
    }

    @Test
    void isInWishlist_returnsTrue_whenCountIsPositive() {
        mockCountQuery(2L);

        assertTrue(wishlistServiceBean.isInWishlist("user@example.com", 5));
    }

    @Test
    void isInWishlist_returnsFalse_whenCountIsZero() {
        mockCountQuery(0L);

        assertFalse(wishlistServiceBean.isInWishlist("user@example.com", 5));
    }

    @Test
    void addToWishlist_doesNothing_whenAlreadyInWishlist() throws Exception {
        mockCountQuery(1L);

        wishlistServiceBean.addToWishlist("user@example.com", 5);

        verify(em, never()).persist(any());
    }

    @Test
    void addToWishlist_throwsException_whenProductNotFound() {
        mockCountQuery(0L);
        when(em.find(Product.class, 5)).thenReturn(null);

        Exception ex = assertThrows(Exception.class, () ->
                wishlistServiceBean.addToWishlist("user@example.com", 5));

        assertEquals("Product not found.", ex.getMessage());
    }

    @Test
    void addToWishlist_persistsNewEntry_whenProductExistsAndNotAlreadyWishlisted() throws Exception {
        mockCountQuery(0L);
        Product product = mock(Product.class);
        when(em.find(Product.class, 5)).thenReturn(product);

        wishlistServiceBean.addToWishlist("user@example.com", 5);

        verify(em, times(1)).persist(any());
    }
}