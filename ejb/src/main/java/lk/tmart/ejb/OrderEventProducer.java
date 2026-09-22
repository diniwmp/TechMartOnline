package lk.tmart.ejb;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import jakarta.jms.ConnectionFactory;
import jakarta.jms.JMSContext;
import jakarta.jms.Topic;

@Stateless
public class OrderEventProducer {

    @Resource(lookup = "jms/__defaultConnectionFactory")
    private ConnectionFactory connectionFactory;

    @Resource(lookup = "jms/OrderEventsTopic")
    private Topic orderEventsTopic;

    public void publishOrderEvent(String eventType, int orderId, String userEmail, double totalAmount) {
        try (JMSContext context = connectionFactory.createContext()) {
            String body = eventType + "|" + orderId + "|" + userEmail + "|" + totalAmount;
            context.createProducer().send(orderEventsTopic, body);
        }
    }

    public void publishRawTextMessage(String text) {
        try (JMSContext context = connectionFactory.createContext()) {
            context.createProducer().send(orderEventsTopic, text);
            System.out.println("[JMS PRODUCER] Sent raw message: " + text);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void publishStatusChangeEvent(int orderId, String userEmail, String newStatus) {
        try (JMSContext context = connectionFactory.createContext()) {
            String messageText = "ORDER_STATUS_CHANGED|" + orderId + "|" + userEmail + "|" + newStatus;

            context.createProducer().send(orderEventsTopic, messageText);
            System.out.println("[JMS PRODUCER] Sent status change event: " + messageText);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}