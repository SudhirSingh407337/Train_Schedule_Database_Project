<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - Login System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .nav-section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .nav-section h2 {
            color: #555;
            margin-top: 0;
        }
        .nav-links {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .nav-links a {
            padding: 12px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .nav-links a:hover {
            background-color: #0056b3;
        }
        .login-status {
            text-align: center;
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 5px;
        }
        .logged-in {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .logged-out {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .description {
            text-align: center;
            color: #666;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the Login System</h1>
        
        <%
            
            HttpSession userSession = request.getSession(false);
            boolean isLoggedIn = (userSession != null && 
                                userSession.getAttribute("loggedIn") != null && 
                                (Boolean)userSession.getAttribute("loggedIn"));
            String username = null;
            if (isLoggedIn) {
                username = (String) userSession.getAttribute("username");
            }
        %>
        
        <div class="login-status <%= isLoggedIn ? "logged-in" : "logged-out" %>">
            <% if (isLoggedIn) { %>
                <strong>Status:</strong> You are logged in as <strong><%= username %></strong>
            <% } else { %>
                <strong>Status:</strong> You are not logged in
            <% } %>
        </div>
        
        <div class="nav-section">
            <h2>Authentication</h2>
            <div class="nav-links">
                <% if (isLoggedIn) { %>
                    <a href="dashboard.jsp">Dashboard</a>
                    <a href="logout.jsp">Logout</a>
                <% } else { %>
                    <a href="login.jsp">Login</a>
                <% } %>
            </div>
        </div>
        
        
        <div class="description">
            <p>This is a simple login/logout system built with JSP, JDBC, and MySQL.</p>
            <p>The system demonstrates user authentication, session management, and database connectivity.</p>
        </div>
    </div>
</body>
</html>