<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <style>
        /* Body with a very light gray background for contrast */
        body {
            background-color: #f8f9fa; /* Very light gray/off-white */
            padding-bottom: 50px; /* Add some space at the bottom */
        }

        /* Container for a full white background and subtle shadow */
        .container {
            background-color: #ffffff; /* **White background for main content** */
            padding: 20px;
            border-radius: 8px; /* Slightly rounded corners */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05); /* Very subtle shadow for depth */
            margin-top: 30px;
        }

        /* Product Card/Thumbnail Enhancements */
        .thumbnail {
            min-height: 400px; /* Increased min-height for consistent card size */
            border: 1px solid #dee2e6; /* Light gray border */
            border-radius: 6px;
            padding: 15px;
            transition: transform 0.2s, box-shadow 0.2s;
            background-color: #ffffff; /* Ensure card background is white */
        }

        .thumbnail:hover {
            transform: translateY(-5px); /* Lift effect on hover */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* Clearer shadow on hover */
        }

        .thumbnail img {
            height: 180px; /* Slightly larger image height */
            max-width: 100%; /* Ensure image fits within the card */
            object-fit: contain; /* Prevents stretching and keeps aspect ratio */
            margin-bottom: 10px;
        }

        h2.text-center {
            margin-top: 0; /* Reset top margin inside the white container */
            margin-bottom: 30px;
            color: #343a40; /* Darker text for headings */
            padding-top: 20px;
        }

        /* Search Form Styling */
        .form-inline {
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
            margin-bottom: 20px !important;
        }

        /* Stock and Badge Styling */
        .stock-label {
            font-weight: 600; /* Slightly bolder */
            color: #495057; /* Darker gray */
            font-size: 14px;
        }

        .cart-badge {
            background-color: #28a745; /* Green color for cart badge (success color) */
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 13px;
            margin-left: 5px;
            display: inline-block; /* Helps with layout */
        }

        /* Button Styling */
        .btn-success {
            background-color: #007bff; /* Primary blue for main action */
            border-color: #007bff;
        }

        .btn-success:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        /* Admin/Seller Buttons */
        .thumbnail .btn-sm {
            margin: 2px;
        }
    </style>
</head>
<body>
<div class="container">

    <h2 class="text-center">🛒 ${message}</h2>

    <form method="get" action="${pageContext.request.contextPath}/products" class="form-inline text-center" style="margin-bottom: 20px;">
        <input type="text" name="search" placeholder="Search products..." class="form-control" style="width: 300px;"/>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    ---

    <div class="row text-center">
        <c:forEach var="product" items="${products}">
            <div class="col-sm-4" style="margin-bottom: 30px;">
                <div class="thumbnail">

                    <c:choose>
                        <c:when test="${not empty product.prodImageUrl}">
                            <img src="${pageContext.request.contextPath}${product.prodImageUrl}"
                                 alt="${product.prodName}">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/views/images/default.jpg" alt="No image">
                        </c:otherwise>
                    </c:choose>

                    <p style="font-size: 18px; margin-bottom: 5px;"><strong>${product.prodName}</strong></p>
                    <p class="text-muted" style="height: 40px; overflow: hidden; font-size: 12px;">${fn:substring(product.prodInfo, 0, 100)}...</p>
                    <p style="font-size: 20px; color: #dc3545; font-weight: bold;">Rs ${product.prodPrice}</p>

                    <p class="stock-label">Items Left: ${product.prodQuantity}</p>

                    <c:if test="${product.prodQuantity > 0 && product.prodQuantity < 5}">
                        <span class="label label-warning" style="margin-bottom: 5px; display: block; font-size: 12px;">
                            ⚠️ Only ${product.prodQuantity} left!
                        </span>
                    </c:if>

                    <p>
                        <c:choose>
                            <c:when test="${product.available && product.prodQuantity > 0}">
                                <span class="label label-success">✅ In Stock</span>
                            </c:when>
                            <c:otherwise>
                                <span class="label label-danger">❌ Out of Stock</span>
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <c:if test="${product.available && product.prodQuantity > 0}">
                        <a href="${pageContext.request.contextPath}/addtocart/${product.prodId}" class="btn btn-success" style="margin-top: 10px;">
                            Add to Cart
                        </a>

                        <c:if test="${productQuantities[product.prodId] != null}">
                            <span class="cart-badge">
                                In Cart: ${productQuantities[product.prodId]}
                            </span>
                        </c:if>
                    </c:if>

                    <c:if test="${loggeduser.role == 'SELLER'}">
                        <div style="margin-top: 15px; border-top: 1px dashed #eee; padding-top: 10px;">
                            <span class="label label-default">Seller Tools</span>
                            <div style="margin-top: 5px;">
                                <a href="${pageContext.request.contextPath}/seller/editproduct/${product.prodId}"
                                   class="btn btn-info btn-sm">Edit</a>

                                <a href="${pageContext.request.contextPath}/seller/deleteproduct/${product.prodId}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure you want to delete this product?')">
                                    Delete
                                </a>

                                <a href="${pageContext.request.contextPath}/toggleavailability/${product.prodId}"
                                   class="btn btn-warning btn-sm">
                                    Toggle
                                </a>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>