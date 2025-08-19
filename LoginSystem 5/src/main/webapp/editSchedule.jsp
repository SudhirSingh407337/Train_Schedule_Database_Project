<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String scheduleId = request.getParameter("schedule_id");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String query = "SELECT * FROM Train_Schedule WHERE schedule_id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(scheduleId));
        rs = stmt.executeQuery();

        if (rs.next()) {
%>
<html>
<head>
    <title>Edit Train Schedule</title>
</head>
<body>
    <h2>Edit Train Schedule</h2>
    <form action="updateSchedule.jsp" method="post">
        <input type="hidden" name="schedule_id" value="<%=rs.getInt("schedule_id")%>"/>
        Train ID: <input type="text" name="train_id" value="<%=rs.getString("train_id")%>"/><br/>
        Line ID: <input type="text" name="line_id" value="<%=rs.getInt("line_id")%>"/><br/>
        Departure: <input type="datetime-local" name="departure_datetime" value="<%=rs.getString("departure_datetime").replace(" ", "T")%>"/><br/>
        Arrival: <input type="datetime-local" name="arrival_datetime" value="<%=rs.getString("arrival_datetime").replace(" ", "T")%>"/><br/>
        Fare: <input type="text" name="fare" value="<%=rs.getDouble("fare")%>"/><br/>
        <input type="submit" value="Update Schedule"/>
    </form>

    <br><br>
    <form action="listSchedules.jsp" method="get">
        <button type="submit">← Back to Schedule List</button>
    </form>
</body>
</html>
<%
        }
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>


