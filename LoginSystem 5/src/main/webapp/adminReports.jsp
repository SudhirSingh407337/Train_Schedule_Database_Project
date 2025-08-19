<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Reports</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        h1 { color: #333; }
        table { border-collapse: collapse; width: 80%; margin-bottom: 30px; background: white; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #e0e0e0; }
    </style>
</head>
<body>
<h1>Admin Reports</h1>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");
        stmt = conn.createStatement();

        
        out.println("<h2>Monthly Sales Report</h2>");
        rs = stmt.executeQuery("SELECT DATE_FORMAT(travel_date, '%Y-%m') AS month, COUNT(*) AS total_reservations, SUM(total_fare) AS total_revenue FROM Reservation GROUP BY month ORDER BY month DESC");
        out.println("<table><tr><th>Month</th><th>Total Reservations</th><th>Total Revenue ($)</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("month") + "</td><td>" + rs.getInt("total_reservations") + "</td><td>" + rs.getDouble("total_revenue") + "</td></tr>");
        }
        out.println("</table>");

       
        out.println("<h2>Reservations by Transit Line</h2>");
        rs = stmt.executeQuery("SELECT tl.line_name, COUNT(*) AS total_reservations FROM Reservation r JOIN Train_Schedule ts ON r.schedule_id = ts.schedule_id JOIN Transit_Line tl ON ts.line_id = tl.line_id GROUP BY tl.line_name ORDER BY total_reservations DESC");
        out.println("<table><tr><th>Transit Line</th><th>Total Reservations</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("line_name") + "</td><td>" + rs.getInt("total_reservations") + "</td></tr>");
        }
        out.println("</table>");

        
        out.println("<h2>Reservations by Customer</h2>");
        rs = stmt.executeQuery("SELECT c.first_name, c.last_name, COUNT(*) AS total_reservations FROM Reservation r JOIN Customer c ON r.customer_id = c.customer_id GROUP BY c.customer_id ORDER BY total_reservations DESC");
        out.println("<table><tr><th>Customer Name</th><th>Total Reservations</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("first_name") + " " + rs.getString("last_name") + "</td><td>" + rs.getInt("total_reservations") + "</td></tr>");
        }
        out.println("</table>");

     
        out.println("<h2>Revenue by Transit Line</h2>");
        rs = stmt.executeQuery("SELECT tl.line_name, SUM(r.total_fare) AS revenue FROM Reservation r JOIN Train_Schedule ts ON r.schedule_id = ts.schedule_id JOIN Transit_Line tl ON ts.line_id = tl.line_id GROUP BY tl.line_name ORDER BY revenue DESC");
        out.println("<table><tr><th>Transit Line</th><th>Revenue ($)</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("line_name") + "</td><td>" + rs.getDouble("revenue") + "</td></tr>");
        }
        out.println("</table>");

       
        out.println("<h2>Revenue by Customer</h2>");
        rs = stmt.executeQuery("SELECT c.first_name, c.last_name, SUM(r.total_fare) AS revenue FROM Reservation r JOIN Customer c ON r.customer_id = c.customer_id GROUP BY c.customer_id ORDER BY revenue DESC");
        out.println("<table><tr><th>Customer Name</th><th>Revenue ($)</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("first_name") + " " + rs.getString("last_name") + "</td><td>" + rs.getDouble("revenue") + "</td></tr>");
        }
        out.println("</table>");

       
        out.println("<h2>Best Customer</h2>");
        rs = stmt.executeQuery("SELECT c.first_name, c.last_name, SUM(r.total_fare) AS total FROM Reservation r JOIN Customer c ON r.customer_id = c.customer_id GROUP BY r.customer_id ORDER BY total DESC LIMIT 1");
        if (rs.next()) {
            out.println("<p>" + rs.getString("first_name") + " " + rs.getString("last_name") + " ($" + rs.getDouble("total") + ")</p>");
        }

    
        out.println("<h2>Top 5 Most Active Transit Lines</h2>");
        rs = stmt.executeQuery("SELECT tl.line_name, COUNT(*) AS total_reservations FROM Reservation r JOIN Train_Schedule ts ON r.schedule_id = ts.schedule_id JOIN Transit_Line tl ON ts.line_id = tl.line_id GROUP BY tl.line_name ORDER BY total_reservations DESC LIMIT 5");
        out.println("<table><tr><th>Transit Line</th><th>Total Reservations</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("line_name") + "</td><td>" + rs.getInt("total_reservations") + "</td></tr>");
        }
        out.println("</table>");

    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<form action="adminDashboard.jsp" method="get">
    <button type="submit" style="margin-top: 30px; padding: 10px 20px; font-size: 16px;">
        Back to Admin Dashboard
    </button>
</form>

</body>
</html>

