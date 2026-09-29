package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.service.CatalogAdminServiceRemote;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @EJB
    private CatalogAdminServiceRemote catalogAdminService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        req.setAttribute("categoryCount", catalogAdminService.countCategories());
        req.setAttribute("brandCount", catalogAdminService.countBrands());
        req.setAttribute("productCount", catalogAdminService.countProducts());


        req.setAttribute("logs", catalogAdminService.listRecentPerformanceLogs(50));
        req.setAttribute("avgByOperation", catalogAdminService.getAverageExecutionTimeByOperation());

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}