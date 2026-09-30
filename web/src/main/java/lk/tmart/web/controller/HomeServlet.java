package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.dto.ProductDTO;
import lk.tmart.core.model.Category;
import lk.tmart.core.service.ProductServiceRemote;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final int PREVIEW_LIMIT = 10;

    @EJB
    private ProductServiceRemote productService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Category> categories = productService.getAllCategories();

        Map<Integer, List<ProductDTO>> productsByCategory = new LinkedHashMap<>();
        for (Category cat : categories) {
            productsByCategory.put(cat.getCatId(),
                    productService.getProductsByCategoryPreview(cat.getCatId(), PREVIEW_LIMIT));
        }

        req.setAttribute("categories", categories);
        req.setAttribute("productsByCategory", productsByCategory);
        req.setAttribute("currentPageUrl", "/home");
        req.getRequestDispatcher("/pages/home.jsp").forward(req, resp);
    }
}