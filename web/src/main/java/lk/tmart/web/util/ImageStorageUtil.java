package lk.tmart.web.util;

import jakarta.servlet.ServletContext;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class ImageStorageUtil {

    public static String saveImage(ServletContext context, InputStream fileContent, String originalFileName) throws IOException {

        String uploadPath = context.getRealPath("/uploads/products");

        Path uploadDir = Paths.get(uploadPath);

        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }

        String extension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex >= 0) {
            extension = originalFileName.substring(dotIndex);
        }

        String fileName = UUID.randomUUID().toString() + extension;

        Path filePath = uploadDir.resolve(fileName);

        Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);

        return fileName;
    }
}