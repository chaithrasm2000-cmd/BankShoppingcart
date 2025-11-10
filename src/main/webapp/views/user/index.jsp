<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
<div class="text-center" style="color: black; font-size: 14px; font-weight: bold;">
    ${message}
</div>

<c:forEach var="product" items="${products}">
    <div class="col-sm-4" style='height: 350px;'>
        <div class="thumbnail">
            <img src="./ShowImage?pid=${product.prodId}" alt="Product" style="height: 150px; max-width: 180px">
            <p class="productname">${product.prodName}</p>
            <p class="productinfo">${fn:substring(product.prodInfo, 0, 100)}..</p>
            <p class="price">Rs ${product.prodPrice}</p>

            <form method="post">
                <c:choose>
                    <c:when test="${cartQuantities[product.prodId] == 0}">
                        <button type="submit" formaction="./AddtoCart?uid=${sessionScope.username}&pid=${product.prodId}&pqty=1" class="btn btn-success">Add to Cart</button>
                        <button type="submit" formaction="./AddtoCart?uid=${sessionScope.username}&pid=${product.prodId}&pqty=1" class="btn btn-primary">Buy Now</button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" formaction="./AddtoCart?uid=${sessionScope.username}&pid=${product.prodId}&pqty=0" class="btn btn-danger">Remove From Cart</button>
                        <button type="submit" formaction="cartDetails.jsp" class="btn btn-success">Checkout</button>
                    </c:otherwise>
                </c:choose>
            </form>
        </div>
    </div>
</c:forEach>
