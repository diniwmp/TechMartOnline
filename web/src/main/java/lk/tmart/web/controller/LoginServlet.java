package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.service.AuthServiceRemote;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @EJB
    private AuthServiceRemote authService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // show & clear any flash message set by RegisterServlet
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("flashSuccess") != null) {
            req.setAttribute("successMessage", session.getAttribute("flashSuccess"));
            session.removeAttribute("flashSuccess");
        }

        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        LoginResultDTO result = authService.login(email, password);

        if (!result.isSuccess()) {
            req.setAttribute("errorMessage", result.getMessage());
            req.setAttribute("email", email);
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            return;
        }

        // Login succeeded -- store minimal info in the session.
        // Never store the password or the JPA entity here.
        HttpSession session = req.getSession(true);
        session.setAttribute("userEmail", result.getEmail());
        session.setAttribute("userFirstName", result.getFirstName());
        session.setAttribute("userLastName", result.getLastName());
        session.setAttribute("userRole", result.getRoleName());

        resp.sendRedirect(req.getContextPath() + "/pages/dashboard.jsp");
    }
}
