package lk.tmart.web.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fileName = req.getPathInfo();

        if (fileName == null || fileName.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        fileName = fileName.substring(1);

        if (fileName.contains("..")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String uploadPath = getServletContext().getRealPath("/uploads/products");

        Path imagePath = Paths.get(uploadPath).resolve(fileName);

        if (!Files.exists(imagePath)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = Files.probeContentType(imagePath);
        resp.setContentType(contentType != null ? contentType : "application/octet-stream");

        resp.setHeader("Cache-Control", "max-age=86400");

        try (OutputStream out = resp.getOutputStream()) {
            Files.copy(imagePath, out);
        }
    }
}