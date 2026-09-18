package lk.tmart.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "notifications")
public class Notification implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "notifi_id")
    private Integer notifiId;

    @Column(name = "user_email")
    private String userEmail;

    private String message;

    @Column(name = "notifi_type")
    private String notifiType;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    public Notification() {}

    public Integer getNotifiId() { return notifiId; }
    public void setNotifiId(Integer notifiId) { this.notifiId = notifiId; }
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getNotifiType() { return notifiType; }
    public void setNotifiType(String notifiType) { this.notifiType = notifiType; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}