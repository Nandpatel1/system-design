package domain;

import domain.observer.MessageNotifier;

public class Topic {
    private String id;
    private String name;
    private boolean isActive;
    private long createdAt;
    // Added the subject that belongs to it so that observer pattern can work 
    private MessageNotifier messageNotifier;

    public Topic() {
        this.messageNotifier = new MessageNotifier();
    }

    public Topic(String id, String name, boolean isActive, long createdAt) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.messageNotifier = new MessageNotifier();
    }

    // Getter for MessageSubject to use directly
    public MessageNotifier getMessageNotifier() {
        return messageNotifier;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public long getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(long createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Topic{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", isActive=" + isActive +
                ", emailSubscribers=" + messageNotifier.getEmailSubscribers().size() +
                ", realtimeSubscribers=" + messageNotifier.getRealtimeSubscribers().size() +
                '}';
    }
}
