package lk.tmart.ejb;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.dto.NotificationDTO;
import lk.tmart.core.dto.PerformanceLogDTO;
import lk.tmart.core.model.*;
import lk.tmart.core.service.CatalogAdminServiceRemote;
import lk.tmart.ejb.interceptor.PerformanceLoggingInterceptor;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Stateless
@Interceptors(PerformanceLoggingInterceptor.class)
public class CatalogAdminServiceBean implements CatalogAdminServiceRemote {

    private static final int LOW_STOCK_THRESHOLD = 5;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @EJB
    private InventorySyncBean inventorySyncBean;

    @EJB
    private StockAlertProducer stockAlertProducer;


    @Override
    public List<Category> listCategories() {
        return em.createQuery("SELECT c FROM Category c ORDER BY c.catName", Category.class).getResultList();
    }

    @Override
    public Category getCategory(int catId) {
        return em.find(Category.class, catId);
    }

    @Override
    public void addCategory(Category category) {
        em.persist(category);
    }

    @Override
    public void updateCategory(Category category) {
        em.merge(category);
    }

    @Override
    public void deleteCategory(int catId) throws Exception {
        Category c = em.find(Category.class, catId);
        if (c == null) return;

        Long productCount = em.createQuery(
                        "SELECT COUNT(p) FROM Product p WHERE p.category.catId = :catId", Long.class)
                .setParameter("catId", catId)
                .getSingleResult();

        if (productCount > 0) {
            throw new Exception("Cannot delete: " + productCount + " product(s) still use this category.");
        }
        em.remove(c);
    }


    @Override
    public List<Brand> listBrands() {
        return em.createQuery("SELECT b FROM Brand b ORDER BY b.brandName", Brand.class).getResultList();
    }

    @Override
    public Brand getBrand(int brandId) {
        return em.find(Brand.class, brandId);
    }

    @Override
    public void addBrand(Brand brand) {
        em.persist(brand);
    }

    @Override
    public void updateBrand(Brand brand) {
        em.merge(brand);
    }

    @Override
    public void deleteBrand(int brandId) throws Exception {
        Brand b = em.find(Brand.class, brandId);
        if (b == null) return;

        Long productCount = em.createQuery(
                        "SELECT COUNT(p) FROM Product p WHERE p.brand.brandId = :brandId", Long.class)
                .setParameter("brandId", brandId)
                .getSingleResult();

        if (productCount > 0) {
            throw new Exception("Cannot delete: " + productCount + " product(s) still use this brand.");
        }
        em.remove(b);
    }


    @Override
    public List<Product> listProducts() {
        return em.createQuery("SELECT p FROM Product p ORDER BY p.pName", Product.class).getResultList();
    }

    @Override
    public Product getProduct(int pId) {
        return em.find(Product.class, pId);
    }

    @Override
    public void addProduct(String pName, String description, String imagePath,
                           int catId, int brandId, double price, int qty) {

        Product p = new Product();
        p.setPName(pName);
        p.setDescription(description);
        p.setPath(imagePath);
        p.setCategory(em.getReference(Category.class, catId));
        p.setBrand(em.getReference(Brand.class, brandId));

        em.persist(p);

        Stock stock = new Stock();
        stock.setPrice(price);
        stock.setQty(qty);
        stock.setStatus(qty > 0 ? "AVAILABLE" : "OUT_OF_STOCK");
        stock.setProduct(p);

        em.persist(stock);
        p.setStock(stock);

        inventorySyncBean.syncInventory();
        checkLowStock(pName, qty);
    }

    @Override
    public void updateProduct(int pId, String pName, String description, String imagePath,
                              int catId, int brandId, double price, int qty) {

        Product existing = em.find(Product.class, pId);
        if (existing == null) return;

        existing.setPName(pName);
        existing.setDescription(description);
        existing.setCategory(em.getReference(Category.class, catId));
        existing.setBrand(em.getReference(Brand.class, brandId));

        if (imagePath != null) {
            existing.setPath(imagePath);
        }

        Stock stock = existing.getStock();
        if (stock == null) {
            stock = new Stock();
            stock.setProduct(existing);
        }
        stock.setPrice(price);
        stock.setQty(qty);
        stock.setStatus(qty > 0 ? "AVAILABLE" : "OUT_OF_STOCK");

        em.merge(stock);
        em.merge(existing);

        inventorySyncBean.syncInventory();
        checkLowStock(pName, qty);
    }

    @Override
    public void deleteProduct(int pId) throws Exception {
        Product p = em.find(Product.class, pId);
        if (p == null) return;
        em.remove(p);
        inventorySyncBean.syncInventory();
    }


    @Override
    public void adjustInventory(int pId, int delta) {
        Product p = em.find(Product.class, pId);
        if (p == null || p.getStock() == null) return;

        Stock stock = p.getStock();
        int newQty = Math.max(0, stock.getQty() + delta);
        stock.setQty(newQty);
        stock.setStatus(newQty > 0 ? "AVAILABLE" : "OUT_OF_STOCK");
        em.merge(stock);

        inventorySyncBean.syncInventory();
        checkLowStock(p.getPName(), newQty);
    }

    private void checkLowStock(String productName, int qty) {
        if (qty <= LOW_STOCK_THRESHOLD) {
            stockAlertProducer.sendLowStockAlert(productName, qty);
        }
    }


    @Override
    public List<PerformanceLogDTO> listRecentPerformanceLogs(int limit) {
        List<PerformanceLog> logs = em.createQuery(
                        "SELECT pl FROM PerformanceLog pl ORDER BY pl.loggedAt DESC", PerformanceLog.class)
                .setMaxResults(limit)
                .getResultList();

        List<PerformanceLogDTO> result = new ArrayList<>();
        for (PerformanceLog log : logs) {
            String formatted = log.getLoggedAt() != null ? log.getLoggedAt().format(DATE_FORMATTER) : "";
            result.add(new PerformanceLogDTO(
                    log.getLogId(),
                    log.getOperationName(),
                    log.getExecutionTime(),
                    log.getComponentType(),
                    formatted
            ));
        }
        return result;
    }

    @Override
    public Map<String, Double> getAverageExecutionTimeByOperation() {
        List<Object[]> results = em.createQuery(
                "SELECT pl.operationName, AVG(pl.executionTime) FROM PerformanceLog pl GROUP BY pl.operationName",
                Object[].class).getResultList();

        Map<String, Double> map = new LinkedHashMap<>();
        for (Object[] row : results) {
            map.put((String) row[0], (Double) row[1]);
        }
        return map;
    }

    @Override
    public List<NotificationDTO> listNotifications(int limit) {
        List<Notification> notifications = em.createQuery(
                        "SELECT n FROM Notification n WHERE n.userEmail IS NULL ORDER BY n.createdAt DESC",
                        Notification.class)
                .setMaxResults(limit)
                .getResultList();

        List<NotificationDTO> result = new ArrayList<>();
        for (Notification n : notifications) {
            result.add(new NotificationDTO(
                    n.getNotifiId(),
                    n.getMessage(),
                    n.getNotifiType(),
                    n.getCreatedAt() != null ? n.getCreatedAt().format(DATE_FORMATTER) : ""
            ));
        }
        return result;
    }



    @Override
    public long countCategories() {
        return em.createQuery("SELECT COUNT(c) FROM Category c", Long.class).getSingleResult();
    }

    @Override
    public long countBrands() {
        return em.createQuery("SELECT COUNT(b) FROM Brand b", Long.class).getSingleResult();
    }

    @Override
    public long countProducts() {
        return em.createQuery("SELECT COUNT(p) FROM Product p", Long.class).getSingleResult();
    }
}