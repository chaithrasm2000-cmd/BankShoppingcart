package com.demo.main.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.main.model.Product;
import com.demo.main.repository.ProductRepository;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepo;

    public Product saveProduct(Product product) {
        return productRepo.save(product);
    }

    public List<Product> getAllProducts() {
        return productRepo.findAll();
    }

    public Optional<Product> getProductById(Long id) {
        return productRepo.findById(id);
    }

    public void deleteProduct(Long id) {
        productRepo.deleteById(id);
    }

    public List<Product> searchAllProducts(String keyword) {
        return productRepo.findByProdNameContainingIgnoreCase(keyword);
    }

    public List<Product> getAllProductsByType(String type) {
        return productRepo.findByProdType(type);
    }

    public List<Product> getFeaturedProducts() {
        return productRepo.findTop5ByOrderByProdPriceDesc();
    }
}

