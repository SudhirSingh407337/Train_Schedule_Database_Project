<%@ page import="java.sql.*" %>
<%
    int scheduleId = Integer.parseInt(request.getParameter("schedule_id"));
    String trainId = request.getParameter("train_id");
    int lineId = Integer.parseInt(request.getParameter("line_id"));
    String departure = request.getParameter("departure_datetime");
    String arrival = request.getParameter("arrival_datetime");
    double fare = Double.parseDouble(request.getParameter("fare"));

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String sql = "UPDATE Train_Schedule SET train_id=?, line_id=?, departure_datetime=?, arrival_datetime=?, fare=? WHERE schedule_id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, trainId);
        stmt.setInt(2, lineId);
        stmt.setString(3, departure);
        stmt.setString(4, arrival);
        stmt.setDouble(5, fare);
        stmt.setInt(6, scheduleId);

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            out.println("<h3>Schedule updated successfully.</h3>");
        } else {
            out.println("<h3>Failed to update schedule.</h3>");
        }
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<br><br>
<form action="listSchedules.jsp" method="get">
    <button type="submit">Back to Schedule List</button>
</form>



