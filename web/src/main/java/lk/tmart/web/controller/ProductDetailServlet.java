package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.ProductDTO;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.ProductServiceRemote;
import lk.tmart.core.service.WishlistServiceRemote;

import java.io.IOException;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    @EJB
    private ProductServiceRemote productService;

    @EJB
    private WishlistServiceRemote wishlistService;

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        int pId = Integer.parseInt(req.getParameter("id"));
        ProductDTO product = productService.getProductById(pId);

        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }
        req.setAttribute("product", product);
        req.setAttribute("currentPageUrl", "/product?id=" + pId);

        HttpSession session = req.getSession(false);
        UserDTO user = session != null ? (UserDTO) session.
                getAttribute("loggedInUser") : null;
        if (user != null) {
            req.setAttribute("inWishlist", wishlistService.
                    isInWishlist(user.getEmail(), pId));
        }
        req.getRequestDispatcher("/pages/product-detail.jsp")
                .forward(req, resp);
    }
}