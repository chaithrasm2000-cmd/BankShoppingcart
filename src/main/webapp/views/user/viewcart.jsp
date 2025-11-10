<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>
<body style="background-color:#F9F9F9;">
<div class="container">
    <h2>Your Shopping Cart</h2>

    <c:choose>
        <c:when test="${not empty cartItems}">
        
            <!-- Cart Summary -->
            <div class="row" style="margin-bottom: 15px;">
                <div class="col-md-6">
                    <h4>Total Items: ${cartCount}</h4>
                </div>
                <div class="col-md-6 text-right">
                    <h4>Total Price: Rs ${cartTotal}</h4>
                </div>
            </div>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Type</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td>${item.product.prodName}</td>
                            <td>${item.product.prodType}</td>
                            <td>${item.product.prodPrice}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/decrease/${item.product.prodId}" class="btn btn-default btn-xs">➖</a>
                                ${item.quantity}
                                <a href="${pageContext.request.contextPath}/increase/${item.product.prodId}" class="btn btn-default btn-xs">➕</a>
                            </td>
                            <td>Rs ${item.product.prodPrice * item.quantity}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/removeitem/${item.product.prodId}" class="btn btn-danger">Remove</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Navigation Buttons -->
            <div class="row" style="margin-top: 20px;">
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-info">🏠 Continue Shopping</a>
                </div>
                <div class="col-md-6 text-right">
                    <form method="post" action="${pageContext.request.contextPath}/checkout">
                        <button type="submit" class="btn btn-primary">Proceed to Checkout</button>
                    </form>
                </div>
            </div>

        </c:when>
        <c:otherwise>
            <div class="alert alert-info">Your cart is empty.</div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
