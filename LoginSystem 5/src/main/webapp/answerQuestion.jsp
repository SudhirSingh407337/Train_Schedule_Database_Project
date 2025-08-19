<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Answer Customer Questions</title>
    <style>
        body { font-family: Arial; padding: 20px; background-color: #f9f9f9; }
        .question-box {
            border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; border-radius: 5px; background: #fff;
        }
        textarea { width: 100%; height: 60px; }
        .submit-btn {
            background-color: #28a745; color: white; padding: 8px 15px; border: none;
            border-radius: 5px; cursor: pointer; margin-top: 10px;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h2>Unanswered Customer Questions</h2>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String sql = "SELECT question_id, question_text, question_date FROM Customer_Questions WHERE reply_text IS NULL ORDER BY question_date ASC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        boolean hasUnanswered = false;
        while (rs.next()) {
            hasUnanswered = true;
            int questionId = rs.getInt("question_id");
%>
    <div class="question-box">
        <p><strong>Q:</strong> <%= rs.getString("question_text") %></p>
        <p><em>Asked on:</em> <%= rs.getString("question_date") %></p>
        <form method="post" action="submitAnswer.jsp">
            <input type="hidden" name="questionId" value="<%= questionId %>">
            <label for="answer">Your Answer:</label><br>
            <textarea name="answer" required></textarea><br>
            <button type="submit" class="submit-btn">Submit Answer</button>
        </form>
    </div>
<%
        }

        if (!hasUnanswered) {
%>
    <p>No unanswered questions at the moment.</p>
<%
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

    <a class="back-btn" href="repDashboard.jsp">⬅ Back to Dashboard</a>
</body>
</html>

