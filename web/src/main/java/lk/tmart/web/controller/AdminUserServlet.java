
package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.service.AuthServiceRemote;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    @EJB
    private AuthServiceRemote authService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        List<?> userList = authService.listAllUsers();


        if (userList == null) {
            userList = new ArrayList<>();
        }


        req.setAttribute("users", userList);


        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }
}
