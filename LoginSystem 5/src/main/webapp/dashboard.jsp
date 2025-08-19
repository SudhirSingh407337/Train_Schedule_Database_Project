<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
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
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        h1 {
            color: #333;
            margin: 0;
        }
        .user-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .logout-btn {
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
        .nav-links {
            margin-top: 20px;
        }
        .nav-links a {
            display: inline-block;
            margin-right: 15px;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .nav-links a:hover {
            background-color: #0056b3;
        }
        .welcome-message {
            color: #28a745;
            font-size: 18px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<%
    
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("loggedIn") == null || 
        !(Boolean)userSession.getAttribute("loggedIn")) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String username = (String) userSession.getAttribute("username");
    String email = (String) userSession.getAttribute("email");
    String userIdStr = String.valueOf(userSession.getAttribute("userId"));
%>

    <div class="container">
        <div class="header">
            <h1>Welcome to Your Dashboard</h1>
            <a href="logout.jsp" class="logout-btn">Logout</a>
        </div>
        
        <div class="welcome-message">
            <strong>Login Successful!</strong> Welcome back, <%= username %>!
        </div>
        
        <div class="user-info">
            <h3>User Information</h3>
            <p><strong>Username:</strong> <%= username %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>User ID:</strong> <%= userIdStr %></p>
            <p><strong>Session ID:</strong> <%= userSession.getId() %></p>
        </div>
        
        <div class="nav-links">
    <h3>Navigation</h3>
    <a href="index.jsp">Home Page</a>

    <%
        String role = (String) userSession.getAttribute("role");
        if ("customer".equals(role)) {
    %>
        <a href="searchSchedule.jsp">Search Schedule</a>
        <a href="myReservations.jsp">My Reservations</a>
        <a href="askQuestion.jsp">Ask Question</a>
        <a href="viewQA.jsp">Browse Q&amp;A</a>
        <div style="margin-top: 10px;">
    		<a href="searchQA.jsp">Search Q&amp;A</a>
		</div>

        
    <%
        } else if ("rep".equals(role)) {
    %>
        <a href="answerQuestion.jsp">Answer Questions</a>
        <a href="editSchedule.jsp">Edit Schedule</a>
        <a href="deleteSchedule.jsp">Delete Schedule</a>
        <a href="stationScheduleQuery.jsp">Schedules by Station</a>
        <a href="customersByLine.jsp">Customers by Line</a>
    <%
        } else if ("admin".equals(role)) {
    %>
        <a href="manageReps.jsp">Manage Representatives</a>
        <a href="adminReports.jsp">View Reports</a>
        <a href="adminReservationSearch.jsp">Find Reservations</a>
    <%
        }
    %>
</div>
        
        
        <div style="margin-top: 30px; padding: 20px; background-color: #e9ecef; border-radius: 5px;">
            <h4>System Status</h4>
            <p>You are currently logged in and can access all features of the system.</p>
            <p><strong>Login Time:</strong> <%= new java.util.Date() %></p>
        </div>
    </div>
</body>
</html>