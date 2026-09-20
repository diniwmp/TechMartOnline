package lk.tmart.core.service;

import jakarta.ejb.Remote;
import lk.tmart.core.dto.WishlistItemDTO;

import java.util.List;

@Remote
public interface WishlistServiceRemote {
    void addToWishlist(String userEmail, int pId) throws Exception;
    void removeFromWishlist(String userEmail, int pId);
    List<WishlistItemDTO> getWishlist(String userEmail);
    boolean isInWishlist(String userEmail, int pId);
}