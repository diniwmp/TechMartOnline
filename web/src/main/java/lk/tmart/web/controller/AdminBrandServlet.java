package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.model.Brand;
import lk.tmart.core.service.CatalogAdminServiceRemote;

import java.io.IOException;

@WebServlet("/admin/brands")
public class AdminBrandServlet extends HttpServlet {

    @EJB
    private CatalogAdminServiceRemote catalogAdminService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Object flashError = session.getAttribute("flashError");
        if (flashError != null) {
            req.setAttribute("error", flashError);
            session.removeAttribute("flashError");
        }

        String editId = req.getParameter("edit");
        if (editId != null) {
            req.setAttribute("editBrand", catalogAdminService.getBrand(Integer.parseInt(editId)));
        }

        req.setAttribute("brands", catalogAdminService.listBrands());
        req.getRequestDispatcher("/admin/brands.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        try {
            switch (action) {
                case "add": {
                    Brand b = new Brand();
                    b.setBrandName(req.getParameter("brandName").trim());
                    catalogAdminService.addBrand(b);
                    break;
                }
                case "update": {
                    Brand b = new Brand();
                    b.setBrandId(Integer.parseInt(req.getParameter("brandId")));
                    b.setBrandName(req.getParameter("brandName").trim());
                    catalogAdminService.updateBrand(b);
                    break;
                }
                case "delete": {
                    catalogAdminService.deleteBrand(Integer.parseInt(req.getParameter("brandId")));
                    break;
                }
            }
        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/brands");
    }
}