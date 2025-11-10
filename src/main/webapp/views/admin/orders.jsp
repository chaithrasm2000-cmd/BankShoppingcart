<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Order History</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>
<body style="background-color:#F0F8FF;">
<div class="container">
    <h2>Your Order History</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="panel panel-default" style="margin-bottom:20px;">
                    <div class="panel-heading">
                        <strong>Order ID:</strong> ${order.id} |
                        <strong>Date:</strong> ${order.orderDate} |
                        <strong>Total:</strong> Rs ${order.totalAmount}
                    </div>
                    <div class="panel-body">
                        <ul>
                            <c:forEach var="item" items="${order.items}">
                                <li>${item.product.prodName} - Qty: ${item.quantity} - Rs ${item.price}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">You haven't placed any orders yet.</div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
