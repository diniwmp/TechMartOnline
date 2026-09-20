package lk.tmart.ejb.interceptor;

import jakarta.ejb.EJB;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.InvocationContext;
import lk.tmart.ejb.PerformanceLogWriter;

public class PerformanceLoggingInterceptor {

    @EJB
    private PerformanceLogWriter logWriter;

    @AroundInvoke
    public Object logExecutionTime(InvocationContext ctx) throws Exception {
        long start = System.currentTimeMillis();
        try {
            return ctx.proceed();
        } finally {
            long duration = System.currentTimeMillis() - start;
            try {
                logWriter.log(
                        ctx.getMethod().getName(),
                        duration,
                        ctx.getTarget().getClass().getSimpleName()
                );
            } catch (Exception ignored) {
            }
        }
    }
}