<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ask a Question</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 40px; }
        .container { background-color: #fff; padding: 30px; max-width: 700px; margin: auto; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        textarea { width: 100%; height: 150px; padding: 10px; font-size: 16px; }
        button { margin-top: 10px; padding: 10px 20px; font-weight: bold; background-color: #007bff; color: white; border: none; border-radius: 5px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Ask a Question</h2>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int customerId = (int) sessionObj.getAttribute("userId");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String question = request.getParameter("question");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");
            String sql = "INSERT INTO Customer_Questions (customer_id, question_text, question_date) VALUES (?, ?, NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setString(2, question);
            ps.executeUpdate();

            ps.close();
            conn.close();
            out.println("<p style='color:green;'>Question submitted successfully.</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

    <form method="post" action="askQuestion.jsp">
        <textarea name="question" placeholder="Type your question here..." required></textarea><br>
        <button type="submit">Submit Question</button>
    </form>
    <br>
    <form action="dashboard.jsp">
        <button type="submit">⬅ Back to Dashboard</button>
    </form>
</div>
</body>
</html>

