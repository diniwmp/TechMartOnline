package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.service.CatalogAdminServiceRemote;

import java.io.IOException;

@WebServlet("/admin/inventory")
public class AdminInventoryServlet extends HttpServlet {

    @EJB
    private CatalogAdminServiceRemote catalogAdminService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("products", catalogAdminService.listProducts());
        req.getRequestDispatcher("/admin/inventory.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int pId = Integer.parseInt(req.getParameter("pId"));
        int delta = Integer.parseInt(req.getParameter("delta"));

        catalogAdminService.adjustInventory(pId, delta);

        resp.sendRedirect(req.getContextPath() + "/admin/inventory");
    }
}