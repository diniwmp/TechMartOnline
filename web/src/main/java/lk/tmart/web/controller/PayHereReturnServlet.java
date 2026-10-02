package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.service.OrderServiceRemote;

import java.io.IOException;

@WebServlet("/payhere/return")
public class PayHereReturnServlet extends HttpServlet {

    @EJB
    private OrderServiceRemote orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        orderService.markOrderPaidIfPending(orderId);
        resp.sendRedirect(req.getContextPath() + "/invoice?orderId=" + orderId);
    }
}