<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Payment Page</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .payment-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-label { font-weight: bold; }
    </style>
</head>
<body>
<div class="payment-container">
    <h3 class="text-center mb-4">Secure Payment</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form method="POST" action="/confirmorder" onsubmit="return showConfirmationModal();">
        <div class="mb-3">
            <label class="form-label">Cardholder Name</label>
            <input type="text" name="cardName" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Card Number</label>
            <input type="text" name="cardNumber" class="form-control" maxlength="16" pattern="\d{16}" required>
        </div>
        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Expiry Date</label>
                <input type="month" name="expiry" class="form-control" required>
            </div>
            <div class="col">
                <label class="form-label">CVV</label>
                <input type="password" name="cvv" class="form-control" maxlength="3" pattern="\d{3}" required>
            </div>
        </div>
        <div class="mb-3 text-center">
            <button type="submit" class="btn btn-primary w-100">Pay ₹${cartTotal}</button>
        </div>
    </form>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmModalLabel">Confirm Payment</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to proceed with the payment of ₹${cartTotal}?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-success" onclick="document.forms[0].submit();">Confirm</button>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showConfirmationModal() {
        const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
        modal.show();
        return false; // prevent immediate form submission
    }
</script>
</body>
</html>
