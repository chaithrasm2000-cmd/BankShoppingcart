package com.demo.main.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.demo.main.model.CartItem;
import com.demo.main.model.Order;
import com.demo.main.model.OrderItem;
import com.demo.main.model.Product;
import com.demo.main.model.user;
import com.demo.main.repository.OrderItemRepository;
import com.demo.main.repository.OrderRepository;
import com.demo.main.services.CartService;
import com.demo.main.services.ProductService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderRepository orderRepo;

    @Autowired
    private OrderItemRepository orderItemRepo;

    @PostMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        user u = (user) session.getAttribute("loggeduser");
        if (u == null) return "redirect:/login";

        List<CartItem> cartItems = cartService.getCartItems(u);
        if (cartItems.isEmpty()) {
            model.addAttribute("message", "Your cart is empty.");
            return "user/viewcart";
        }

        session.setAttribute("checkoutCart", cartItems);
        session.setAttribute("checkoutTime", LocalDateTime.now());
        return "redirect:/payment";
    }

    @GetMapping("/payment")
    public String showPaymentPage(HttpSession session, Model model) {
        user u = (user) session.getAttribute("loggeduser");
        if (u == null) return "redirect:/login";

        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("checkoutCart");
        LocalDateTime checkoutTime = (LocalDateTime) session.getAttribute("checkoutTime");

        if (cartItems == null || cartItems.isEmpty()) return "redirect:/viewcart";

        if (checkoutTime != null && checkoutTime.plusMinutes(10).isBefore(LocalDateTime.now())) {
            session.removeAttribute("checkoutCart");
            session.removeAttribute("checkoutTime");
            model.addAttribute("message", "Checkout session expired. Please try again.");
            return "user/viewcart";
        }

        double total = cartService.getCartTotal(u);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", total);
        return "user/payment";
    }

    @PostMapping("/confirmorder")
    public String confirmOrder(HttpSession session, Model model) {
        user u = (user) session.getAttribute("loggeduser");
        if (u == null) return "redirect:/login";

        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("checkoutCart");
        LocalDateTime checkoutTime = (LocalDateTime) session.getAttribute("checkoutTime");

        if (cartItems == null || cartItems.isEmpty()) return "redirect:/viewcart";

        if (Math.random() < 0.2) {
            model.addAttribute("error", "Payment failed. Please try again.");
            double total = cartService.getCartTotal(u);
            model.addAttribute("cartItems", cartItems);
            model.addAttribute("cartTotal", total);
            return "user/payment";
        }

        Order order = new Order();
        order.setUser(u);
        order.setOrderDate(checkoutTime != null ? checkoutTime : LocalDateTime.now());

        double total = 0;
        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem cartItem : cartItems) {
            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProduct(cartItem.getProduct());
            item.setQuantity(cartItem.getQuantity());
            item.setPrice(cartItem.getProduct().getProdPrice());
            total += item.getPrice() * item.getQuantity();
            orderItems.add(item);

            // ✅ Update product quantity after purchase
            Product product = cartItem.getProduct();
            int currentStock = product.getProdQuantity();
            int orderedQty = cartItem.getQuantity();
            product.setProdQuantity(Math.max(currentStock - orderedQty, 0));
            productService.saveProduct(product);
        }

        order.setTotalAmount(total);
        order.setItems(orderItems);

        orderRepo.save(order);
        cartService.clearCart(u);

        session.removeAttribute("checkoutCart");
        session.removeAttribute("checkoutTime");

        model.addAttribute("order", order);
        return "user/orderconfirmation";
    }


    @GetMapping("/addtocart/{id}")
    public String addToCart(@PathVariable Long id, HttpSession session, Model model) {
        user u = (user) session.getAttribute("loggeduser");
        Product p = productService.getProductById(id).orElse(null);
        cartService.addToCart(u, p);

        List<CartItem> cartItems = cartService.getCartItems(u);
        double cartTotal = cartService.getCartTotal(u);
        int cartCount = cartService.getCartItemCount(u);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("cartCount", cartCount);

        return "user/viewcart";
    }

    @GetMapping("/increase/{id}")
    public String increaseQuantity(@PathVariable Long id, HttpSession session) {
        user u = (user) session.getAttribute("loggeduser");
        cartService.increaseQuantity(u, id);
        return "redirect:/viewcart";
    }

    @GetMapping("/decrease/{id}")
    public String decreaseQuantity(@PathVariable Long id, HttpSession session) {
        user u = (user) session.getAttribute("loggeduser");
        cartService.decreaseQuantity(u, id);
        return "redirect:/viewcart";
    }

    @GetMapping("/viewcart")
    public String viewCart(HttpSession session, Model model) {
        user u = (user) session.getAttribute("loggeduser");
        if (u == null) return "redirect:/login";

        List<CartItem> cartItems = cartService.getCartItems(u);
        double cartTotal = cartService.getCartTotal(u);
        int cartCount = cartService.getCartItemCount(u);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("cartCount", cartCount);

        return "user/viewcart";
    }

    @GetMapping("/orderhistory")
    public String viewOrderHistory(HttpSession session, Model model) {
        user u = (user) session.getAttribute("loggeduser");
        if (u == null) return "redirect:/login";

        List<Order> orders = orderRepo.findByUser(u);
        model.addAttribute("orders", orders);
        return "user/orderhistory";
    }

    @GetMapping("/removeitem/{id}")
    public String removeItem(@PathVariable Long id, HttpSession session) {
        user u = (user) session.getAttribute("loggeduser");
        Product p = productService.getProductById(id).orElse(null);
        cartService.removeFromCart(u, p);
        return "redirect:/viewcart";
    }
}
