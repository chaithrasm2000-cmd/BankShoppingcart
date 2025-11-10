<%@page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', sans-serif;
            padding-top: 70px;
        }

        h2 {
            color: #2c3e50;
            font-weight: bold;
        }

        .well {
            background-color: #ffffff;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .well h4 {
            color: #34495e;
        }

        .well p {
            font-size: 24px;
            color: #2ecc71;
            font-weight: bold;
        }

        .btn {
            padding: 14px;
            font-size: 16px;
            border-radius: 8px;
        }

        footer {
            margin-top: 60px;
            padding: 20px;
            background: #ecf0f1;
            color: #7f8c8d;
            text-align: center;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">🛠️ Admin Panel</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>
</nav>

<!-- Dashboard Content -->
<div class="container text-center">
    <h2>Welcome Admin, ${loggeduser.name}</h2>
    <p>Manage platform operations:</p>

    <!-- Quick Stats -->
    <div class="row" style="margin-top:30px;">
        <div class="col-sm-4">
            <div class="well">
                <h4><span class="glyphicon glyphicon-barcode"></span> Total Products</h4>
                <p>${productCount}</p>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="well">
                <h4><span class="glyphicon glyphicon-list-alt"></span> Total Orders</h4>
                <p>${orderCount}</p>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="well">
                <h4><span class="glyphicon glyphicon-user"></span> Total Users</h4>
                <p>${userCount}</p>
            </div>
        </div>
    </div>

    <!-- Navigation Buttons -->
    <div class="row" style="margin-top:30px;">
        <div class="col-sm-4">
            <a href="${pageContext.request.contextPath}/admin/validateproducts" class="btn btn-warning btn-block">
                <span class="glyphicon glyphicon-check"></span> Validate Products
            </a>
        </div>
        <div class="col-sm-4">
            <a href="${pageContext.request.contextPath}/viewusers" class="btn btn-info btn-block">
                <span class="glyphicon glyphicon-cog"></span> Manage Users
            </a>
        </div>
        <div class="col-sm-4">
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-primary btn-block">
                <span class="glyphicon glyphicon-eye-open"></span> View Orders
            </a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <p>&copy; 2025 ShopEase Admin Dashboard. All rights reserved.</p>
</footer>

</body>
</html>
