<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*" %>
<%
    String repName = (String) session.getAttribute("username");
    if (repName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Representative Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            max-width: 700px;
            margin: 60px auto;
            padding: 30px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        .nav-link {
            display: block;
            margin: 12px 0;
            padding: 12px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .nav-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h2>Welcome, <%= repName %>!</h2>

    <a href="listSchedules.jsp" class="nav-link">Manage Train Schedules</a>
    <a href="answerQuestion.jsp" class="nav-link">Answer Customer Questions</a>
    <a href="stationScheduleQuery.jsp" class="nav-link">View Schedules by Station</a>
    <a href="customersByLine.jsp" class="nav-link">View Customers by Transit Line&amp;Date</a>
    <a href="logout.jsp" class="nav-link" style="background-color: #dc3545;">Logout</a>
</div>
</body>
</html>
