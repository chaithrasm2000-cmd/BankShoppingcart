package com.demo.main.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.demo.main.model.CartItem;
import com.demo.main.model.Product;
import com.demo.main.model.user;
import com.demo.main.services.CartService;
import com.demo.main.services.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CartService cartService;

    // Show all products
    @GetMapping("/products")
    public String viewProducts(@RequestParam(required = false) String search,
                               @RequestParam(required = false) String type,
                               HttpSession session,
                               Model model) {
        List<Product> products;
        String message = "All Products";

        if (search != null && !search.isEmpty()) {
            products = productService.searchAllProducts(search);
            message = "Results for '" + search + "'";
        } else if (type != null && !type.isEmpty()) {
            products = productService.getAllProductsByType(type);
            message = "Category: " + type;
        } else {
            products = productService.getAllProducts();
        }

        model.addAttribute("products", products);
        model.addAttribute("message", message);

        // ✅ Add cart badge info
        user u = (user) session.getAttribute("loggeduser");
        if (u != null) {
            int cartCount = cartService.getCartItemCount(u);
            session.setAttribute("cartCount", cartCount);

            Map<Long, Integer> productQuantities = new HashMap<>();
            for (CartItem item : cartService.getCartItems(u)) {
                productQuantities.put(item.getProduct().getProdId(), item.getQuantity());
            }
            model.addAttribute("productQuantities", productQuantities);
        }

        return "user/products";
    }

    @GetMapping("/addproduct")
    public String showAddForm(HttpSession session) {
        Object loggedUser = session.getAttribute("loggeduser");
        if (loggedUser == null || !"ADMIN".equalsIgnoreCase(((user) loggedUser).getRole())) {
            return "redirect:/userlogin";
        }
        return "user/addproduct";
    }

    @PostMapping("/saveproduct")
    public String saveProduct(@RequestParam("prodName") String name,
                              @RequestParam("prodType") String type,
                              @RequestParam("prodInfo") String info,
                              @RequestParam("prodPrice") Double price,
                              @RequestParam("prodQuantity") Integer quantity,
                              @RequestParam("prodImageUrl") MultipartFile imageFile,
                              @RequestParam(value = "available", required = false) Boolean available,
                              HttpServletRequest request,
                              HttpSession session) throws IOException {

        Object loggedUser = session.getAttribute("loggeduser");
        if (loggedUser == null || !"ADMIN".equalsIgnoreCase(((user) loggedUser).getRole())) {
            return "redirect:/userlogin";
        }

        String uploadDir = request.getServletContext().getRealPath("/images/");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String fileName = imageFile.getOriginalFilename();
        File saveFile = new File(uploadDir, fileName);
        imageFile.transferTo(saveFile);

        Product product = new Product();
        product.setProdName(name);
        product.setProdType(type);
        product.setProdInfo(info);
        product.setProdPrice(price);
        product.setProdQuantity(quantity);
        product.setProdImageUrl("/images/" + fileName);
        product.setAvailable(available != null ? available : false);

        productService.saveProduct(product);
        return "redirect:/products";
    }

    @GetMapping("/editproduct/{id}")
    public String editProduct(@PathVariable Long id, Model model, HttpSession session) {
        Object loggedUser = session.getAttribute("loggeduser");
        if (loggedUser == null || !"ADMIN".equalsIgnoreCase(((user) loggedUser).getRole())) {
            return "redirect:/userlogin";
        }

        Product product = productService.getProductById(id).orElse(null);
        model.addAttribute("product", product);
        return "user/editproduct";
    }

    @PostMapping("/updateproduct")
    public String updateProduct(@RequestParam Long prodId,
                                @RequestParam String prodName,
                                @RequestParam String prodType,
                                @RequestParam String prodInfo,
                                @RequestParam Double prodPrice,
                                @RequestParam Integer prodQuantity,
                                @RequestParam("prodImageUrl") MultipartFile imageFile,
                                @RequestParam(value = "available", required = false) Boolean available,
                                HttpServletRequest request,
                                HttpSession session) throws IOException {

        Object loggedUser = session.getAttribute("loggeduser");
        if (loggedUser == null || !"ADMIN".equalsIgnoreCase(((user) loggedUser).getRole())) {
            return "redirect:/userlogin";
        }

        Product existing = productService.getProductById(prodId).orElse(null);
        if (existing == null) {
            return "redirect:/products";
        }

        existing.setProdName(prodName);
        existing.setProdType(prodType);
        existing.setProdInfo(prodInfo);
        existing.setProdPrice(prodPrice);
        existing.setProdQuantity(prodQuantity);
        existing.setAvailable(available != null ? available : false);

        if (!imageFile.isEmpty()) {
            String uploadDir = request.getServletContext().getRealPath("/images/");
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String fileName = imageFile.getOriginalFilename();
            File saveFile = new File(uploadDir, fileName);
            imageFile.transferTo(saveFile);

            existing.setProdImageUrl("/images/" + fileName);
        }

        productService.saveProduct(existing);
        return "redirect:/products";
    }

    @GetMapping("/deleteproduct/{id}")
    public String deleteProduct(@PathVariable Long id, HttpSession session) {
        Object loggedUser = session.getAttribute("loggeduser");
        if (loggedUser == null || !"ADMIN".equalsIgnoreCase(((user) loggedUser).getRole())) {
            return "redirect:/userlogin";
        }

        productService.deleteProduct(id);
        return "redirect:/products";
    }
}
