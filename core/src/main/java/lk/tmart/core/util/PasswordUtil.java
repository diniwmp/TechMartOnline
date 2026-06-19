package lk.tmart.core.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

/**
 * SHA-256 password hashing utility.
 *
 * Known limitation (call this out in your assignment report): SHA-256 without
 * a per-user salt is vulnerable to rainbow-table attacks. For a production
 * system, replace this with BCrypt (jBCrypt library) which adds salting and
 * a configurable work factor. Kept simple here so the project has zero
 * extra Maven dependencies to manage for the assignment deadline.
 */
public final class PasswordUtil {

    private PasswordUtil() {
    }

    public static String hash(String rawPassword) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(rawPassword.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hashBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 algorithm not available", e);
        }
    }

    public static boolean verify(String rawPassword, String storedHash) {
        return hash(rawPassword).equals(storedHash);
    }
}
