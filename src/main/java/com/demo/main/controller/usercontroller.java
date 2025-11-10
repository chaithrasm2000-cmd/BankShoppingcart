package com.demo.main.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.demo.main.model.Notification;
import com.demo.main.model.Order;
import com.demo.main.model.Product;
import com.demo.main.model.Review;
import com.demo.main.model.user;
import com.demo.main.repository.NotificationRepository;
import com.demo.main.repository.OrderItemRepository;
import com.demo.main.repository.OrderRepository;
import com.demo.main.repository.ProductRepository;
import com.demo.main.repository.ReviewRepository;
import com.demo.main.services.userServices;

import jakarta.servlet.http.HttpSession;

@Controller
public class usercontroller {

    @Autowired
    private userServices userservice;

    @Autowired
    private ProductRepository productRepo;
    @Autowired
    private ReviewRepository reviewRepo;
    @Autowired
    private NotificationRepository notificationRepo;
    @Autowired
    private OrderRepository orderRepo;
    @Autowired
    private OrderItemRepository orderItemRepo;

    public boolean hasUserAlreadyOrderedProduct(user u, Product p) {
        return orderItemRepo.existsByOrder_UserAndProduct(u, p);
    }

    @GetMapping("/index")
    public String showlanding() {
        return "index";
    }

    @GetMapping("/createuser")
    public String showUserForm(Model m) {
        m.addAttribute("user", new user());
        return "user/useraddform";
    }

    @PostMapping("/saveuser")
    public String saveEmployee(@ModelAttribute user user, Model model) {
        user u = userservice.createUser(user);
        model.addAttribute("user", u);
        return "user/userlogin";
    }

    @GetMapping("/userlogin")
    public String userlogin(Model m) {
        m.addAttribute("user", new user());
        return "user/userlogin";
    }

    @PostMapping("/userlogin")
    public String verifyuser(@ModelAttribute("user") user user, Model model, HttpSession session) {
        user u = userservice.verifyUser(user);
        if (u != null) {
            session.setAttribute("loggeduser", u);
            if ("ADMIN".equalsIgnoreCase(u.getRole())) {
                return "redirect:/admindashboard";
            } else if ("SELLER".equalsIgnoreCase(u.getRole())) {
                return "redirect:/sellerdashboard";
            } else {
                return "user/userhomepage1";
            }
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "user/userlogin";
        }
    }

    @GetMapping("/createadmin")
    public String showAdminForm(Model m) {
        m.addAttribute("user", new user());
        return "user/useraddform";
    }

    @PostMapping("/saveadmin")
    public String saveAdmin(@ModelAttribute user user, Model model) {
        user u = userservice.createAdmin(user);
        model.addAttribute("user", u);
        return "user/userlogin";
    }

    @GetMapping("/viewusers")
    public String findAll(Model model) {
        List<user> users = userservice.findAll();
        model.addAttribute("ul", users);
        return users.isEmpty() ? "user/userhomepage" : "user/viewusers";
    }

    @GetMapping("/edituser/{id}")
    public String findById(Model model, @PathVariable int id) {
        Optional<user> u = userservice.findById(id);
        model.addAttribute("user", u.get());
        return "user/edituser";
    }

    @PostMapping("/updateuser")
    public String updateUser(@ModelAttribute user user) {
        userservice.createUser(user);
        return "redirect:/viewusers";
    }

    @GetMapping("/deleteuser/{id}")
    public String deleteuser(@PathVariable int id) {
        userservice.deleteById(id);
        return "redirect:/viewusers";
    }

    @GetMapping("/userhomepage1")
    public String userHomepage(HttpSession session, Model model) {
        user loggedUser = (user) session.getAttribute("loggeduser");
        if (loggedUser == null) return "redirect:/userlogin";
        model.addAttribute("username", loggedUser.getName());
        return "user/userhomepage1";
    }

    // ✅ Admin Dashboard
    @GetMapping("/admindashboard")
    public String adminDashboard(Model model, HttpSession session) {
        user loggedUser = (user) session.getAttribute("loggeduser");
        if (loggedUser == null || !"ADMIN".equalsIgnoreCase(loggedUser.getRole())) {
            return "redirect:/userlogin";
        }
        model.addAttribute("loggeduser", loggedUser);
        model.addAttribute("productCount", productRepo.count());
        model.addAttribute("orderCount", orderRepo.count());
        model.addAttribute("userCount", userservice.findAll().size());
        return "admin/admindashboard";
    }

