package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.dto.ProductDTO;
import lk.tmart.core.service.ProductServiceRemote;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {

    @EJB
    private ProductServiceRemote productService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String catParam = req.getParameter("cat");
        String keyword = req.getParameter("q");

        List<ProductDTO> products;
        if (keyword != null && !keyword.isBlank()) {
            products = productService.searchProducts(keyword.trim());
        } else if (catParam != null && !catParam.isBlank()) {
            products = productService.getProductsByCategory(Integer.parseInt(catParam));
        } else {
            products = productService.getAllProducts();
        }

        StringBuilder pageUrl = new StringBuilder("/products");
        if (catParam != null && !catParam.isBlank()) {
            pageUrl.append("?cat=").append(catParam);
        } else if (keyword != null && !keyword.isBlank()) {
            pageUrl.append("?q=").append(URLEncoder.encode(keyword, StandardCharsets.UTF_8));
        }

        req.setAttribute("products", products);
        req.setAttribute("categories", productService.getAllCategories());
        req.setAttribute("selectedCat", catParam);
        req.setAttribute("keyword", keyword);
        req.setAttribute("currentPageUrl", pageUrl.toString());
        req.getRequestDispatcher("/pages/products.jsp").forward(req, resp);
    }
}