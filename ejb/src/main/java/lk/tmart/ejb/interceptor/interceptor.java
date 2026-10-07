package lk.tmart.ejb.interceptor;

import jakarta.ejb.EJB;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.InvocationContext;
import lk.tmart.ejb.PerformanceLogWriter;

public class interceptor {
    @EJB
    private PerformanceLogWriter logWriter;


    @AroundInvoke
    public Object logExecutionTime(InvocationContext ctx) throws Exception {
        long start = System.currentTimeMillis();
      
    }
}
