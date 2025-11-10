<form method="post" action="${pageContext.request.contextPath}/product/review">
    <input type="hidden" name="productId" value="${product.prodId}" />
    <label>Rating:</label>
    <select name="rating" required>
        <option value="5">★★★★★</option>
        <option value="4">★★★★</option>
        <option value="3">★★★</option>
        <option value="2">★★</option>
        <option value="1">★</option>
    </select>
    <textarea name="comment" placeholder="Write your review..." required></textarea>
    <button type="submit" class="btn btn-primary">Submit Review</button>
</form>
