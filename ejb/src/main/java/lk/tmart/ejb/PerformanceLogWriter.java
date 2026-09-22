package lk.tmart.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.model.PerformanceLog;

import java.time.LocalDateTime;

@Stateless
public class PerformanceLogWriter {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;


    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public void log(String operationName, long executionTimeMs, String componentType) {
        PerformanceLog entry = new PerformanceLog();
        entry.setOperationName(operationName);
        entry.setExecutionTime(executionTimeMs);
        entry.setComponentType(componentType);
        entry.setIsRead(false);
        entry.setLoggedAt(LocalDateTime.now());
        em.persist(entry);
    }
}