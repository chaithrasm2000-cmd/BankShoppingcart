<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <style>
        body {
            background-color: #ffffff;
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 380px;
            background: #f9f9f9;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0px 5px 18px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            color: #4A148C;
            font-weight: bold;
            margin-bottom: 25px;
        }

        label {
            font-size: 15px;
            color: #4A148C;
        }

        .form-control {
            border-radius: 8px;
        }

        .btn-primary {
            width: 100%;
            background: #6A1B9A;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
            transition: 0.3s ease;
        }

        .btn-primary:hover {
            background: #8E24AA;
            transform: scale(1.05);
        }

        .register-link {
            display: block;
            text-align: center;
            margin-top: 18px;
            font-weight: 600;
            color: #283593;
        }

        .register-link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>🔐 Login</h2>

    <form action="${pageContext.request.contextPath}/userlogin" method="post" modelAttribute="user">
        <label for="name">Username</label>
        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required />
        <br>

        <label for="password">Password</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required />
        <br>

        <input type="submit" class="btn btn-primary" value="Login" />
    </form>

    <a href="useraddform.jsp" class="register-link">New User? Register Here</a>

    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
</div>

</body>
</html>
