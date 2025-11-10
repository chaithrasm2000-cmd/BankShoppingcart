<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #fbc2eb, #a6c1ee);
            font-family: 'Segoe UI', sans-serif;
            padding-top: 60px;
        }

        .form-container {
            background: rgba(255,255,255,0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
            max-width: 600px;
            margin: auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #4a148c;
        }

        label {
            font-weight: bold;
            color: #6a1b9a;
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #283593;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Edit User</h2>

    <form action="${pageContext.request.contextPath}/updateuser" method="post">
        <input type="hidden" name="id" value="${user.id}">

        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" class="form-control" name="name" value="${user.name}" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" name="email" value="${user.email}" required>
        </div>

        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="text" class="form-control" name="phone" value="${user.phone}" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" name="password" value="${user.password}" required>
        </div>

        <div class="form-group">
            <label for="role">Role:</label>
            <select class="form-control" name="role">
                <option value="CUSTOMER" ${user.role == 'CUSTOMER' ? 'selected' : ''}>Customer</option>
                <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Update User</button>
    </form>

    <a href="/viewusers" class="back-link">← Back to User List</a>
</div>

</body>
</html>
