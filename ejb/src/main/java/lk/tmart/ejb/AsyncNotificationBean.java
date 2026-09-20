package lk.tmart.ejb;

import jakarta.ejb.AsyncResult;
import jakarta.ejb.Asynchronous;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.model.Notification;

import java.time.LocalDateTime;
import java.util.concurrent.Future;

@Stateless
public class AsyncNotificationBean {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @EJB
    private EmailService emailService;

    @Asynchronous
    public Future<Boolean> sendOrderConfirmation(String userEmail, int orderId, double totalAmount) {
        try {
            Notification n = new Notification();
            n.setUserEmail(userEmail);
            n.setMessage("Order #" + orderId + " confirmed. Total: Rs. " + totalAmount);
            n.setNotifiType("ORDER_UPDATE");
            n.setCreatedAt(LocalDateTime.now());
            em.persist(n);

            emailService.sendOrderConfirmationEmail(userEmail, orderId, totalAmount);

            return new AsyncResult<>(true);
        } catch (Exception e) {
            return new AsyncResult<>(false);
        }
    }
}