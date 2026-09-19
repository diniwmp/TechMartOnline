package lk.tmart.core.service;

import jakarta.ejb.Remote;
import lk.tmart.core.dto.NotificationDTO;
import lk.tmart.core.dto.PerformanceLogDTO;
import lk.tmart.core.model.Brand;
import lk.tmart.core.model.Category;
import lk.tmart.core.model.Product;

import java.util.List;
import java.util.Map;

@Remote
public interface CatalogAdminServiceRemote {

    List<Category> listCategories();
    Category getCategory(int catId);
    void addCategory(Category category);
    void updateCategory(Category category);
    void deleteCategory(int catId) throws Exception;

    // Brand management
    List<Brand> listBrands();
    Brand getBrand(int brandId);
    void addBrand(Brand brand);
    void updateBrand(Brand brand);
    void deleteBrand(int brandId) throws Exception;

    // Product management
    List<Product> listProducts();
    Product getProduct(int pId);
    void addProduct(String pName, String description, String imagePath,
                    int catId, int brandId, double price, int qty);
    void updateProduct(int pId, String pName, String description, String imagePath,
                       int catId, int brandId, double price, int qty);
    void deleteProduct(int pId) throws Exception;

    // Inventory management
    void adjustInventory(int pId, int delta);

    // Performance monitoring
    List<PerformanceLogDTO> listRecentPerformanceLogs(int limit);
    Map<String, Double> getAverageExecutionTimeByOperation();

    // Notifications
    List<NotificationDTO> listNotifications(int limit);

    // Dashboard counts
    long countCategories();
    long countBrands();
    long countProducts();
}