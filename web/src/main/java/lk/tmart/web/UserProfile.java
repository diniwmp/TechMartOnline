package lk.tmart.web;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.service.UserService;

import java.io.IOException;

public class UserProfile extends HttpServlet {

    @EJB
    private UserService userService;
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDTO userDTO = userService.getUserById(1L);
        resp.getWriter().write("UserProfile");    }
}
