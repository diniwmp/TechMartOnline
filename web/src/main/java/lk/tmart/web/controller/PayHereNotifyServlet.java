package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.service.OrderServiceRemote;
import lk.tmart.web.util.PayHereUtil;

import java.io.IOException;

@WebServlet("/payhere/notify")
public class PayHereNotifyServlet extends HttpServlet {

    private static final String MERCHANT_SECRET = "";

    @EJB
    private OrderServiceRemote orderService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String merchantId = req.getParameter("merchant_id");
        String orderId = req.getParameter("order_id");
        String payhereAmount = req.getParameter("payhere_amount");
        String payhereCurrency = req.getParameter("payhere_currency");
        String statusCode = req.getParameter("status_code");
        String md5sig = req.getParameter("md5sig");

        if (merchantId == null || orderId == null || md5sig == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String localSig = PayHereUtil.verifyNotifyHash(
                merchantId, orderId, payhereAmount, payhereCurrency, statusCode, MERCHANT_SECRET);

        if (localSig.equalsIgnoreCase(md5sig)) {
            int oid = Integer.parseInt(orderId);
            if ("2".equals(statusCode)) {
                orderService.markOrderPaid(oid);
            } else {
                orderService.markOrderFailed(oid);
            }
        }

        resp.setStatus(HttpServletResponse.SC_OK);
    }
}