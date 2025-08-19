<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Q&amp;A</title>
</head>
<body>
    <h2>Search Questions</h2>
    <form method="get" action="searchQA.jsp">
        <input type="text" name="keyword" placeholder="Enter keyword..." required>
        <button type="submit">Search</button>
    </form>

<%
    String keyword = request.getParameter("keyword");
    if (keyword != null && !keyword.trim().isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

            String sql = "SELECT cq.question_text, cq.reply_text, cq.question_date, cq.reply_date, c.first_name, c.last_name FROM Customer_Questions cq JOIN Customer c ON cq.customer_id = c.customer_id WHERE cq.question_text LIKE ? OR cq.reply_text LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
%>
    <h3>Results for "<%= keyword %>":</h3>
    <table border="1">
        <tr>
            <th>Customer</th>
            <th>Question</th>
            <th>Asked On</th>
            <th>Reply</th>
            <th>Reply Date</th>
        </tr>
<%
            boolean found = false;
            while (rs.next()) {
                found = true;
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
        if (!found) {
%>
        <tr><td colspan="5">No results found.</td></tr>
<%
        }
%>
    </table> 

<%
        rs.close(); ps.close(); conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
}
%>

<form action="dashboard.jsp" style="margin-top: 20px;">
    <button type="submit">⬅ Back to Dashboard</button>
</form>


</body>
</html>


