
package lk.tmart.web.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.CartServiceRemote;

import javax.naming.NamingException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/cart")
public class CartServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDTO user = requireLogin(req, resp);
        if (user == null) return;

        try {
            CartServiceRemote cartService = CartConversationHelper.getCartFor(req.getSession(), user.getEmail());
            req.setAttribute("cartItems", cartService.getCartItems());
            req.setAttribute("subtotal", cartService.getSubtotal());
        } catch (NamingException e) {
            throw new ServletException("Could not obtain cart conversation bean.", e);
        }
        req.getRequestDispatcher("/pages/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDTO user = requireLogin(req, resp);
        if (user == null) return;

        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        String redirectTo = req.getParameter("redirectTo");
        String fallback = req.getContextPath() + "/cart";


        String destination = (redirectTo != null && !redirectTo.isBlank())
                ? req.getContextPath() + redirectTo
                : fallback;

        try {
            CartServiceRemote cartService = CartConversationHelper.getCartFor(session, user.getEmail());

            switch (action) {
                case "add": {
                    int pId = Integer.parseInt(req.getParameter("pId"));
                    int qty = Integer.parseInt(req.getParameter("qty"));
                    cartService.addItem(pId, qty);
                    session.setAttribute("flashSuccess", "Added to cart successfully!");
                    break;
                }
                case "update": {
                    int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
                    int qty = Integer.parseInt(req.getParameter("qty"));
                    cartService.updateQty(cartItemId, qty);
                    destination = fallback;
                    break;
                }
                case "remove": {
                    int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
                    cartService.removeItem(cartItemId);
                    destination = fallback;
                    break;
                }
                case "checkout": {
                    String[] selected = req.getParameterValues("selectedItems");
                    List<Integer> selectedIds = new ArrayList<>();
                    if (selected != null) {
                        for (String s : selected) selectedIds.add(Integer.parseInt(s));
                    }
                    if (selectedIds.isEmpty()) {
                        session.setAttribute("flashError", "Please select at least one item to checkout.");
                        resp.sendRedirect(fallback);
                        return;
                    }
                    session.setAttribute("checkoutSelection", selectedIds);
                    resp.sendRedirect(req.getContextPath() + "/checkout");
                    return;
                }
                default:
                    session.setAttribute("flashError", "Unknown cart action.");
                    destination = fallback;
            }
        } catch (NamingException e) {
            throw new ServletException("Could not obtain cart conversation bean.", e);
        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());

        }

        resp.sendRedirect(destination);
    }

    private UserDTO requireLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        UserDTO user = session != null ? (UserDTO) session.getAttribute("loggedInUser") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return null;
        }
        return user;
    }
}
