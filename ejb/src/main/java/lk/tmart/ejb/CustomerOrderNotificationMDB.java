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
        @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "jms/OrderEventsTopic"),
        @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Topic")
})
public class CustomerOrderNotificationMDB implements MessageListener {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @Override
    public void onMessage(Message message) {
        try {
            if (message instanceof TextMessage textMessage) {
                String[] parts = textMessage.getText().split("\\|");
                String eventType = parts.length > 0 ? parts[0] : "UNKNOWN";
                String orderId = parts.length > 1 ? parts[1] : "?";
                String userEmail = parts.length > 2 ? parts[2] : null;
                String extra = parts.length > 3 ? parts[3] : "";

                String text;
                switch (eventType) {
                    case "ORDER_PLACED":
                        text = "Your order #" + orderId + " has been placed successfully.";
                        break;
                    case "ORDER_PAID":
                        text = "Payment received for order #" + orderId + ". Amount paid: Rs. " + extra;
                        break;
                    case "ORDER_STATUS_CHANGED":
                        text = "Order #" + orderId + " status updated to " + extra + ".";
                        break;
                    default:
                        text = "Order #" + orderId + " update: " + eventType;
                }

                Notification n = new Notification();
                n.setUserEmail(userEmail);
                n.setMessage(text);
                n.setNotifiType("ORDER_UPDATE");
                n.setCreatedAt(LocalDateTime.now());
                em.persist(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}