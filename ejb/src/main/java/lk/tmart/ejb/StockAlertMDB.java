package lk.tmart.ejb;

import jakarta.ejb.ActivationConfigProperty;
import jakarta.ejb.MessageDriven;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;
import jakarta.jms.TextMessage;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.model.Notification;

import java.time.LocalDateTime;

@MessageDriven(activationConfig = {
        @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "jms/StockAlertQueue"),
        @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Queue")
})
public class StockAlertMDB implements MessageListener {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @Override
    public void onMessage(Message message) {
        try {
            if (message instanceof TextMessage textMessage) {
                String body = textMessage.getText();
                String[] parts = body.split("\\|");
                String productName = parts.length > 1 ? parts[1] : "Unknown product";
                String qty = parts.length > 2 ? parts[2] : "0";

                Notification notification = new Notification();
                notification.setMessage("Low stock alert: " + productName + " has only " + qty + " left.");
                notification.setNotifiType("STOCK_ALERT");
                notification.setCreatedAt(LocalDateTime.now());

                em.persist(notification);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}