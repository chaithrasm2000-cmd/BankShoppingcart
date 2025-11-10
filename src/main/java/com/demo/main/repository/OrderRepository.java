package com.demo.main.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.demo.main.model.Order;
import com.demo.main.model.Product;
import com.demo.main.model.user;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(user user); // ✅ This is valid
    
        boolean existsByUserAndProduct(user user, Product product);
    

}
