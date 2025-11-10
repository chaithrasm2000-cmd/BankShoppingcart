package com.demo.main.services;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.demo.main.model.CartItem;
import com.demo.main.model.Product;
import com.demo.main.model.user;
import com.demo.main.repository.CartRepository;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepo;

    public void addToCart(user user, Product product) {
        List<CartItem> existingItems = cartRepo.findByUser(user);
        for (CartItem item : existingItems) {
            if (item.getProduct().getProdId().equals(product.getProdId())) {
                item.setQuantity(item.getQuantity() + 1);
                cartRepo.save(item);
                return;
            }
        }
        CartItem newItem = new CartItem(user, product, 1);
        cartRepo.save(newItem);
    }

    public List<CartItem> getCartItems(user user) {
        return cartRepo.findByUser(user);
    }

    public void removeFromCart(user user, Product product) {
        cartRepo.deleteByUserAndProduct(user, product);
    }

    public void clearCart(user user) {
        List<CartItem> items = cartRepo.findByUser(user);
        cartRepo.deleteAll(items);
    }

    public double getCartTotal(user user) {
        List<CartItem> items = cartRepo.findByUser(user);
        double total = 0;
        for (CartItem item : items) {
            total += item.getProduct().getProdPrice() * item.getQuantity();
        }
        return total;
    }

    public int getCartItemCount(user user) {
        List<CartItem> items = cartRepo.findByUser(user);
        int count = 0;
        for (CartItem item : items) {
            count += item.getQuantity();
        }
        return count;
    }

    public int getCartItemCount(String userName, Long prodId) {
        if (userName == null || prodId == null) {
            return 0;
        }

        user tempUser = new user();
        tempUser.setName(userName);

        List<CartItem> items = cartRepo.findByUser(tempUser);
        for (CartItem item : items) {
            if (item.getProduct().getProdId().equals(prodId)) {
                return item.getQuantity();
            }
        }

        return 0;
    }

    // ✅ New: Increase quantity of a cart item
    public void increaseQuantity(user user, Long productId) {
        List<CartItem> items = cartRepo.findByUser(user);
        for (CartItem item : items) {
            if (item.getProduct().getProdId().equals(productId)) {
                item.setQuantity(item.getQuantity() + 1);
                cartRepo.save(item);
                break;
            }
        }
    }

    // ✅ New: Decrease quantity or remove item if quantity reaches zero
    public void decreaseQuantity(user user, Long productId) {
        List<CartItem> items = cartRepo.findByUser(user);
        for (CartItem item : items) {
            if (item.getProduct().getProdId().equals(productId)) {
                int qty = item.getQuantity();
                if (qty > 1) {
                    item.setQuantity(qty - 1);
                    cartRepo.save(item);
                } else {
                    cartRepo.deleteByUserAndProduct(user, item.getProduct());
                }
                break;
            }
        }
    }
}
