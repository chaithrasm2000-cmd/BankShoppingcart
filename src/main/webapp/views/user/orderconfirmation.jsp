<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>
<body style="background-color:#F0FFF0;">
<div class="container">
    <h2>Thank you for your order!</h2>
    <p>Order ID: ${order.id}</p>
    <p>Total Amount: Rs ${order.totalAmount}</p>
    <p>Order Date: ${order.orderDate}</p>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Continue Shopping</a>
</div>
</body>
</html>
