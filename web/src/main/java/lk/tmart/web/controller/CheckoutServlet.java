
package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.CartItemDTO;
import lk.tmart.core.dto.OrderDTO;
import lk.tmart.core.dto.OrderItemDTO;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.CartServiceRemote;
import lk.tmart.core.service.OrderServiceRemote;
import lk.tmart.web.util.PayHereUtil;

import javax.naming.NamingException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {


    private static final String MERCHANT_ID = "";
    private static final String MERCHANT_SECRET = "";

    @EJB
    private OrderServiceRemote orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loggedInUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<CartItemDTO> items;
        try {
            items = getSelectedItems(user.getEmail(), session);
        } catch (NamingException e) {
            throw new ServletException("Could not obtain cart conversation bean.", e);
        }
        if (items.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double subtotal = 0;
        for (CartItemDTO item : items) subtotal += item.getSubtotal();

        req.setAttribute("cartItems", items);
        req.setAttribute("subtotal", subtotal);
        req.setAttribute("shippingFee", 250.0);
        req.setAttribute("total", subtotal + 250.0);
        req.getRequestDispatcher("/pages/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loggedInUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String name = req.getParameter("shippingName");
        String phone = req.getParameter("shippingPhone");
        String address = req.getParameter("shippingAddress");
        String city = req.getParameter("shippingCity");

        try {
            List<CartItemDTO> items = getSelectedItems(user.getEmail(), session);

            OrderDTO order = orderService.createOrder(user.getEmail(), name, phone, address, city, items);

            session.removeAttribute("checkoutSelection");

            String amount = String.format("%.2f", order.getTotalAmount());
            String orderIdStr = String.valueOf(order.getOrderId());
            String currency = "LKR";
            String hash = PayHereUtil.generateHash(MERCHANT_ID, orderIdStr, amount, currency, MERCHANT_SECRET);
            String itemsDescription = buildItemsDescription(order);
            String notifyUrl = buildNotifyUrl(req);

            req.setAttribute("order", order);
            req.setAttribute("merchantId", MERCHANT_ID);
            req.setAttribute("amount", amount);
            req.setAttribute("hash", hash);
            req.setAttribute("itemsDescription", itemsDescription);
            req.setAttribute("notifyUrl", notifyUrl);
            req.setAttribute("userEmail", user.getEmail());

            req.setAttribute("readyForPayment", true);

            req.getRequestDispatcher("/pages/checkout.jsp").forward(req, resp);

        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/checkout");
        }
    }

    private String buildNotifyUrl(HttpServletRequest req) {
        String scheme = req.getScheme();
        String host = req.getServerName();
        int port = req.getServerPort();
        String contextPath = req.getContextPath();

        StringBuilder baseUrl = new StringBuilder();
        baseUrl.append(scheme).append("://").append(host);

        boolean isStandardPort = (scheme.equals("http") && port == 80)
                || (scheme.equals("https") && port == 443);
        if (!isStandardPort) {
            baseUrl.append(":").append(port);
        }
        baseUrl.append(contextPath);

        return baseUrl + "/payhere/notify";
    }

    private String buildItemsDescription(OrderDTO order) {
        StringBuilder sb = new StringBuilder();
        for (OrderItemDTO item : order.getItems()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(item.getProductName()).append(" x").append(item.getQty());
        }
        if (sb.length() == 0) {
            return "TechMart Online Order #" + order.getOrderId();
        }
        if (sb.length() > 120) {
            return sb.substring(0, 117) + "...";
        }
        return sb.toString();
    }

    @SuppressWarnings("unchecked")
    private List<CartItemDTO> getSelectedItems(String userEmail, HttpSession session) throws NamingException {
        CartServiceRemote cartService = CartConversationHelper.getCartFor(session, userEmail);
        List<CartItemDTO> allItems = cartService.getCartItems();
        List<Integer> selection = (List<Integer>) session.getAttribute("checkoutSelection");

        if (selection == null || selection.isEmpty()) {
            return allItems;
        }

        List<CartItemDTO> filtered = new ArrayList<>();
        for (CartItemDTO item : allItems) {
            if (selection.contains(item.getCartItemId())) {
                filtered.add(item);
            }
        }
        return filtered;
    }
}

