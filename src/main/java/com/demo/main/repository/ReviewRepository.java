package com.demo.main.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.demo.main.model.Review;
import com.demo.main.model.Product;
import com.demo.main.model.user;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    // ✅ Get all reviews for a product
    List<Review> findByProduct(Product product);

    // ✅ Optional: Check if a user already reviewed a product
    boolean existsByReviewerAndProduct(user reviewer, Product product);
}
