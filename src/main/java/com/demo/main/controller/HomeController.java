package com.demo.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.ui.Model; // ✅ Correct import
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.main.model.Product;
import com.demo.main.services.CartService;
import com.demo.main.services.ProductService;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CartService cartService;

    @GetMapping("/")
    public String showIndexPage(Model model, HttpSession session,
                                @RequestParam(required = false) String search,
                                @RequestParam(required = false) String type) {

        String userName = (String) session.getAttribute("username");
        String userType = (String) session.getAttribute("usertype");

        boolean isValidUser = userName != null && "customer".equals(userType);

        List<Product> products;
        String message = "All Products";

        if (search != null) {
            products = productService.searchAllProducts(search);
            message = "Showing Results for '" + search + "'";
        } else if (type != null) {
            products = productService.getAllProductsByType(type);
            message = "Showing Results for '" + type + "'";
        } else {
            products = productService.getAllProducts();
        }

        if (products.isEmpty()) {
            message = "No items found for the search '" + (search != null ? search : type) + "'";
            products = productService.getAllProducts();
        }

        Map<Long, Integer> cartQuantities = new HashMap<>();
        for (Product product : products) {
            int qty = cartService.getCartItemCount(userName, product.getProdId());
            cartQuantities.put(product.getProdId(), qty);
        }

        model.addAttribute("products", products);
        model.addAttribute("message", message);
        model.addAttribute("cartQuantities", cartQuantities);
        model.addAttribute("isValidUser", isValidUser);

        return "user/index"; // maps to index.jsp
    }
}
