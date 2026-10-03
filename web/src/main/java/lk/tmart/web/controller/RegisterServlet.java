package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.AuthServiceRemote;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @EJB
    private AuthServiceRemote authService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String mobile = req.getParameter("mobile");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (email != null) email = email.trim().toLowerCase();
        if (firstName != null) firstName = firstName.trim();
        if (lastName != null) lastName = lastName.trim();
        if (mobile != null) mobile = mobile.trim();

        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
            return;
        }

        UserDTO dto = new UserDTO();
        dto.setEmail(email);
        dto.setFirstName(firstName);
        dto.setLastName(lastName);
        dto.setMobile(mobile);

        try {
            authService.register(dto, password);
            req.setAttribute("success", "Account created. Please log in.");
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
        }
    }
}