package lk.tmart.core.service;

import jakarta.ejb.Remote;
import lk.tmart.core.dto.CartItemDTO;

import java.util.List;


@Remote
public interface CartServiceRemote {
    void init(String userEmail);
    void closeCart();

    void addItem(int pId, int qty) throws Exception;
    void updateQty(int cartItemId, int qty) throws Exception;
    void removeItem(int cartItemId);
    List<CartItemDTO> getCartItems();
    double getSubtotal();
    int getItemCount();
    void clearCart();
}

