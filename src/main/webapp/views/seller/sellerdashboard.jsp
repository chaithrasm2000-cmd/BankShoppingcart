<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>
<body style="background-color:#F9F9F9;">
<div class="container text-center">
    <h2>Welcome Seller, ${loggeduser.name}</h2>
    <p>Manage your products here:</p>

    <!-- 🔹 Quick Stats -->
    <div class="row" style="margin-top:20px;">
        <div class="col-sm-4">
            <div class="well">
                <h4>Total Products</h4>
                <p>${productCount}</p>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="well">
                <h4>Approved Products</h4>
                <p>${approvedCount}</p>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="well">
                <h4>Pending Approval</h4>
                <p>${pendingCount}</p>
            </div>
        </div>
    </div>

    <!-- 🔹 Navigation Buttons -->
    <div class="row" style="margin-top:30px;">
        <div class="col-sm-6">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-block">View My Products</a>
        </div>
        <div class="col-sm-6">
            <a href="${pageContext.request.contextPath}/seller/addproduct" class="btn btn-success btn-block">Add New Product</a>
        </div>
    </div>

    <!-- 🔹 Product List -->
    <div class="row" style="margin-top:40px;">
        <c:forEach var="product" items="${products}">
            <div class="col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong>${product.prodName}</strong>
                        <c:choose>
                            <c:when test="${product.available}">
                                <span class="label label-success">Approved</span>
                            </c:when>
                            <c:otherwise>
                                <span class="label label-warning">Pending</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="panel-body">
                        <p><strong>Type:</strong> ${product.prodType}</p>
                        <p><strong>Price:</strong> Rs ${product.prodPrice}</p>
                        <p><strong>Quantity:</strong> ${product.prodQuantity}</p>
                        <img src="${pageContext.request.contextPath}/${product.prodImageUrl}" width="120" height="120" />
                        <br><br>
                        <a href="${pageContext.request.contextPath}/seller/editproduct/${product.prodId}" class="btn btn-info">Edit</a>

                        <a href="${pageContext.request.contextPath}/seller/deleteproduct/${product.prodId}" class="btn btn-danger">Delete</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
