<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    // Allow only admin users
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 40px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .dashboard {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .button-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 20px;
        }
        .button-group form {
            margin: 0;
        }
        .button-group button {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .button-group button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="dashboard">
    <h1>Welcome, Admin</h1>
    <div class="button-group">
        <form action="manageReps.jsp" method="get">
            <button type="submit">Manage Customer Representatives</button>
        </form>
        <form action="adminReports.jsp" method="get">
            <button type="submit">View Sales and Revenue Reports</button>
        </form>
        <form action="logout.jsp" method="get">
            <button type="submit">Logout</button>
        </form>
    </div>
</div>
</body>
</html>


