<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Reservations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f4f4f4;
        }
        .container {
            background-color: white;
            padding: 30px;
            max-width: 1000px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
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
        button {
            padding: 6px 12px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>My Reservations</h2>

<%
    String status = request.getParameter("status");
    if ("cancelled".equals(status)) {
%>
    <p style="color: green; font-weight: bold;">Reservation cancelled successfully.</p>
<%
    } else if ("unauthorized".equals(status)) {
%>
    <p style="color: red; font-weight: bold;">You are not authorized to cancel this reservation.</p>
<%
    } else if ("error".equals(status)) {
%>
    <p style="color: red; font-weight: bold;">An error occurred. Please try again.</p>
<%
    } else if ("invalid".equals(status)) {
%>
    <p style="color: red; font-weight: bold;">Invalid reservation ID.</p>
<%
    }

    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("loggedIn") == null || !(Boolean)sessionObj.getAttribute("loggedIn")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int customerId = (int) sessionObj.getAttribute("userId");

    String url = "jdbc:mysql://localhost:3306/railwaydb";
    String user = "root"; 
    String password = "";  

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT r.reservation_id, r.schedule_id, o.station_name AS origin_name, " +
                     "d.station_name AS destination_name, r.travel_date, r.trip_type, " +
                     "r.passenger_type, r.total_fare " +
                     "FROM Reservation r " +
                     "JOIN Station o ON r.origin_station_id = o.station_id " +
                     "JOIN Station d ON r.destination_station_id = d.station_id " +
                     "WHERE r.customer_id = ? ORDER BY r.travel_date DESC";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();
%>

        <table>
            <tr>
                <th>Reservation ID</th>
                <th>Schedule ID</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Travel Date</th>
                <th>Trip Type</th>
                <th>Passenger Type</th>
                <th>Total Fare</th>
                <th>Action</th>
            </tr>
<%
        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("reservation_id") %></td>
                <td><%= rs.getInt("schedule_id") %></td>
                <td><%= rs.getString("origin_name") %></td>
                <td><%= rs.getString("destination_name") %></td>
                <td><%= rs.getDate("travel_date") %></td>
                <td><%= rs.getString("trip_type") %></td>
                <td><%= rs.getString("passenger_type") %></td>
                <td>$<%= rs.getBigDecimal("total_fare") %></td>
                <td>
                    <form action="cancelReservation.jsp" method="post" style="margin:0;">
                        <input type="hidden" name="reservation_id" value="<%= rs.getInt("reservation_id") %>" />
                        <button type="submit">Cancel</button>
                    </form>
                </td>
            </tr>
<%
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

        </table>
        <br>
        <form action="dashboard.jsp">
            <button type="submit" style="background-color:#007bff;">⬅ Back to Dashboard</button>
        </form>
</div>
</body>
</html>





