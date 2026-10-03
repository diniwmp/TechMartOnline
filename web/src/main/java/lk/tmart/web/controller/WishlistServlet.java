package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.WishlistServiceRemote;

import java.io.IOException;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    @EJB
    private WishlistServiceRemote wishlistService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDTO user = getUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("wishlistItems", wishlistService.getWishlist(user.getEmail()));
        req.setAttribute("currentPageUrl", "/wishlist");
        req.getRequestDispatcher("/pages/wishlist.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDTO user = getUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int pId = Integer.parseInt(req.getParameter("pId"));
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        try {
            if ("add".equals(action)) {
                wishlistService.addToWishlist(user.getEmail(), pId);
                session.setAttribute("flashSuccess", "Successfully added to wishlist!");
            } else if ("remove".equals(action)) {
                wishlistService.removeFromWishlist(user.getEmail(), pId);
                session.setAttribute("flashSuccess", "Removed from wishlist.");
            }
        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());
        }

        String redirectTo = req.getParameter("redirectTo");
        resp.sendRedirect(req.getContextPath() + (redirectTo != null && !redirectTo.isBlank() ? redirectTo : "/wishlist"));
    }

    private UserDTO getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null ? (UserDTO) session.getAttribute("loggedInUser") : null;
    }
}