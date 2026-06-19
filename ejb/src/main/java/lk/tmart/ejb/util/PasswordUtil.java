package lk.tmart.ejb.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

/**
 * Simple SHA-256 based password utility.
 * Production note: replace with BCrypt (add dependency to ejb pom)
 * for a real system — SHA-256 without salt is acceptable for this
 * assignment prototype but noted as a known limitation in the report.
 */
public class PasswordUtil {

    private PasswordUtil() {}

    public static String hash(String raw) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] digest = md.digest(raw.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(digest);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 not available", e);
        }
    }

    public static boolean verify(String raw, String hashed) {
        return hash(raw).equals(hashed);
    }
}