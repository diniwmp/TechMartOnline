

package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.OrderDTO;
import lk.tmart.core.service.OrderServiceRemote;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    @EJB
    private OrderServiceRemote orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        HttpSession session = req.getSession();
        Object flashSuccess = session.getAttribute("flashSuccess");
        if (flashSuccess != null) {
            req.setAttribute("success", flashSuccess);
            session.removeAttribute("flashSuccess");
        }
        Object flashError = session.getAttribute("flashError");
        if (flashError != null) {
            req.setAttribute("error", flashError);
            session.removeAttribute("flashError");
        }


        String status = req.getParameter("status");
        if (status == null || status.trim().isEmpty() || "ALL".equalsIgnoreCase(status.trim())) {
            status = "ALL";
        } else {
            status = status.trim().toUpperCase();
        }


        int page = 1;
        int recordsPerPage = 10;
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * recordsPerPage;


        List<OrderDTO> orders = new ArrayList<>();
        int totalRecords = 0;
        List<OrderDTO> allMatchingOrders;

        if ("ALL".equals(status)) {
            allMatchingOrders = orderService.listAllOrders();
        } else {
            allMatchingOrders = orderService.listOrdersByStatus(status);
        }

        if (allMatchingOrders != null) {
            totalRecords = allMatchingOrders.size();
            int toIndex = Math.min(offset + recordsPerPage, totalRecords);

            if (offset < totalRecords) {
                orders = allMatchingOrders.subList(offset, toIndex);
            } else {
                orders = allMatchingOrders;
            }
        }

        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        req.setAttribute("orders", orders);
        req.setAttribute("selectedStatus", status);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String newStatus = req.getParameter("newStatus");
        String currentFilter = req.getParameter("currentFilter");

        try {
            orderService.updateOrderStatus(orderId, newStatus);
            session.setAttribute("flashSuccess", "Order #" + orderId + " status updated to " + newStatus + ".");
        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());
        }


        String redirectUrl = req.getContextPath() + "/admin/orders";


        if (currentFilter != null && !currentFilter.isBlank() && !"ALL".equalsIgnoreCase(currentFilter.trim())) {
            redirectUrl += "?status=" + currentFilter.trim();
        }

        resp.sendRedirect(redirectUrl);
    }
}







