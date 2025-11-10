<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Home page</title>
</head>
<body>
	<h2>UserHomePage</h2>
	<h2>welcome! ${user.name}</h2>
	<form action="${pageContext.request.contextPath}/viewusers" method="get">
        <input type="submit" value="View All Users" />
    </form>
</body>
</html>