<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>User Homepage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <style>
        /* * PRIMARY CHANGE: Set body to a subtle light gray or white 
         * for a clean, professional look, overriding the old gradient.
         */
        body {
            background-color: #f8f9fa; /* Very light gray for contrast with white boxes */
            font-family: 'Segoe UI', sans-serif;
            padding-top: 70px;
        }

        /* Navigation Bar Cleanup */
        .navbar-default {
            background-color: #ffffff; /* White navbar */
            border-bottom: 1px solid #e7e7e7; /* Subtle separator */
        }
        .navbar-brand, .navbar-default .navbar-nav > li > a {
            color: #1b5e20 !important; /* Green text for links */
        }
        .navbar-default .navbar-nav > li > a:hover {
            color: #388e3c !important;
        }

        h2 {
            font-size: 30px;
            font-weight: bold;
            color: #1b5e20; /* Dark Green */
        }

        p {
            font-size: 18px;
            color: #2e7d32; /* Medium Green */
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            transition: 0.3s ease;
        }

        .btn:hover {
            transform: scale(1.05);
            opacity: 0.9;
        }

        /* Main Content Box - Now pure white with a clear shadow */
        .main-box {
            background: #ffffff; /* **Pure White Background** for the main section */
            padding: 40px;
            border-radius: 12px; /* Slightly reduced radius */
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1); /* Clearer, cleaner shadow */
            border: 1px solid #e7e7e7; /* Light border for definition */
            margin-bottom: 30px;
        }

        footer {
            margin-top: 30px; /* Reduced margin */
            padding: 20px;
            background: #e8f5e9; /* Very light green footer */
            color: #33691e;
        }

        /* Panel Styling for the cards */
        .panel {
            border-radius: 10px;
            transition: 0.3s;
            border: none; /* Remove default bootstrap panel border */
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .panel:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .panel-heading {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            font-weight: bold;
            font-size: 16px;
        }

        .panel-body {
            background-color: #ffffff; /* Ensure panel body is white */
        }

        .panel-body span {
            display: block;
            margin-bottom: 15px;
            color: #6c757d; /* Muted icon color */
        }

    </style>
</head>
<body>

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">🛒 **ShopEase**</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/products">Products</a></li>
            <li><a href="/viewcart">Cart</a></li>
            <li><a href="${pageContext.request.contextPath}/orderhistory">Orders</a></li>
            <li><a href="/edituser/1">Profile</a></li>
        </ul>
    </div>
</nav>

<div class="container text-center main-box">
    <h2>Welcome, <span th:text="${username}">User</span> 👋</h2>
    <p>Your centralized hub for shopping and account management.</p>

    <div class="row" style="margin-top:40px;">
        <div class="col-sm-3">
            <div class="panel panel-primary">
                <div class="panel-heading">Browse Products</div>
                <div class="panel-body">
                    <span class="glyphicon glyphicon-th-large" style="font-size:40px; color:#007bff;"></span>
                    <a href="/products" class="btn btn-primary">Shop Now</a>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="panel panel-success">
                <div class="panel-heading">Your Cart</div>
                <div class="panel-body">
                    <span class="glyphicon glyphicon-shopping-cart" style="font-size:40px; color:#28a745;"></span>
                    <a href="/viewcart" class="btn btn-success">View Cart</a>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="panel panel-info">
                <div class="panel-heading">Order History</div>
                <div class="panel-body">
                    <span class="glyphicon glyphicon-list-alt" style="font-size:40px; color:#17a2b8;"></span>
                    <a href="${pageContext.request.contextPath}/orderhistory" class="btn btn-info">View Orders</a>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="panel panel-warning">
                <div class="panel-heading">Your Profile</div>
                <div class="panel-body">
                    <span class="glyphicon glyphicon-user" style="font-size:40px; color:#ffc107;"></span>
                    <a href="/edituser/1" class="btn btn-warning">Edit Profile</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center">
    <p>&copy; 2025 ShopEase. All rights reserved. | <a href="#" style="color: #33691e;">Privacy Policy</a></p>
</footer>

</body>
</html>