<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Q&amp;A</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 40px; }
        .container { background: white; padding: 30px; max-width: 900px; margin: auto; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #007bff; color: white; }
        h2 { text-align: center; }
        button { margin-top: 20px; padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 5px; }
    </style>
</head>
<body>
<div class="container">
    <h2>All Customer Questions</h2>
    <table>
        <tr>
            <th>Customer</th>
            <th>Question</th>
            <th>Asked On</th>
            <th>Reply</th>
            <th>Reply Date</th>
        </tr>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String sql = "SELECT cq.*, c.first_name, c.last_name FROM Customer_Questions cq JOIN Customer c ON cq.customer_id = c.customer_id ORDER BY cq.question_date DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
            <td><%= rs.getString("question_text") %></td>
            <td><%= rs.getString("question_date") %></td>
            <td><%= rs.getString("reply_text") == null ? "Pending" : rs.getString("reply_text") %></td>
            <td><%= rs.getString("reply_date") == null ? "-" : rs.getString("reply_date") %></td>
        </tr>
<%
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
    </table>

    <form action="dashboard.jsp" method="get">
        <button type="submit">⬅ Back to Dashboard</button>
    </form>
</div>
</body>
</html>


