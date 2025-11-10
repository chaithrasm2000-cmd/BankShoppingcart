package com.demo.main.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.demo.main.model.Notification;
import com.demo.main.model.user;

public interface NotificationRepository extends JpaRepository<Notification, Long> {

    // ✅ Get all notifications for a user
    List<Notification> findByRecipient(user recipient);

    // ✅ Get unread notifications
    List<Notification> findByRecipientAndReadFalse(user recipient);
}

