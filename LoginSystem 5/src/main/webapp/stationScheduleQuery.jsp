<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Schedules by Station</title>
    <style>
        body { font-family: Arial; padding: 20px; background-color: #f1f1f1; }
        .form-container {
            background-color: white; padding: 20px; max-width: 600px; margin: auto; border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .results { margin-top: 30px; }
        table { width: 100%; border-collapse: collapse; background-color: white; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #e0e0e0; }
        select, .submit-btn {
            padding: 10px;
            margin-top: 10px;
            width: 100%;
            border-radius: 5px;
        }
        .submit-btn { background-color: #007bff; color: white; border: none; cursor: pointer; }
        .submit-btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>View Schedules by Station</h2>
        <form method="get" action="stationScheduleQuery.jsp">
            <label for="station_id">Select a Station:</label>
            <select name="station_id" id="station_id" required>
                <option value="">-- Select Station --</option>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet stations = stmt.executeQuery("SELECT station_id, station_name FROM Station");
                        while (stations.next()) {
                %>
                    <option value="<%= stations.getInt("station_id") %>">
                        <%= stations.getString("station_name") %>
                    </option>
                <%
                        }
                        stations.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<option disabled>Error loading stations</option>");
                    }
                %>
            </select>
            <button type="submit" class="submit-btn">Search</button>
        </form>

        <%
            String stationIdStr = request.getParameter("station_id");
            if (stationIdStr != null && !stationIdStr.trim().isEmpty()) {
                int stationId = Integer.parseInt(stationIdStr);
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

                    String query = "SELECT ts.schedule_id, t.train_id, s.station_name, ss.arrival_time, ss.departure_time " +
                                   "FROM Schedule_Stop ss " +
                                   "JOIN Station s ON ss.station_id = s.station_id " +
                                   "JOIN Train_Schedule ts ON ss.schedule_id = ts.schedule_id " +
                                   "JOIN Train t ON ts.train_id = t.train_id " +
                                   "WHERE ss.station_id = ? " +
                                   "ORDER BY ss.arrival_time";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setInt(1, stationId);
                    ResultSet rs = ps.executeQuery();
        %>
        <div class="results">
            <h3>Schedules passing through: 
                <%
                    Statement stmt2 = conn.createStatement();
                    ResultSet stationNameRs = stmt2.executeQuery("SELECT station_name FROM Station WHERE station_id = " + stationId);
                    if (stationNameRs.next()) {
                        out.print(stationNameRs.getString("station_name"));
                    }
                    stationNameRs.close();
                    stmt2.close();
                %>
            </h3>
            <table>
                <tr>
                    <th>Schedule ID</th>
                    <th>Train ID</th>
                    <th>Station</th>
                    <th>Arrival Time</th>
                    <th>Departure Time</th>
                </tr>
                <%
                    boolean found = false;
                    while (rs.next()) {
                        found = true;
                %>
                    <tr>
                        <td><%= rs.getInt("schedule_id") %></td>
                        <td><%= rs.getString("train_id") %></td>
                        <td><%= rs.getString("station_name") %></td>
                        <td><%= rs.getTimestamp("arrival_time") %></td>
                        <td><%= rs.getTimestamp("departure_time") %></td>
                    </tr>
                <%
                    }
                    if (!found) {
                %>
                    <tr><td colspan="5">No schedules found for this station.</td></tr>
                <% } %>
            </table>
        </div>
        <%
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error retrieving schedule data: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
    
    <form action="repDashboard.jsp" style="margin-top: 20px;">
    <button type="submit" style="
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    ">⬅ Back to Dashboard</button>
</form>
    
</body>
</html>

