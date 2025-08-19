<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Train Schedules</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 50px;
        }
        .container {
            background-color: white;
            padding: 30px;
            max-width: 600px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        select, input[type="date"], button {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("loggedIn") == null || !(Boolean)sessionObj.getAttribute("loggedIn")) {
        response.sendRedirect("login.jsp");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/railwaydb";
    String user = "root";
    String password = "";

    List<String[]> stations = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT station_id, station_name FROM Station ORDER BY station_name");

        while (rs.next()) {
            stations.add(new String[]{rs.getString("station_id"), rs.getString("station_name")});
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="container">
    <h2>Search Train Schedules</h2>
    <form action="viewSchedules.jsp" method="get">
        <label for="origin">Origin Station:</label>
        <select name="origin_station_id" required>
            <option value="">-- Select Origin --</option>
            <% for (String[] s : stations) { %>
                <option value="<%= s[0] %>"><%= s[1] %></option>
            <% } %>
        </select>

        <label for="destination">Destination Station:</label>
        <select name="destination_station_id" required>
            <option value="">-- Select Destination --</option>
            <% for (String[] s : stations) { %>
                <option value="<%= s[0] %>"><%= s[1] %></option>
            <% } %>
        </select>

        <label for="travel_date">Travel Date:</label>
        <input type="date" name="travel_date" required>

        <label for="sort_by">Sort By:</label>
        <select name="sort_by" id="sort_by">
            <option value="">None</option>
            <option value="arrival">Arrival</option>
            <option value="departure">Departure</option>
            <option value="fare">Fare</option>
        </select>

        <button type="submit">Search Schedules</button>
    </form>
</div>
</body>
</html>

