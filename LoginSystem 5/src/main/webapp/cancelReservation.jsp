<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("loggedIn") == null || !(Boolean)sessionObj.getAttribute("loggedIn")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) sessionObj.getAttribute("userId");
    String reservationIdStr = request.getParameter("reservation_id");

    if (reservationIdStr == null || reservationIdStr.trim().isEmpty()) {
        response.sendRedirect("myReservations.jsp?status=invalid");
        return;
    }

    int reservationId = Integer.parseInt(reservationIdStr);
    String url = "jdbc:mysql://localhost:3306/railwaydb";
    String dbUser = "root"; 
    String dbPass = ""; 

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPass);

        String checkSql = "SELECT * FROM Reservation WHERE reservation_id = ? AND customer_id = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setInt(1, reservationId);
        checkStmt.setInt(2, userId);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            String deleteSql = "DELETE FROM Reservation WHERE reservation_id = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
            deleteStmt.setInt(1, reservationId);
            deleteStmt.executeUpdate();
            response.sendRedirect("myReservations.jsp?status=cancelled");
        } else {
            response.sendRedirect("myReservations.jsp?status=unauthorized");
        }

        rs.close();
        checkStmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("myReservations.jsp?status=error");
    }
%>


