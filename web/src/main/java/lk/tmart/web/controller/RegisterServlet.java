package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.dto.LoginResultDTO;
import lk.tmart.core.dto.RegisterRequestDTO;
import lk.tmart.core.service.AuthServiceRemote;

import java.io.IOException;

/**
 * Handles GET (show form) and POST (process registration) for /register.
 *
 * @EJB injection note:
 * This is dependency injection via annotation -- the container resolves the
 * JNDI lookup for us behind the scenes at deployment time. The equivalent
 * manual lookup would be:
 *
 *   InitialContext ctx = new InitialContext();
 *   AuthServiceRemote svc = (AuthServiceRemote) ctx.lookup(
 *       "java:global/TechMartOnline/ejb/AuthServiceBean!lk.tmart.core.service.AuthServiceRemote");
 *
 * @EJB is preferred here because:
 *  - No hardcoded JNDI string scattered across servlets (less brittle to
 *    refactor/rename).
 *  - The container handles the lookup once at servlet init rather than
 *    per-request, which is a small but real performance win under load.
 * Manual JNDI lookup is still useful when the bean name is only known at
 * runtime (e.g. dynamic service discovery) -- not the case here.
 */
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

        String email = req.getParameter("email");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String mobile = req.getParameter("mobile");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // Preserve entered values on error so the user doesn't have to retype everything
        req.setAttribute("email", email);
        req.setAttribute("firstName", firstName);
        req.setAttribute("lastName", lastName);
        req.setAttribute("mobile", mobile);

        if (password == null || !password.equals(confirmPassword)) {
            req.setAttribute("errorMessage", "Passwords do not match.");
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
            return;
        }

        RegisterRequestDTO dto = new RegisterRequestDTO(email, firstName, lastName, mobile, password);
        LoginResultDTO result = authService.register(dto);

        if (!result.isSuccess()) {
            req.setAttribute("errorMessage", result.getMessage());
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
            return;
        }

        // Registration succeeded -- send them to login with a success flash message
        req.getSession().setAttribute("flashSuccess",
                "Account created successfully! Please log in.");
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
