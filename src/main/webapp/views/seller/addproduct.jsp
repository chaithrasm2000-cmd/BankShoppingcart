<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add/Edit Product</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <style>
        /* Soft, light background for a clean look */
        body {
            background-color: #f4f7f6; /* Very light, cool gray */
            padding-top: 40px;
            padding-bottom: 40px;
        }

        /* Main card for the form content */
        .product-form-container {
            max-width: 600px; /* Limit the width for better readability */
            margin: 0 auto; /* Center the container */
            background-color: #ffffff; /* **White background** for the card */
            padding: 30px;
            border-radius: 10px; /* Softly rounded corners */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
        }

        h2 {
            color: #34495e; /* Darker text for the heading */
            margin-top: 0;
            margin-bottom: 30px;
            border-bottom: 2px solid #e9ecef; /* Separator line */
            padding-bottom: 10px;
        }

        .form-group label {
            font-weight: bold;
            color: #555;
            margin-top: 5px;
        }

        .form-control {
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            width: 100%; /* Full width button */
            margin-top: 20px;
            padding: 10px;
            font-size: 16px;
        }

        /* Styling for the checkbox group */
        .form-group > label[for] { /* Target the main label */
            display: block;
            margin-bottom: 5px;
        }

        .form-group input[type="checkbox"] {
            margin-left: 10px;
            /* Adjust size for better tapping/clicking */
            width: 15px;
            height: 15px;
            vertical-align: middle;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="product-form-container">

        <h2>➕ Add New Product</h2>

        <form action="${pageContext.request.contextPath}/seller/saveproduct" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label>Name</label>
                <input type="text" name="prodName" class="form-control" placeholder="e.g., Organic Coffee Beans" required/>
            </div>

            <div class="form-group">
                <label>Type</label>
                <input type="text" name="prodType" class="form-control" placeholder="e.g., Beverage, Electronics, Apparel" required/>
            </div>

            <div class="form-group">
                <label>Info</label>
                <textarea name="prodInfo" class="form-control" rows="3" placeholder="A brief description of the product..."></textarea>
            </div>

            <div class="form-group">
                <label>Price (Rs)</label>
                <input type="number" step="0.01" name="prodPrice" class="form-control" placeholder="0.00" min="0" required/>
            </div>

            <div class="form-group">
                <label>Quantity in Stock</label>
                <input type="number" name="prodQuantity" class="form-control" placeholder="10" min="0" required/>
            </div>

            <div class="form-group">
                <label>Product Image</label>
                <input type="file" name="imageFile" accept="image/*" required />
                <p class="help-block">Upload a clear image for the product.</p>
            </div>

            <div class="form-group" style="margin-top: 20px;">
                <label for="availableCheckbox" style="display: inline-block; margin-right: 15px;">Available for Sale:</label>
                <input type="checkbox" id="availableCheckbox" name="available" checked/>
            </div>

            <button type="submit" class="btn btn-primary">💾 Save Product</button>
        </form>
    </div>
</div>
</body>
</html>