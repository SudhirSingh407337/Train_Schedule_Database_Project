<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Authentication</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/railwaydb";
    String dbUsername = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // Try Customer login
        String sql = "SELECT * FROM Customer WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);
        rs = stmt.executeQuery();

        if (rs.next()) {
            HttpSession userSession = request.getSession();
            userSession.setAttribute("username", username);
            userSession.setAttribute("userId", rs.getInt("customer_id"));
            userSession.setAttribute("email", rs.getString("email"));
            userSession.setAttribute("role", "customer");
            userSession.setAttribute("loggedIn", true);
            response.sendRedirect("dashboard.jsp");
        } else {
            // Close previous statement
            rs.close();
            stmt.close();

            // Try Employee login
            sql = "SELECT * FROM Employee WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                HttpSession userSession = request.getSession();
                userSession.setAttribute("username", username);
                userSession.setAttribute("userId", rs.getString("employee_ssn"));
                userSession.setAttribute("email", "N/A");
                userSession.setAttribute("role", role);
                userSession.setAttribute("loggedIn", true);

                if ("admin".equals(role)) {
                    response.sendRedirect("adminDashboard.jsp");
                } else if ("rep".equals(role)) {
                    response.sendRedirect("repDashboard.jsp");
                } else {
                    out.println("<p style='color:red;'>Unknown role.</p>");
                }
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        }

    } catch (ClassNotFoundException e) {
        out.println("<h3>Error: MySQL JDBC Driver not found</h3>");
    } catch (SQLException e) {
        out.println("<h3>Database Error</h3>");
        out.println("<p>" + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
</body>
</html>


