<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reservation Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }
        .container {
            max-width: 500px;
            background: white;
            margin: 50px auto;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            margin-top: 20px;
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Reservation Details</h2>
    <form action="submitReservation.jsp" method="post">
        <label>Schedule ID:
            <input type="text" name="schedule_id" value="<%= request.getParameter("schedule_id") %>" readonly>
        </label>
        <label>Origin Station:
            <input type="text" name="origin_station_id" value="<%= request.getParameter("origin_station_id") %>" readonly>
        </label>
        <label>Destination Station:
            <input type="text" name="destination_station_id" value="<%= request.getParameter("destination_station_id") %>" readonly>
        </label>
        <label>Travel Date:
            <input type="text" name="travel_date" value="<%= request.getParameter("travel_date") %>" readonly>
        </label>
        <label>Passenger Type:
            <select name="passenger_type">
                <option>Adult</option>
                <option>Child</option>
                <option>Senior</option>
                <option>Disabled</option>
            </select>
        </label>
        <label>Trip Type:
            <select name="trip_type">
                <option>One Way</option>
                <option>Round Trip</option>
            </select>
        </label>
        <button type="submit">Submit Reservation</button>
    </form>
</div>
</body>
</html>









