package com.demo.main.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.demo.main.model.Product;
import com.demo.main.model.user;

public interface ProductRepository extends JpaRepository<Product, Long> {

    // 🔍 Search by name (case-insensitive)
    List<Product> findByProdNameContainingIgnoreCase(String keyword);

    // 🔍 Filter by type
    List<Product> findByProdType(String type);

    // 🔝 Top 5 expensive products
    List<Product> findTop5ByOrderByProdPriceDesc();

    // 🧑‍💼 Seller-specific products
    List<Product> findBySeller(user seller);

    // 🧑‍⚖️ Products pending admin approval
    List<Product> findByAvailableFalse();
}
