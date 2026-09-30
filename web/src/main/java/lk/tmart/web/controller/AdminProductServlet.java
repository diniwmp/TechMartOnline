package lk.tmart.web.controller;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.tmart.core.service.CatalogAdminServiceRemote;
import lk.tmart.web.util.ImageStorageUtil;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/admin/products")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB limit
public class AdminProductServlet extends HttpServlet {

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
            req.setAttribute("editProduct", catalogAdminService.getProduct(Integer.parseInt(editId)));
        }

        req.setAttribute("products", catalogAdminService.listProducts());
        req.setAttribute("categories", catalogAdminService.listCategories());
        req.setAttribute("brands", catalogAdminService.listBrands());

        req.getRequestDispatcher("/admin/products.jsp").forward(req, resp);
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
                    String imageFileName = handleImageUpload(req);
                    if (imageFileName == null) {
                        throw new Exception("Please choose a product image.");
                    }
                    catalogAdminService.addProduct(
                            req.getParameter("pName").trim(),
                            req.getParameter("description"),
                            imageFileName,
                            Integer.parseInt(req.getParameter("catId")),
                            Integer.parseInt(req.getParameter("brandId")),
                            Double.parseDouble(req.getParameter("price")),
                            Integer.parseInt(req.getParameter("qty"))
                    );
                    break;
                }
                case "update": {
                    String imageFileName = handleImageUpload(req); // null = keep existing image
                    catalogAdminService.updateProduct(
                            Integer.parseInt(req.getParameter("pId")),
                            req.getParameter("pName").trim(),
                            req.getParameter("description"),
                            imageFileName,
                            Integer.parseInt(req.getParameter("catId")),
                            Integer.parseInt(req.getParameter("brandId")),
                            Double.parseDouble(req.getParameter("price")),
                            Integer.parseInt(req.getParameter("qty"))
                    );
                    break;
                }
                case "delete": {
                    catalogAdminService.deleteProduct(Integer.parseInt(req.getParameter("pId")));
                    break;
                }
            }
        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private String handleImageUpload(HttpServletRequest req) throws Exception {
        Part filePart = req.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        String originalFileName = filePart.getSubmittedFileName();
        try (InputStream input = filePart.getInputStream()) {
            return ImageStorageUtil.saveImage(getServletContext(), input, originalFileName);        }
    }
}