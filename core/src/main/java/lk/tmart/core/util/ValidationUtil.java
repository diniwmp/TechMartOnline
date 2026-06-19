package lk.tmart.core.util;

import java.util.regex.Pattern;

/**
 * Simple, reusable input validation for the registration/login forms.
 * Kept deliberately lightweight (no Bean Validation framework dependency)
 * to avoid pulling extra jars into the EAR for a small assignment scope.
 */
public final class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");

    private static final Pattern MOBILE_PATTERN =
            Pattern.compile("^[0-9+\\s-]{9,15}$");

    private ValidationUtil() {
    }

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidMobile(String mobile) {
        return mobile != null && MOBILE_PATTERN.matcher(mobile.trim()).matches();
    }

    public static boolean isNotBlank(String value) {
        return value != null && !value.trim().isEmpty();
    }

    public static boolean isStrongEnoughPassword(String password) {
        // Minimum 6 chars for assignment scope; tighten for production use.
        return password != null && password.length() >= 6;
    }
}
