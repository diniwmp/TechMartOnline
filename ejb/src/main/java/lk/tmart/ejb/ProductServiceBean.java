package lk.tmart.ejb;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.dto.ProductDTO;
import lk.tmart.core.model.Brand;
import lk.tmart.core.model.Category;
import lk.tmart.core.model.Product;
import lk.tmart.core.service.ProductServiceRemote;
import lk.tmart.ejb.interceptor.PerformanceLoggingInterceptor;

import java.util.List;
import java.util.stream.Collectors;

@Stateless
@Interceptors(PerformanceLoggingInterceptor.class)
public class ProductServiceBean implements ProductServiceRemote {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @EJB
    private InventorySyncBean inventorySyncBean;

    @Override
    public List<ProductDTO> getAllProducts() {
        List<Product> products = em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
        return toDTOList(products);
    }

    @Override
    public List<ProductDTO> getProductsByCategory(int catId) {
        List<Product> products = em.createQuery(
                        "SELECT p FROM Product p WHERE p.category.catId = :catId", Product.class)
                .setParameter("catId", catId)
                .getResultList();
        return toDTOList(products);
    }

    @Override
    public List<ProductDTO> getProductsByCategoryPreview(int catId, int limit) {
        List<Product> products = em.createQuery(
                        "SELECT p FROM Product p WHERE p.category.catId = :catId", Product.class)
                .setParameter("catId", catId)
                .setMaxResults(limit)
                .getResultList();
        return toDTOList(products);
    }

    @Override
    public List<ProductDTO> searchProducts(String keyword) {
        String like = "%" + keyword.toLowerCase() + "%";
        List<Product> products = em.createQuery(
                        "SELECT p FROM Product p WHERE LOWER(p.pName) LIKE :kw OR LOWER(p.description) LIKE :kw",
                        Product.class)
                .setParameter("kw", like)
                .getResultList();
        return toDTOList(products);
    }

    @Override
    public ProductDTO getProductById(int pId) {
        Product p = em.find(Product.class, pId);
        return p == null ? null : toDTO(p);
    }

    @Override
    public List<Category> getAllCategories() {
        return em.createQuery("SELECT c FROM Category c ORDER BY c.catName", Category.class).getResultList();
    }

    @Override
    public Category getCategoryById(int catId) {
        return em.find(Category.class, catId);
    }

    @Override
    public List<Brand> getAllBrands() {
        return em.createQuery("SELECT b FROM Brand b ORDER BY b.brandName", Brand.class).getResultList();
    }

    private List<ProductDTO> toDTOList(List<Product> products) {
        return products.stream().map(this::toDTO).collect(Collectors.toList());
    }

    private ProductDTO toDTO(Product p) {
        Integer stockId = p.getStock() != null ? p.getStock().getStockId() : null;
        Double price = p.getStock() != null ? p.getStock().getPrice() : null;
        int availableQty = inventorySyncBean.getAvailableQty(stockId);

        return new ProductDTO(
                p.getPId(),
                p.getPName(),
                p.getDescription(),
                p.getPath(),
                p.getCategory() != null ? p.getCategory().getCatName() : null,
                p.getBrand() != null ? p.getBrand().getBrandName() : null,
                price,
                availableQty
        );
    }
}