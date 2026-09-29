package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.tmart.core.model.Category;
import lk.tmart.core.service.CatalogAdminServiceRemote;

import java.io.IOException;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

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
            req.setAttribute("editCategory", catalogAdminService.getCategory(Integer.parseInt(editId)));
        }

        req.setAttribute("categories", catalogAdminService.listCategories());
        req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
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
                    Category c = new Category();
                    c.setCatName(req.getParameter("catName").trim());
                    catalogAdminService.addCategory(c);
                    break;
                }
                case "update": {
                    Category c = new Category();
                    c.setCatId(Integer.parseInt(req.getParameter("catId")));
                    c.setCatName(req.getParameter("catName").trim());
                    catalogAdminService.updateCategory(c);
                    break;
                }
                case "delete": {
                    catalogAdminService.deleteCategory(Integer.parseInt(req.getParameter("catId")));
                    break;
                }
            }
        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}