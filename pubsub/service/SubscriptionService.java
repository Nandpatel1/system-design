package service;

import domain.Subscription;
import domain.observer.EmailSubscriber;
import domain.observer.RealtimeSubscriber;
import java.util.UUID;
import repository.SubscriberRepository;
import repository.SubscriptionRepository;
import repository.TopicRepository;

public class SubscriptionService {
    private SubscriptionRepository subscriptionRepository;
    private SubscriberRepository subscriberRepository;
    private TopicRepository topicRepository;

    public SubscriptionService(SubscriptionRepository subscriptionRepository,
                             SubscriberRepository subscriberRepository,
                             TopicRepository topicRepository) {
        this.subscriptionRepository = subscriptionRepository;
        this.subscriberRepository = subscriberRepository;
        this.topicRepository = topicRepository;
    }

    public Subscription subscribeToTopic(String topicId, String subscriberId) {
        Subscription subscription = new Subscription(UUID.randomUUID().toString(), topicId, 
                                                   subscriberId, true, System.currentTimeMillis());
        subscriptionRepository.save(subscription);
        
        // Add to topic subscriber lists
        topicRepository.findById(topicId).ifPresent(topic -> {
            subscriberRepository.findById(subscriberId).ifPresent(subscriber -> {
                // Always add to email list
                EmailSubscriber emailSub = new EmailSubscriber(subscriber.getEmail());
                topic.getMessageNotifier().addEmailSubscriber(emailSub);
                
                // Add to realtime list if online
                if (subscriber.isOnline()) {
                    RealtimeSubscriber realtimeSub = new RealtimeSubscriber(
                        subscriber.getRealtimeConnectionId(), subscriberId);
                    topic.getMessageNotifier().addRealtimeSubscriber(realtimeSub);
                }
            });
        });
        
        return subscription;
    }

    public void unsubscribeFromTopic(String topicId, String subscriberId) {
        subscriptionRepository.deactivateSubscription(topicId, subscriberId);
        
        // TODO: Remove from topic subscriber lists
        System.out.println("Unsubscribed " + subscriberId + " from topic " + topicId);
    }
}
