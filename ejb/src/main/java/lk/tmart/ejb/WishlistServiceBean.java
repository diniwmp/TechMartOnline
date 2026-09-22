
package lk.tmart.ejb;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.dto.WishlistItemDTO;
import lk.tmart.core.model.Product;
import lk.tmart.core.model.Wishlist;
import lk.tmart.core.service.WishlistServiceRemote;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class WishlistServiceBean implements WishlistServiceRemote {

    private static final Logger LOGGER = Logger.getLogger(WishlistServiceBean.class.getName());

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @EJB
    private InventorySyncBean inventorySyncBean;

    @PostConstruct
    private void onInit() {
        if (em == null) {
            throw new IllegalStateException(
                    "WishlistServiceBean: EntityManager was not injected. " +
                            "Check that the persistence unit name 'techmart-pu' matches " +
                            "the unit declared in persistence.xml."
            );
        }
        if (inventorySyncBean == null) {
            throw new IllegalStateException(
                    "WishlistServiceBean: InventorySyncBean was not injected. " +
                            "Verify that InventorySyncBean is deployed in the same EAR module."
            );
        }
        LOGGER.info("WishlistServiceBean initialised successfully" +
                "EntityManager and InventorySyncBean are ready.");
    }

    @Override
    public void addToWishlist(String userEmail, int pId) throws Exception {
        if (isInWishlist(userEmail, pId)) return;

        Product product = em.find(Product.class, pId);
        if (product == null) throw new Exception("Product not found.");

        Wishlist w = new Wishlist();
        w.setUserEmail(userEmail);
        w.setProduct(product);
        w.setCreatedAt(LocalDateTime.now());
        em.persist(w);
    }

    @Override
    public void removeFromWishlist(String userEmail, int pId) {
        List<Wishlist> matches = em.createQuery(
                        "SELECT w FROM Wishlist w WHERE w.userEmail = :email AND w.product.pId = :pId", Wishlist.class)
                .setParameter("email", userEmail)
                .setParameter("pId", pId)
                .getResultList();

        for (Wishlist w : matches) {
            em.remove(w);
        }
    }

    @Override
    public List<WishlistItemDTO> getWishlist(String userEmail) {
        List<Wishlist> items = em.createQuery(
                        "SELECT w FROM Wishlist w WHERE w.userEmail = :email ORDER BY w.createdAt DESC", Wishlist.class)
                .setParameter("email", userEmail)
                .getResultList();

        List<WishlistItemDTO> result = new ArrayList<>();
        for (Wishlist w : items) {
            Product p = w.getProduct();
            int available = p.getStock() != null
                    ? inventorySyncBean.getAvailableQty(p.getStock().getStockId())
                    : 0;

            result.add(new WishlistItemDTO(
                    p.getPId(),
                    p.getPName(),
                    p.getPath(),
                    p.getStock() != null ? p.getStock().getPrice() : null,
                    p.getBrand() != null ? p.getBrand().getBrandName() : null,
                    available > 0
            ));
        }
        return result;
    }

    @Override
    public boolean isInWishlist(String userEmail, int pId) {
        Long count = em.createQuery(
                        "SELECT COUNT(w) FROM Wishlist w WHERE w.userEmail = :email AND w.product.pId = :pId", Long.class)
                .setParameter("email", userEmail)
                .setParameter("pId", pId)
                .getSingleResult();
        return count > 0;
    }
}

