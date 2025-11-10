<c:forEach var="order" items="${orders}">
    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>${order.product.prodName}</strong> — Rs ${order.product.prodPrice}
        </div>
        <div class="panel-body">
            <p>Purchased on: ${order.purchaseDate}</p>

            <!-- ✅ Review Form -->
            <form method="post" action="${pageContext.request.contextPath}/product/review">
                <input type="hidden" name="productId" value="${order.product.prodId}" />
                <label>Rating:</label>
                <select name="rating" required>
                    <option value="5">★★★★★</option>
                    <option value="4">★★★★</option>
                    <option value="3">★★★</option>
                    <option value="2">★★</option>
                    <option value="1">★</option>
                </select>
                <textarea name="comment" class="form-control" placeholder="Write your review..." required></textarea>
                <button type="submit" class="btn btn-primary">Submit Review</button>
            </form>
        </div>
    </div>
</c:forEach>
