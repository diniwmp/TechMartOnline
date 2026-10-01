package lk.tmart.web.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PayHereUtil {

    public static String generateHash(String merchantId, String orderId, String amount,
                                      String currency, String merchantSecret) {
        try {
            String hashedSecret = md5(merchantSecret).toUpperCase();
            String raw = merchantId + orderId + amount + currency + hashedSecret;
            return md5(raw).toUpperCase();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public static String verifyNotifyHash(String merchantId, String orderId, String payhereAmount,
                                          String payhereCurrency, String statusCode, String merchantSecret) {
        try {
            String hashedSecret = md5(merchantSecret).toUpperCase();
            String raw = merchantId + orderId + payhereAmount + payhereCurrency + statusCode + hashedSecret;
            return md5(raw).toUpperCase();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    private static String md5(String input) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] digestBytes = md.digest(input.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : digestBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}