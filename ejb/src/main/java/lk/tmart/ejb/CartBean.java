

package lk.tmart.ejb;

import jakarta.ejb.EJB;
import jakarta.ejb.Remove;
import jakarta.ejb.Stateful;
import jakarta.ejb.StatefulTimeout;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.dto.CartItemDTO;
import lk.tmart.core.model.Cart;
import lk.tmart.core.model.CartItem;
import lk.tmart.core.model.Product;
import lk.tmart.core.model.Stock;
import lk.tmart.core.service.CartServiceRemote;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;


@Stateful
@StatefulTimeout(value = 30, unit = TimeUnit.MINUTES)
public class CartBean implements CartServiceRemote {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @EJB
    private InventorySyncBean inventorySyncBean;

    private String userEmail;

    @Override
    public void init(String userEmail) {
        this.userEmail = userEmail;
    }

    @Override
    @Remove
    public void closeCart() {
        System.out.println("CartBean is being removed for user: " + userEmail +
                " | Session terminated and resources released.");

    }

    @Override
    public void addItem(int pId, int qty) throws Exception {
        Product product = em.find(Product.class, pId);
        if (product == null || product.getStock() == null) {
            throw new Exception("Product not found.");
        }

        Stock stock = product.getStock();
        int available = inventorySyncBean.getAvailableQty(stock.getStockId());
        if (available <= 0) {
            throw new Exception("This product is out of stock.");
        }

        Integer cartId = findOrCreateCartId(userEmail);

        CartItem existingItem = findItemByStock(cartId, stock.getStockId());
        if (existingItem != null) {
            int newQty = Math.min(existingItem.getQty() + qty, available);
            existingItem.setQty(newQty);
            em.merge(existingItem);
            return;
        }

        CartItem newItem = new CartItem();
        newItem.setCart(em.getReference(Cart.class, cartId));
        newItem.setStock(stock);
        newItem.setQty(Math.min(qty, available));
        em.persist(newItem);
    }

    @Override
    public void updateQty(int cartItemId, int qty) throws Exception {
        CartItem item = em.find(CartItem.class, cartItemId);
        if (item == null) return;

        if (!belongsToUser(item, userEmail)) {
            throw new Exception("This cart item does not belong to you.");
        }

        int available = inventorySyncBean.getAvailableQty(item.getStock().getStockId());
        if (qty > available) {
            throw new Exception("Only " + available + " left in stock.");
        }
        if (qty <= 0) {
            em.remove(item);
            return;
        }
        item.setQty(qty);
        em.merge(item);
    }

    @Override
    public void removeItem(int cartItemId) {
        CartItem item = em.find(CartItem.class, cartItemId);
        if (item != null && belongsToUser(item, userEmail)) {
            em.remove(item);
        }
    }

    @Override
    public List<CartItemDTO> getCartItems() {
        Integer cartId = findCartId(userEmail);
        if (cartId == null) return new ArrayList<>();

        List<CartItem> items = em.createQuery(
                        "SELECT ci FROM CartItem ci WHERE ci.cart.cartId = :cartId", CartItem.class)
                .setParameter("cartId", cartId)
                .getResultList();

        List<CartItemDTO> result = new ArrayList<>();
        for (CartItem item : items) {
            Stock stock = item.getStock();
            Product product = stock.getProduct();
            int available = inventorySyncBean.getAvailableQty(stock.getStockId());

            result.add(new CartItemDTO(
                    item.getCartItemId(),
                    product.getPId(),
                    stock.getStockId(),
                    product.getPName(),
                    product.getPath(),
                    stock.getPrice(),
                    product.getBrand() != null ? product.getBrand().getBrandName() : null,
                    item.getQty(),
                    available
            ));
        }
        return result;
    }

    @Override
    public double getSubtotal() {
        double total = 0;
        for (CartItemDTO dto : getCartItems()) {
            total += dto.getSubtotal();
        }
        return total;
    }

    @Override
    public int getItemCount() {
        return getCartItems().size();
    }

    @Override
    public void clearCart() {
        for (CartItemDTO dto : getCartItems()) {
            removeItem(dto.getCartItemId());
        }
    }


    private Integer findCartId(String userEmail) {
        List<Cart> existing = em.createQuery(
                        "SELECT c FROM Cart c WHERE c.userEmail = :email", Cart.class)
                .setParameter("email", userEmail)
                .getResultList();
        return existing.isEmpty() ? null : existing.get(0).getCartId();
    }

    private Integer findOrCreateCartId(String userEmail) {
        Integer existingId = findCartId(userEmail);
        if (existingId != null) {
            return existingId;
        }
        Cart newCart = new Cart();
        newCart.setUserEmail(userEmail);
        newCart.setCreatedAt(LocalDateTime.now());
        em.persist(newCart);
        em.flush();
        return newCart.getCartId();
    }

    private CartItem findItemByStock(Integer cartId, Integer stockId) {
        List<CartItem> matches = em.createQuery(
                        "SELECT ci FROM CartItem ci WHERE ci.cart.cartId = :cartId AND ci.stock.stockId = :stockId",
                        CartItem.class)
                .setParameter("cartId", cartId)
                .setParameter("stockId", stockId)
                .getResultList();
        return matches.isEmpty() ? null : matches.get(0);
    }

    private boolean belongsToUser(CartItem item, String userEmail) {
        return item.getCart() != null
                && userEmail != null
                && userEmail.equalsIgnoreCase(item.getCart().getUserEmail());
    }
}

