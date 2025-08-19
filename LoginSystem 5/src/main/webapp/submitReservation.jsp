<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<html>
<head>
    <title>Reservation Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f2ff;
            padding: 40px;
        }
        .message {
            max-width: 600px;
            margin: auto;
            background: #ffffff;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .success {
            color: green;
            font-size: 20px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="message">
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int customerId = (int) sessionObj.getAttribute("userId");
    int scheduleId = Integer.parseInt(request.getParameter("schedule_id"));
    int originId = Integer.parseInt(request.getParameter("origin_station_id"));
    int destinationId = Integer.parseInt(request.getParameter("destination_station_id"));
    String travelDate = request.getParameter("travel_date");
    String passengerType = request.getParameter("passenger_type");
    String tripType = request.getParameter("trip_type");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

  
    String fareSql = "SELECT tl.base_fare * (s2.stop_order - s1.stop_order) AS computed_fare " +
                     "FROM Schedule_Stop s1 " +
                     "JOIN Schedule_Stop s2 ON s1.schedule_id = s2.schedule_id " +
                     "JOIN Train_Schedule ts ON ts.schedule_id = s1.schedule_id " +
                     "JOIN Train t ON ts.train_id = t.train_id " +
                     "JOIN Transit_Line tl ON t.line_id = tl.line_id " +
                     "WHERE s1.schedule_id = ? AND s1.station_id = ? AND s2.station_id = ? AND s1.stop_order < s2.stop_order";

    PreparedStatement ps = conn.prepareStatement(fareSql);
    ps.setInt(1, scheduleId);
    ps.setInt(2, originId);
    ps.setInt(3, destinationId);
    ResultSet rs = ps.executeQuery();

    double fare = 0;
    if (rs.next()) {
        fare = rs.getDouble("computed_fare");
    }

    
    switch (passengerType.toLowerCase()) {
        case "child": fare *= 0.75; break;
        case "senior": fare *= 0.65; break;
        case "disabled": fare *= 0.50; break;
    }

    
    if (tripType.equalsIgnoreCase("Round Trip")) {
        fare *= 2;
    }

    double roundedFare = Math.round(fare * 100.0) / 100.0;
    int reservationId = new Random().nextInt(100000) + 1000;
    java.sql.Date sqlTravelDate = java.sql.Date.valueOf(travelDate);
    Timestamp now = new Timestamp(System.currentTimeMillis());

    
    String insertSql = "INSERT INTO Reservation (reservation_id, customer_id, schedule_id, origin_station_id, destination_station_id, reservation_date, travel_date, total_fare, trip_type, passenger_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement insertPs = conn.prepareStatement(insertSql);
    insertPs.setInt(1, reservationId);
    insertPs.setInt(2, customerId);
    insertPs.setInt(3, scheduleId);
    insertPs.setInt(4, originId);
    insertPs.setInt(5, destinationId);
    insertPs.setTimestamp(6, now);
    insertPs.setDate(7, sqlTravelDate);
    insertPs.setDouble(8, roundedFare);
    insertPs.setString(9, tripType);
    insertPs.setString(10, passengerType);
    insertPs.executeUpdate();

    out.println("<p class='success'>Reservation successful.<br>Reservation ID: #" + reservationId + "<br>Total Fare: $" + String.format("%.2f", roundedFare) + "</p>");

    rs.close();
    ps.close();
    insertPs.close();
    conn.close();
%>

<form action="dashboard.jsp" method="get">
    <button type="submit" style="
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;">
        Return to Dashboard
    </button>
</form>
</div>
</body>
</html>
























