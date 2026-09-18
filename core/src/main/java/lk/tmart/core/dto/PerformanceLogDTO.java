package lk.tmart.core.dto;

import java.io.Serializable;

public class PerformanceLogDTO implements Serializable {

    private Integer logId;
    private String operationName;
    private Long executionTime;
    private String componentType;
    private String loggedAt;

    public PerformanceLogDTO() {}

    public PerformanceLogDTO(Integer logId, String operationName, Long executionTime,
                             String componentType, String loggedAt) {
        this.logId = logId;
        this.operationName = operationName;
        this.executionTime = executionTime;
        this.componentType = componentType;
        this.loggedAt = loggedAt;
    }

    public Integer getLogId() { return logId; }
    public void setLogId(Integer logId) { this.logId = logId; }
    public String getOperationName() { return operationName; }
    public void setOperationName(String operationName) { this.operationName = operationName; }
    public Long getExecutionTime() { return executionTime; }
    public void setExecutionTime(Long executionTime) { this.executionTime = executionTime; }
    public String getComponentType() { return componentType; }
    public void setComponentType(String componentType) { this.componentType = componentType; }
    public String getLoggedAt() { return loggedAt; }
    public void setLoggedAt(String loggedAt) { this.loggedAt = loggedAt; }
}