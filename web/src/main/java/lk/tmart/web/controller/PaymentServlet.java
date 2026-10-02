package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.OrderDTO;
import lk.tmart.core.dto.OrderItemDTO;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.OrderServiceRemote;
import lk.tmart.web.util.PayHereUtil;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PaymentServlet.class.getName());

    private static final String MERCHANT_ID = "1224059";
    private static final String MERCHANT_SECRET = "MjY4ODkxMjgyMjEzMDU5MTUyNTkzMTg4NzI0NjYwMzc4NzUzNTExMA==";

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

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        OrderDTO order = orderService.getOrderById(orderId);
        if (order == null) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String amount = String.format("%.2f", order.getTotalAmount());
        String orderIdStr = String.valueOf(orderId);
        String currency = "LKR";

        String hash = PayHereUtil.generateHash(MERCHANT_ID, orderIdStr, amount, currency, MERCHANT_SECRET);

        String itemsDescription = buildItemsDescription(order);


        LOGGER.log(Level.WARNING, "=== PayHere Debug START ===");
        LOGGER.log(Level.WARNING, "merchant_id=[{0}] len={1}", new Object[]{MERCHANT_ID, MERCHANT_ID.length()});
        LOGGER.log(Level.WARNING, "order_id=[{0}] len={1}", new Object[]{orderIdStr, orderIdStr.length()});
        LOGGER.log(Level.WARNING, "amount=[{0}] len={1}", new Object[]{amount, amount.length()});
        LOGGER.log(Level.WARNING, "currency=[{0}] len={1}", new Object[]{currency, currency.length()});
        LOGGER.log(Level.WARNING, "secret=[{0}] len={1}", new Object[]{MERCHANT_SECRET, MERCHANT_SECRET.length()});
        LOGGER.log(Level.WARNING, "hash=[{0}]", hash);
        LOGGER.log(Level.WARNING, "items=[{0}]", itemsDescription);
        LOGGER.log(Level.WARNING, "=== PayHere Debug END ===");

        req.setAttribute("order", order);
        req.setAttribute("merchantId", MERCHANT_ID);
        req.setAttribute("amount", amount);
        req.setAttribute("hash", hash);
        req.setAttribute("itemsDescription", itemsDescription);
        req.setAttribute("userEmail", user.getEmail());
        req.getRequestDispatcher("/pages/payment.jsp").forward(req, resp);
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
}
