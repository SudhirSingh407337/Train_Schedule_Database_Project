<%@ page import="java.sql.*" %>
<%
    int scheduleId = Integer.parseInt(request.getParameter("schedule_id"));
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String sql = "DELETE FROM Train_Schedule WHERE schedule_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, scheduleId);

        int rowsDeleted = stmt.executeUpdate();
        if (rowsDeleted > 0) {
            out.println("<h3>Schedule deleted successfully.</h3>");
        } else {
            out.println("<h3>Failed to delete schedule.</h3>");
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
