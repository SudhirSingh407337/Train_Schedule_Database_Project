<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Schedules</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 40px;
        }
        .container {
            background-color: white;
            padding: 30px;
            max-width: 900px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .back-btn {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Available Train Schedules</h2>

<%
    String originId = request.getParameter("origin_station_id");
    String destId = request.getParameter("destination_station_id");
    String travelDate = request.getParameter("travel_date");
    String sortBy = request.getParameter("sort_by");

    if (originId == null || destId == null || travelDate == null) {
        out.println("<p>Error: Missing search parameters.</p>");
    } else {
        String url = "jdbc:mysql://localhost:3306/railwaydb";
        String user = "root";
        String password = "";

        String orderClause = "";
        if ("arrival".equalsIgnoreCase(sortBy)) {
            orderClause = "ORDER BY s2.arrival_time";
        } else if ("departure".equalsIgnoreCase(sortBy)) {
            orderClause = "ORDER BY s1.departure_time";
        } else if ("fare".equalsIgnoreCase(sortBy)) {
            orderClause = "ORDER BY fare";
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT DISTINCT ts.schedule_id, ts.train_id, s1.departure_time AS departure_datetime, " +
                         "s2.arrival_time AS arrival_datetime, " +
                         "ROUND(tl.base_fare * (s2.stop_order - s1.stop_order), 2) AS fare " +
                         "FROM Train_Schedule ts " +
                         "JOIN Schedule_Stop s1 ON ts.schedule_id = s1.schedule_id AND s1.station_id = ? " +
                         "JOIN Schedule_Stop s2 ON ts.schedule_id = s2.schedule_id AND s2.station_id = ? AND s1.stop_order < s2.stop_order " +
                         "JOIN Train t ON ts.train_id = t.train_id " +
                         "JOIN Transit_Line tl ON t.line_id = tl.line_id " +
                         "WHERE DATE(s1.departure_time) = ? " + orderClause;

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(originId));
            ps.setInt(2, Integer.parseInt(destId));
            ps.setString(3, travelDate);

            ResultSet rs = ps.executeQuery();

            boolean hasResults = false;
            while (rs.next()) {
                if (!hasResults) {
%>
                <table>
                    <tr>
                        <th>Schedule ID</th>
                        <th>Train ID</th>
                        <th>Departure</th>
                        <th>Arrival</th>
                        <th>Fare</th>
                        <th>Action</th>
                    </tr>
<%
                    hasResults = true;
                }
%>
                <tr>
                    <td><%= rs.getInt("schedule_id") %></td>
                    <td><%= rs.getString("train_id") %></td>
                    <td><%= rs.getTimestamp("departure_datetime") %></td>
                    <td><%= rs.getTimestamp("arrival_datetime") %></td>
                    <td>$<%= rs.getBigDecimal("fare") %></td>
                    <td>
    					<form action="makeReservations.jsp" method="get" style="display:inline;">
        					<input type="hidden" name="schedule_id" value="<%= rs.getInt("schedule_id") %>">
        					<input type="hidden" name="origin_station_id" value="<%= originId %>">
        					<input type="hidden" name="destination_station_id" value="<%= destId %>">
        					<input type="hidden" name="travel_date" value="<%= travelDate %>">
        					<button type="submit">Book</button>
    					</form>

    					<form action="viewStops.jsp" method="get" style="display:inline; margin-left: 5px;">
        					<input type="hidden" name="schedule_id" value="<%= rs.getInt("schedule_id") %>">
        					<button type="submit">View Stops</button>
    					</form>
					</td>
                </tr>
<%
            }
            if (hasResults) {
%>
                </table>
<%
            } else {
                out.println("<p>No schedules found for your selected route and date.</p>");
            }

            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

    <div class="back-btn">
        <form action="searchSchedule.jsp" method="get">
            <button type="submit">⬅ Back to Search</button>
        </form>
    </div>
</div>
</body>
</html>













