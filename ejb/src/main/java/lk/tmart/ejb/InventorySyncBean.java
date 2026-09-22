package lk.tmart.ejb;


import jakarta.annotation.PostConstruct;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.model.Stock;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@Singleton
@Startup
@ConcurrencyManagement(ConcurrencyManagementType.CONTAINER)
public class InventorySyncBean {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;
    private Map<Integer, Integer> stockCache = new ConcurrentHashMap<>();

    @PostConstruct
    public void init() {
        syncInventory();
    }

    @Schedule(hour = "*", minute = "*/5", second = "0", persistent = false)
    @Lock(LockType.WRITE)
    public void syncInventory() {
        List<Stock> stockList = em.createQuery("SELECT s FROM Stock s", Stock.class).getResultList();
        Map<Integer, Integer> fresh = new ConcurrentHashMap<>();
        for (Stock s : stockList) {
            fresh.put(s.getStockId(), s.getQty() == null ? 0 : s.getQty());
        }
        stockCache = fresh;
    }

    @Lock(LockType.READ)
    public int getAvailableQty(Integer stockId) {
        if (stockId == null) return 0;
        return stockCache.getOrDefault(stockId, 0);
    }

    @Lock(LockType.WRITE)
    public void adjustStock(Integer stockId, int delta) {
        int current = stockCache.getOrDefault(stockId, 0);
        int updated = Math.max(0, current + delta);
        stockCache.put(stockId, updated);
        Stock s = em.find(Stock.class, stockId);
        if (s != null) {
            s.setQty(updated);
            em.merge(s);
        }
    }
}
