package com.demo.main.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.demo.main.model.CartItem;
import com.demo.main.model.Product;
import com.demo.main.model.user;

public interface CartRepository extends JpaRepository<CartItem, Long> {

    List<CartItem> findByUser(user user);

    @Modifying
    @Transactional
    @Query("DELETE FROM CartItem c WHERE c.user = :user AND c.product = :product")
    void deleteByUserAndProduct(user user, Product product);
}
