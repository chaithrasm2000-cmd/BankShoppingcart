package com.demo.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.demo.main.model.OrderItem;
import com.demo.main.model.Product;
import com.demo.main.model.user;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {

    // ✅ Correct JPA property path using underscore for nested navigation
    boolean existsByOrder_UserAndProduct(user user, Product product);
}
