<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            padding: 50px;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            max-width: 400px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-container h2 {
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            width: 100%;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .message {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Register</h2>

        <%
            String register = request.getParameter("register");
            String error = request.getParameter("error");

            if ("success".equals(register)) {
        %>
            <div class="message success">Registration successful! You can now log in.</div>
        <% } else if ("exists".equals(error)) { %>
            <div class="message error">Username already exists. Please choose another.</div>
        <% } else if ("exception".equals(error)) { %>
            <div class="message error">Something went wrong. Please try again.</div>
        <% } %>

        <form action="registerUser.jsp" method="post">
            <label for="username">Username</label>
            <input type="text" name="username" required>

            <label for="email">Email</label>
            <input type="email" name="email" required>

            <label for="password">Password</label>
            <input type="password" name="password" required>

            <button type="submit" class="btn">Register</button>
        </form>

        <p style="margin-top: 15px;">Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>