 // ✅ Admin: Validate Products
    @GetMapping("/admin/validateproducts")
    public String validateProducts(Model model, HttpSession session) {
        user admin = (user) session.getAttribute("loggeduser");
        if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
            return "redirect:/userlogin";
        }
        model.addAttribute("pendingProducts", productRepo.findByAvailableFalse());
        return "admin/validateproducts";
    }

    // ✅ Approve Product
    @GetMapping("/admin/approveproduct/{id}")
    public String approveProduct(@PathVariable Long id) {
        Product product = productRepo.findById(id).orElse(null);
        if (product != null) {
            product.setAvailable(true);
            product.setRejectionReason(null); // clear any previous rejection
            productRepo.save(product);

            // ✅ Optional: Notify seller
            Notification note = new Notification();
            note.setRecipient(product.getSeller());
            note.setMessage("Your product '" + product.getProdName() + "' has been approved.");
            note.setRead(false);
            notificationRepo.save(note);
        }
        return "redirect:/admin/validateproducts";
    }

    // ❌ Reject Product with Reason
//    @PostMapping("/admin/rejectproduct")
//    public String rejectProduct(@RequestParam Long prodId,
//                                @RequestParam String reason) {
//        Product product = productRepo.findById(prodId).orElse(null);
//        if (product != null) {
//            product.setAvailable(false);
//            product.setRejectionReason(reason);
//            productRepo.save(product);
//
//            // ✅ Optional: Notify seller
//            Notification note = new Notification();
//            note.setRecipient(product.getSeller());
//            note.setMessage("Your product '" + product.getProdName() + "' was rejected. Reason: " + reason);
//            note.setRead(false);
//            notificationRepo.save(note);
//        }
//        return "redirect:/admin/validateproducts";
//    }

    @PostMapping("/admin/rejectproduct")
    public String deleteProduct(@RequestParam Long prodId) {
        productRepo.deleteById(prodId);
        return "redirect:/admin/validateproducts";
    }

    // ✅ Admin: View Orders
    @GetMapping("/admin/orders")
    public String viewAllOrders(Model model, HttpSession session) {
        user loggedUser = (user) session.getAttribute("loggeduser");
        if (loggedUser == null || !"ADMIN".equalsIgnoreCase(loggedUser.getRole())) {
            return "redirect:/userlogin";
        }
        model.addAttribute("orders", orderRepo.findAll());
        return "admin/orders";
    }
 // ✅ Seller Dashboard with Analytics
    @GetMapping("/sellerdashboard")
    public String sellerDashboard(Model model, HttpSession session) {
        user seller = (user) session.getAttribute("loggeduser");
        if (seller == null || !"SELLER".equalsIgnoreCase(seller.getRole())) {
            return "redirect:/userlogin";
        }

        List<Product> sellerProducts = productRepo.findBySeller(seller);
        long approvedCount = sellerProducts.stream().filter(Product::isAvailable).count();
        long pendingCount = sellerProducts.stream().filter(p -> !p.isAvailable()).count();

        model.addAttribute("products", sellerProducts);
        model.addAttribute("productCount", sellerProducts.size());
        model.addAttribute("approvedCount", approvedCount);
        model.addAttribute("pendingCount", pendingCount);

        return "seller/sellerdashboard";
    }

 // ✅ Seller: Edit Product Form
    @GetMapping("/seller/editproduct/{id}")
    public String editProductForm(@PathVariable Long id, Model model, HttpSession session) {
        user seller = (user) session.getAttribute("loggeduser");

        // 🔐 Session check
        if (seller == null || !"SELLER".equalsIgnoreCase(seller.getRole())) {
            return "redirect:/userlogin";
        }

        // 🔍 Fetch product and validate ownership
        Product product = productRepo.findById(id).orElse(null);
        if (product == null || product.getSeller() == null || !Objects.equals(product.getSeller().getId(), seller.getId())) {
            return "redirect:/sellerdashboard";
        }

        model.addAttribute("product", product);
        return "seller/editproduct";
    }

    // ✅ Seller: Update Product
    @PostMapping("/seller/updateproduct")
    public String updateProduct(@ModelAttribute Product product,
                                @RequestParam("imageFile") MultipartFile imageFile,
                                HttpSession session) {
        user seller = (user) session.getAttribute("loggeduser");

        // 🔐 Session check
        if (seller == null || !"SELLER".equalsIgnoreCase(seller.getRole())) {
            return "redirect:/userlogin";
        }

        // 🔍 Fetch existing product to preserve original seller and image if needed
        Product existingProduct = productRepo.findById(product.getProdId()).orElse(null);
        if (existingProduct == null || existingProduct.getSeller() == null || !Objects.equals(existingProduct.getSeller().getId(), seller.getId())) {
            return "redirect:/sellerdashboard";
        }

        // 🖼️ Handle image update
        if (!imageFile.isEmpty()) {
            try {
                String fileName = imageFile.getOriginalFilename();
                String uploadPath = new File("src/main/webapp/images").getAbsolutePath();
                File dest = new File(uploadPath + File.separator + fileName);
                imageFile.transferTo(dest);
                product.setProdImageUrl("images/" + fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // 🛡️ Preserve existing image if no new file uploaded
            product.setProdImageUrl(existingProduct.getProdImageUrl());
        }

        // 🔄 Preserve seller and reset availability
        product.setSeller(seller);
        product.setAvailable(false); // re-validation required

        productRepo.save(product);
        return "redirect:/sellerdashboard";
    }
    @GetMapping("/seller/addproduct")
    public String showAddProductForm(Model model) {
        model.addAttribute("product", new Product());
        return "seller/addproduct";
    }

    @PostMapping("/seller/saveproduct")
    public String saveProduct(@ModelAttribute Product product,
                              @RequestParam("imageFile") MultipartFile imageFile,
                              HttpSession session) {
        user seller = (user) session.getAttribute("loggeduser");
        if (seller == null || !"SELLER".equalsIgnoreCase(seller.getRole())) {
            return "redirect:/userlogin";
        }

        // ✅ Save image to /webapp/images
        if (!imageFile.isEmpty()) {
            try {
                String fileName = imageFile.getOriginalFilename();
                String uploadPath = new File("src/main/webapp/images").getAbsolutePath();
                File dest = new File(uploadPath + File.separator + fileName);
                imageFile.transferTo(dest);

                // ✅ Save relative path for UI
                product.setProdImageUrl("images/" + fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        product.setSeller(seller);
        product.setAvailable(false);
        productRepo.save(product);
        return "redirect:/sellerdashboard";
    }


    // ✅ Seller: Delete Product
    @GetMapping("/seller/deleteproduct/{id}")
    public String deleteSellerProduct(@PathVariable Long id, HttpSession session) {
        user seller = (user) session.getAttribute("loggeduser");
        Product product = productRepo.findById(id).orElse(null);
        if (product != null && product.getSeller().getId() == seller.getId()) {
            productRepo.deleteById(id);
        }
        return "redirect:/sellerdashboard";
    }
    
    @GetMapping("/user/orderhistory")
    public String viewOrders(HttpSession session, Model model) {
        user user = (user) session.getAttribute("loggeduser");
        List<Order> orders = orderRepo.findByUser(user);
        model.addAttribute("orders", orders);
        return "user/orderhistory"; // ✅ matches JSP file
    }

    @PostMapping("/product/review")
    public String submitReview(@RequestParam Long productId,
                               @RequestParam int rating,
                               @RequestParam String comment,
                               HttpSession session) {

        user user = (user) session.getAttribute("loggeduser");
        Product product = productRepo.findById(productId).orElse(null);

        if (user == null || product == null) {
            return "redirect:/user/ordershistory?error=invalidData";
        }

        // ✅ Verify that the user actually bought this product
        boolean hasPurchased = orderItemRepo.existsByOrder_UserAndProduct(user, product);

        if (hasPurchased) {
            Review review = new Review();
            review.setReviewer(user);
            review.setProduct(product);
            review.setRating(rating);
            review.setComment(comment);
            review.setDate(LocalDateTime.now());
            reviewRepo.save(review);
        }

        // ✅ Redirect back to the same page
        return "redirect:/user/orderhistory";
    } 

}
