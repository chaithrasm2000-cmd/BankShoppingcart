<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Validate Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #FFFBE6;
            font-family: 'Segoe UI', sans-serif;
            padding-top: 60px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #6d4c41;
        }

        .panel {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-radius: 8px;
        }

        .panel-heading {
            font-size: 18px;
            font-weight: bold;
            background-color: #ffe0b2 !important;
            color: #4e342e;
        }

        .panel-body p {
            font-size: 15px;
            margin: 5px 0;
        }

        .btn {
            margin-right: 10px;
        }

        footer {
            margin-top: 60px;
            padding: 20px;
            background: #f5f5f5;
            color: #616161;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>🛠️ Pending Product Approvals</h2>

    <c:if test="${empty pendingProducts}">
        <p class="text-center">No products awaiting approval.</p>
    </c:if>

    <c:forEach var="product" items="${pendingProducts}">
        <div class="panel panel-default" style="margin-top:20px;">
            <div class="panel-heading">
                <strong>${product.prodName}</strong> — ₹${product.prodPrice}
            </div>
            <div class="panel-body">
                <p><strong>Type:</strong> ${product.prodType}</p>
                <p><strong>Description:</strong> ${product.prodInfo}</p>
                <p><strong>Quantity:</strong> ${product.prodQuantity}</p>
                <p><strong>Seller:</strong> ${product.seller.name} (${product.seller.email})</p>

                <a href="${pageContext.request.contextPath}/admin/approveproduct/${product.prodId}" class="btn btn-success">
                    <span class="glyphicon glyphicon-ok"></span> Approve
                </a>

                <form method="post" action="${pageContext.request.contextPath}/admin/rejectproduct" style="display:inline;">
                    <input type="hidden" name="prodId" value="${product.prodId}" />
                    <button type="submit" class="btn btn-danger"
                            onclick="return confirm('Are you sure you want to reject this product?')">
                        <span class="glyphicon glyphicon-remove"></span> Reject
                    </button>
                </form>
            </div>
        </div>
    </c:forEach>
</div>

<footer>
    <p>&copy; 2025 ShopEase Admin Panel. All rights reserved.</p>
</footer>

</body>
</html>
