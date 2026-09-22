package lk.tmart.ejb;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import jakarta.jms.ConnectionFactory;
import jakarta.jms.JMSContext;
import jakarta.jms.Queue;

@Stateless
public class StockAlertProducer {

    @Resource(lookup = "jms/StockAlertQueue")
    private Queue stockAlertQueue;

    @Resource(lookup = "jms/__defaultConnectionFactory")
    private ConnectionFactory connectionFactory;

    public void sendLowStockAlert(String productName, int currentQty) {
        try (JMSContext context = connectionFactory.createContext()) {
            String body = "LOW_STOCK|" + productName + "|" + currentQty;
            context.createProducer().send(stockAlertQueue, body);
        }
    }
}