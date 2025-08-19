<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit Answer</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 40px; }
        .container { background-color: #fff; padding: 30px; max-width: 600px; margin: auto; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); text-align: center; }
        .message { font-size: 18px; margin-bottom: 20px; }
        button { padding: 10px 20px; font-weight: bold; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
<div class="container">
<%
    int questionId = Integer.parseInt(request.getParameter("questionId"));
    String answer = request.getParameter("answer");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String sql = "UPDATE Customer_Questions SET reply_text = ?, reply_date = NOW() WHERE question_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, answer);
        stmt.setInt(2, questionId);

        int rows = stmt.executeUpdate();
        if (rows > 0) {
            out.println("<p class='message' style='color:green;'>Answer submitted successfully.</p>");
        } else {
            out.println("<p class='message' style='color:red;'>Failed to submit answer.</p>");
        }

        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p class='message' style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

    <form action="answerQuestion.jsp" method="get">
        <button type="submit">⬅ Back to Questions</button>
    </form>
</div>
</body>
</html>


