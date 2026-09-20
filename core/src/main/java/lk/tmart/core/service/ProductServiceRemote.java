package lk.tmart.core.service;

import jakarta.ejb.Remote;
import lk.tmart.core.dto.ProductDTO;
import lk.tmart.core.model.Brand;
import lk.tmart.core.model.Category;

import java.util.List;

@Remote
public interface ProductServiceRemote {
    List<ProductDTO> getAllProducts();
    List<ProductDTO> getProductsByCategory(int catId);
    List<ProductDTO> getProductsByCategoryPreview(int catId, int limit);
    List<ProductDTO> searchProducts(String keyword);
    ProductDTO getProductById(int pId);
    List<Category> getAllCategories();
    Category getCategoryById(int catId);
    List<Brand> getAllBrands();
}