<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customers by Transit Line and Date</title>
    <style>
        body { font-family: Arial; background-color: #f0f0f0; padding: 20px; }
        .container {
            background: #fff; padding: 20px; max-width: 700px; margin: auto;
            border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        select, input[type="date"], .btn {
            padding: 10px; width: 100%; margin-top: 10px;
            border-radius: 5px; border: 1px solid #ccc;
        }
        .btn {
            background-color: #007bff; color: white; border: none;
            cursor: pointer;
        }
        .btn:hover { background-color: #0056b3; }
        table {
            margin-top: 20px; width: 100%; border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc; padding: 10px; text-align: center;
        }
        th { background-color: #e0e0e0; }
        h3 { margin-top: 30px; }
    </style>
</head>
<body>
<div class="container">
    <h2>List Customers by Transit Line and Travel Date</h2>
    <form method="get" action="customersByLine.jsp">
        <label>Select Transit Line:</label>
        <select name="line_id" required>
            <option value="">-- Select Line --</option>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");
                    Statement stmt = conn.createStatement();
                    ResultSet lines = stmt.executeQuery("SELECT line_id, line_name FROM Transit_Line");
                    while (lines.next()) {
                        int currentId = lines.getInt("line_id");
                        String selected = request.getParameter("line_id") != null &&
                                          request.getParameter("line_id").equals(String.valueOf(currentId)) ? "selected" : "";
            %>
                <option value="<%= currentId %>" <%= selected %>><%= lines.getString("line_name") %></option>
            <%
                    }
                    lines.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<option disabled>Error loading lines</option>");
                }
            %>
        </select>

        <label>Select Travel Date:</label>
        <input type="date" name="travel_date" required value="<%= request.getParameter("travel_date") != null ? request.getParameter("travel_date") : "" %>" />

        <button type="submit" class="btn">Search</button>
    </form>

    <%
        String lineId = request.getParameter("line_id");
        String travelDate = request.getParameter("travel_date");
        String lineName = "";

        if (lineId != null && travelDate != null && !lineId.isEmpty() && !travelDate.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

                
                PreparedStatement nameStmt = conn.prepareStatement("SELECT line_name FROM Transit_Line WHERE line_id = ?");
                nameStmt.setInt(1, Integer.parseInt(lineId));
                ResultSet nameRs = nameStmt.executeQuery();
                if (nameRs.next()) {
                    lineName = nameRs.getString("line_name");
                }
                nameRs.close();
                nameStmt.close();

                String sql = "SELECT DISTINCT c.customer_id, c.first_name, c.last_name, c.email " +
                             "FROM Customer c " +
                             "JOIN Reservation r ON c.customer_id = r.customer_id " +
                             "JOIN Train_Schedule ts ON r.schedule_id = ts.schedule_id " +
                             "WHERE ts.line_id = ? AND DATE(ts.departure_datetime) = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(lineId));
                ps.setString(2, travelDate);
                ResultSet rs = ps.executeQuery();

                boolean hasResults = false;
    %>

    <h3>Results for "<%= lineName %>" on <%= travelDate %>:</h3>
    <table>
        <tr>
            <th>Customer ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
        <%
            while (rs.next()) {
                hasResults = true;
        %>
            <tr>
                <td><%= rs.getInt("customer_id") %></td>
                <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
                <td><%= rs.getString("email") %></td>
            </tr>
        <%
            }
            if (!hasResults) {
        %>
            <tr><td colspan="3">No customers found for selected line and date.</td></tr>
        <% } %>
    </table>
    <%
                rs.close();
                ps.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>

    <form action="repDashboard.jsp" style="margin-top: 20px;">
        <button type="submit" class="btn">⬅ Back to Dashboard</button>
    </form>
</div>
</body>
</html>


