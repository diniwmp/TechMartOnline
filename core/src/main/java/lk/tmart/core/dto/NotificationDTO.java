package lk.tmart.core.dto;

import java.io.Serializable;

public class NotificationDTO implements Serializable {

    private Integer notifiId;
    private String message;
    private String notifiType;
    private String createdAt;

    public NotificationDTO() {}

    public NotificationDTO(Integer notifiId, String message, String notifiType, String createdAt) {
        this.notifiId = notifiId;
        this.message = message;
        this.notifiType = notifiType;
        this.createdAt = createdAt;
    }

    public Integer getNotifiId() { return notifiId; }
    public void setNotifiId(Integer notifiId) { this.notifiId = notifiId; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getNotifiType() { return notifiType; }
    public void setNotifiType(String notifiType) { this.notifiType = notifiType; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}