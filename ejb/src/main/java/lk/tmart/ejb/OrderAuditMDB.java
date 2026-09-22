package lk.tmart.ejb;

import jakarta.ejb.ActivationConfigProperty;
import jakarta.ejb.MessageDriven;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;
import jakarta.jms.TextMessage;

import java.util.logging.Level;
import java.util.logging.Logger;

@MessageDriven(activationConfig = {
        @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "jms/OrderEventsTopic"),
        @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Topic")
})
public class OrderAuditMDB implements MessageListener {

    private static final Logger LOGGER = Logger.getLogger(OrderAuditMDB.class.getName());

    @Override
    public void onMessage(Message message) {
        try {
            if (message instanceof TextMessage textMessage) {
                LOGGER.log(Level.INFO, "[ORDER AUDIT] Event received: {0}", textMessage.getText());
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Failed to process order audit event", e);
        }
    }
}