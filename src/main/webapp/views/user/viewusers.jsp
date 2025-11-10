<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Users</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', sans-serif;
            padding-top: 60px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        .table-container {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
        }

        th {
            background-color: #2c3e50;
            color: white;
            text-align: center;
        }

        td {
            text-align: center;
        }

        .btn {
            margin: 0 5px;
        }

        footer {
            margin-top: 60px;
            padding: 20px;
            background: #ecf0f1;
            color: #7f8c8d;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container table-container">
    <h2>👥 All Registered Users</h2>

    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Operations</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="u" items="${ul}">
            <tr>
                <td>${u.id}</td>
                <td>${u.name}</td>
                <td>${u.email}</td>
                <td>${u.phone}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/edituser/${u.id}" class="btn btn-sm btn-info">
                        <span class="glyphicon glyphicon-edit"></span> Edit
                    </a>
                    <a href="${pageContext.request.contextPath}/deleteuser/${u.id}" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure you want to delete this user?');">
                        <span class="glyphicon glyphicon-trash"></span> Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<footer>
    <p>&copy; 2025 ShopEase Admin Panel. All rights reserved.</p>
</footer>

</body>
</html>
