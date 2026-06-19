package lk.tmart.web.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Guards any URL under /pages/* that requires a logged-in user, EXCEPT
 * login.jsp and register.jsp themselves (those must stay public).
 */
@WebFilter("/pages/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        boolean isPublicPage = uri.endsWith("/login.jsp") || uri.endsWith("/register.jsp");

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("userEmail") != null;

        if (isPublicPage || isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
