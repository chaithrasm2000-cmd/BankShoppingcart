package com.demo.main.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String message;
    @Column(name = "is_read")
    private boolean read;

    @ManyToOne
    @JoinColumn(name = "recipient_id")
    private user recipient;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public boolean isRead() {
		return read;
	}

	public void setRead(boolean read) {
		this.read = read;
	}

	public user getRecipient() {
		return recipient;
	}

	public void setRecipient(user recipient) {
		this.recipient = recipient;
	}

	public Notification(Long id, String message, boolean read, user recipient) {
		super();
		this.id = id;
		this.message = message;
		this.read = read;
		this.recipient = recipient;
	}

	public Notification() {
		super();
		// TODO Auto-generated constructor stub
	}
    
}


