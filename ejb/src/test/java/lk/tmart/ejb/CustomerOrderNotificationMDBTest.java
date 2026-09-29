package lk.tmart.ejb;

import jakarta.jms.Message;
import jakarta.jms.TextMessage;
import jakarta.persistence.EntityManager;
import lk.tmart.core.model.Notification;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CustomerOrderNotificationMDBTest {

    private EntityManager em;
    private CustomerOrderNotificationMDB mdb;

    @BeforeEach
    void setUp() throws Exception {
        em = mock(EntityManager.class);
        mdb = new CustomerOrderNotificationMDB();

        var emField = CustomerOrderNotificationMDB.class.getDeclaredField("em");
        emField.setAccessible(true);
        emField.set(mdb, em);
    }

    @Test
    void onMessage_buildsOrderPlacedNotification() throws Exception {
        TextMessage message = mock(TextMessage.class);
        when(message.getText()).thenReturn("ORDER_PLACED|15|user@example.com|");

        mdb.onMessage(message);

        ArgumentCaptor<Notification> captor = ArgumentCaptor.forClass(Notification.class);
        verify(em).persist(captor.capture());
        Notification saved = captor.getValue();

        assertEquals("user@example.com", saved.getUserEmail());
        assertEquals("ORDER_UPDATE", saved.getNotifiType());
        assertTrue(saved.getMessage().contains("order #15 has been placed successfully"));
    }

    @Test
    void onMessage_buildsOrderPaidNotification_withAmount() throws Exception {
        TextMessage message = mock(TextMessage.class);
        when(message.getText()).thenReturn("ORDER_PAID|15|user@example.com|2750.0");

        mdb.onMessage(message);

        ArgumentCaptor<Notification> captor = ArgumentCaptor.forClass(Notification.class);
        verify(em).persist(captor.capture());

        assertTrue(captor.getValue().getMessage().contains("Amount paid: Rs. 2750.0"));
    }

    @Test
    void onMessage_buildsStatusChangedNotification() throws Exception {
        TextMessage message = mock(TextMessage.class);
        when(message.getText()).thenReturn("ORDER_STATUS_CHANGED|15|user@example.com|SHIPPED");

        mdb.onMessage(message);

        ArgumentCaptor<Notification> captor = ArgumentCaptor.forClass(Notification.class);
        verify(em).persist(captor.capture());

        assertTrue(captor.getValue().getMessage().contains("status updated to SHIPPED"));
    }

    @Test
    void onMessage_doesNothing_whenMessageIsNotTextMessage() {
        Message nonTextMessage = mock(Message.class);

        assertDoesNotThrow(() -> mdb.onMessage(nonTextMessage));
        verifyNoInteractions(em);
    }
}