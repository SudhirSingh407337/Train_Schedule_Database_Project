<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
  
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

    // JDBC setup
    String jdbcURL = "jdbc:mysql://localhost:3306/railwaydb";
    String dbUser = "root";
    String dbPassword = ""; 

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

       
        String checkSql = "SELECT COUNT(*) FROM Customer WHERE username = ?";
        stmt = conn.prepareStatement(checkSql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        rs.close();
        stmt.close();

        if (count > 0) {
            response.sendRedirect("register.jsp?error=exists");
            return;
        }

        
        String insertSql = "INSERT INTO Customer (username, password, email) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(insertSql);
        stmt.setString(1, username);
        stmt.setString(2, password); 
        stmt.setString(3, email);
        stmt.executeUpdate();

        
        response.sendRedirect("login.jsp?register=success");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("register.jsp?error=exception");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>
