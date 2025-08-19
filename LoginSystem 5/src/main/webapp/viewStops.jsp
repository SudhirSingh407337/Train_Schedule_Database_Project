<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Schedule Stops</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            padding: 40px;
        }
        .container {
            background-color: white;
            padding: 30px;
            max-width: 800px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .back-button {
            margin-top: 20px;
            text-align: center;
        }
        .back-button button {
            padding: 10px 20px;
            font-weight: bold;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Stops for Schedule</h2>

    <%
        String scheduleIdStr = request.getParameter("schedule_id");
        if (scheduleIdStr == null) {
            out.println("<p style='color:red;'>Error: No schedule ID provided.</p>");
        } else {
            int scheduleId = Integer.parseInt(scheduleIdStr);

            String url = "jdbc:mysql://localhost:3306/railwaydb";
            String user = "root";
            String password = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                String sql = "SELECT ss.stop_order, s.station_name, ss.arrival_time, ss.departure_time " +
                             "FROM Schedule_Stop ss " +
                             "JOIN Station s ON ss.station_id = s.station_id " +
                             "WHERE ss.schedule_id = ? ORDER BY ss.stop_order";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, scheduleId);
                ResultSet rs = ps.executeQuery();

    %>
                <table>
                    <tr>
                        <th>Stop Order</th>
                        <th>Station Name</th>
                        <th>Arrival Time</th>
                        <th>Departure Time</th>
                    </tr>
    <%
                while (rs.next()) {
    %>
                    <tr>
                        <td><%= rs.getInt("stop_order") %></td>
                        <td><%= rs.getString("station_name") %></td>
                        <td><%= rs.getString("arrival_time") %></td>
                        <td><%= rs.getString("departure_time") %></td>
                    </tr>
    <%
                }
                rs.close();
                ps.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error retrieving stops: " + e.getMessage() + "</p>");
            }
        }
    %>

    </table>

    <div class="back-button">
        <button onclick="history.back()">⬅ Back to Schedule Results</button>
    </div>
</div>
</body>
</html>








