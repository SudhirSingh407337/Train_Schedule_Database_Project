<%@ page import="java.sql.*" session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String question = request.getParameter("question_text");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

        String sql = "INSERT INTO Customer_Question (customer_id, question_text, question_date) VALUES (?, ?, NOW())";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        stmt.setString(2, question);
        stmt.executeUpdate();
        response.sendRedirect("dashboard.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
