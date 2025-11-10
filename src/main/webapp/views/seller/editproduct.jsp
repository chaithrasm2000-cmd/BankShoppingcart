<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>
<body style="background-color:#E6F9E6;">

<div class="container">
    <h2>Edit Product</h2>
<form method="post" action="${pageContext.request.contextPath}/seller/updateproduct" enctype="multipart/form-data">
        <input type="hidden" name="prodId" value="${product.prodId}"/>

        <div class="form-group">
            <label>Name</label>
            <input type="text" name="prodName" value="${product.prodName}" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Type</label>
            <input type="text" name="prodType" value="${product.prodType}" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Info</label>
            <textarea name="prodInfo" class="form-control">${product.prodInfo}</textarea>
        </div>
        <div class="form-group">
            <label>Price</label>
            <input type="number" step="0.01" name="prodPrice" value="${product.prodPrice}" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Quantity</label>
            <input type="number" name="prodQuantity" value="${product.prodQuantity}" class="form-control"/>
        </div>
        <div class="form-group">
            <label>Image (upload new if needed)</label>
            <input type="file" name="imageFile" class="form-control" />
        </div>

        <button type="submit" class="btn btn-success">Update Product</button>
    </form>
</div>

</body>
</html>
