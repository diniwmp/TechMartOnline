package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.OrderServiceRemote;

import java.io.IOException;

@WebServlet("/messages")
public class MessagesServlet extends HttpServlet {

    @EJB
    private OrderServiceRemote orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        UserDTO user = session != null ? (UserDTO) session.getAttribute("loggedInUser") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("messages", orderService.listMessagesForUser(user.getEmail()));
        req.getRequestDispatcher("/pages/messages.jsp").forward(req, resp);
    }
}