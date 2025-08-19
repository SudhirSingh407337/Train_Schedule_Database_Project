<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Train Schedules</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px; }
        h2 { text-align: center; }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        a.button {
            padding: 6px 12px;
            color: white;
            background-color: #28a745;
            text-decoration: none;
            border-radius: 4px;
        }
        a.button.delete {
            background-color: #dc3545;
        }
        .back-button {
            display: block;
            width: fit-content;
            margin: 30px auto 0;
            padding: 10px 16px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <h2>Manage Train Schedules</h2>
    <table>
        <tr>
            <th>Schedule ID</th>
            <th>Line ID</th>
            <th>Train ID</th>
            <th>Departure</th>
            <th>Arrival</th>
            <th>Fare</th>
            <th>Actions</th>
        </tr>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM Train_Schedule");

        while (rs.next()) {
            int scheduleId = rs.getInt("schedule_id");
            int lineId = rs.getInt("line_id");
            String trainId = rs.getString("train_id");
            String departure = rs.getString("departure_datetime");
            String arrival = rs.getString("arrival_datetime");
            double fare = rs.getDouble("fare");
%>
        <tr>
            <td><%= scheduleId %></td>
            <td><%= lineId %></td>
            <td><%= trainId %></td>
            <td><%= departure %></td>
            <td><%= arrival %></td>
            <td>$<%= fare %></td>
            <td>
                <a class="button" href="editSchedule.jsp?schedule_id=<%=scheduleId%>">Edit</a>
                <a class="button delete" href="deleteSchedule.jsp?schedule_id=<%=scheduleId%>"
                   onclick="return confirm('Are you sure you want to delete schedule <%=scheduleId%>?');">Delete</a>
            </td>
        </tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>
    </table>

    <a href="repDashboard.jsp" class="back-button">⬅ Back to Dashboard</a>
</body>
</html>

