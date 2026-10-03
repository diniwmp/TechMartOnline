package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.AuthServiceRemote;
import lk.tmart.core.service.OrderServiceRemote;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @EJB
    private AuthServiceRemote authService;

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

        Object flashSuccess = session.getAttribute("flashSuccess");
        if (flashSuccess != null) {
            req.setAttribute("success", flashSuccess);
            session.removeAttribute("flashSuccess");
        }

        req.setAttribute("user", user);
        req.setAttribute("orders", orderService.listOrdersByUser(user.getEmail()));
        req.getRequestDispatcher("/pages/profile.jsp").forward(req, resp);
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

        req.setCharacterEncoding("UTF-8");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String mobile = req.getParameter("mobile");

        UserDTO updated = authService.updateProfile(user.getEmail(), firstName, lastName, mobile);
        if (updated != null) {
            session.setAttribute("loggedInUser", updated);
            session.setAttribute("flashSuccess", "Profile updated successfully.");
        }

        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}