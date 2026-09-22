package lk.tmart.ejb;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.logging.Level;
import java.util.logging.Logger;

@Stateless
public class EmailService {

    private static final Logger LOGGER = Logger.getLogger(EmailService.class.getName());

    @Resource(lookup = "mail/TechMartMailSession")
    private Session mailSession;

    public void sendOrderConfirmationEmail(String toEmail, int orderId, double totalAmount) {
        try {

            String fromAddress = mailSession.getProperty("mail.from");
            if (fromAddress == null) {
                fromAddress = mailSession.getProperty("mail.user");
            }

            Message message = new MimeMessage(mailSession);
            if (fromAddress != null) {
                message.setFrom(new InternetAddress(fromAddress));
            }
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("TechMart Online - Order #" + orderId + " Confirmed");
            message.setText("Your payment for order #" + orderId + " has been received.\n"
                    + "Amount paid: Rs. " + totalAmount + "\n\n"
                    + "Thank you for shopping with TechMart Online.");

            Transport.send(message);
            LOGGER.log(Level.INFO, "Order confirmation email sent to {0}", toEmail);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Failed to send order confirmation email to " + toEmail, e);
        }
    }
}
