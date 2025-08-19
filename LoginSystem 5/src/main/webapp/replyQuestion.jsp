<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reply to Customer Questions</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 40px; }
        .container { background-color: #fff; padding: 30px; max-width: 900px; margin: auto; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        textarea { width: 100%; height: 120px; padding: 10px; font-size: 15px; }
        button, input[type="submit"] { margin-top: 10px; padding: 8px 16px; font-weight: bold; background-color: #28a745; color: white; border: none; border-radius: 5px; }
        table { width: 100%; margin-top: 20px; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; }
        th { background-color: #007bff; color: white; }
    </style>
</head>
<body>
<div class="container">
    <h2>Reply to Customer Questions</h2>

<%
    String method = request.getMethod();
    if ("POST".equalsIgnoreCase(method)) {
        int questionId = Integer.parseInt(request.getParameter("question_id"));
        String replyText = request.getParameter("reply_text");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

            String sql = "UPDATE Customer_Questions SET reply_text=?, reply_date=NOW() WHERE question_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, replyText);
            ps.setInt(2, questionId);
            ps.executeUpdate();

            ps.close();
            conn.close();
            out.println("<p style='color:green;'>Reply submitted successfully.</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String sql = "SELECT cq.*, c.first_name, c.last_name FROM Customer_Questions cq JOIN Customer c ON cq.customer_id = c.customer_id WHERE cq.reply_text IS NULL";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        boolean hasUnanswered = false;
        while (rs.next()) {
            hasUnanswered = true;
%>
    <form method="post" action="replyQuestion.jsp">
        <table>
            <tr><th colspan="2">Question ID: <%= rs.getInt("question_id") %></th></tr>
            <tr><td><strong>Customer:</strong></td><td><%= rs.getString("first_name") + " " + rs.getString("last_name") %></td></tr>
            <tr><td><strong>Question:</strong></td><td><%= rs.getString("question_text") %></td></tr>
            <tr><td><strong>Date:</strong></td><td><%= rs.getString("question_date") %></td></tr>
            <tr><td><strong>Reply:</strong></td>
                <td>
                    <input type="hidden" name="question_id" value="<%= rs.getInt("question_id") %>">
                    <textarea name="reply_text" required></textarea>
                </td>
            </tr>
            <tr><td colspan="2" style="text-align:right;"><input type="submit" value="Submit Reply"></td></tr>
        </table>
        <br><br>
    </form>
<%
        }

        if (!hasUnanswered) {
%>
    <p>No pending questions to reply to.</p>
<%
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading questions: " + e.getMessage() + "</p>");
    }
%>

    <form action="dashboard.jsp">
        <button type="submit">⬅ Back to Dashboard</button>
    </form>
</div>
</body>
</html>
