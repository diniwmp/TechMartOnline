package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.tmart.core.service.CatalogAdminServiceRemote;

import java.io.IOException;

@WebServlet("/admin/performance")
public class AdminPerformanceServlet extends HttpServlet {

    @EJB
    private CatalogAdminServiceRemote catalogAdminService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("logs", catalogAdminService.listRecentPerformanceLogs(50));
        req.setAttribute("avgByOperation", catalogAdminService.getAverageExecutionTimeByOperation());
        req.getRequestDispatcher("/admin/performance.jsp").forward(req, resp);
    }
}