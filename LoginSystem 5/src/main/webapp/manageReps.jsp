<%@ page import="java.sql.*" %>
<%
    // Only allow access if logged in as admin
    if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Representatives</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 30px; }
        h2 { text-align: center; }
        form, table { background: white; padding: 20px; margin: 20px auto; border-radius: 10px; width: 80%; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        table { width: 90%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #eee; }
        input, select { padding: 5px; margin: 5px; }
        .actions form { display: inline; }
    </style>
</head>
<body>

<h2>Manage Customer Representatives</h2>

<form method="post" action="manageReps.jsp">
    <h3>Add New Representative</h3>
    SSN: <input type="text" name="ssn" required />
    First Name: <input type="text" name="firstName" required />
    Last Name: <input type="text" name="lastName" required />
    Username: <input type="text" name="username" required />
    Password: <input type="password" name="password" required />
    <input type="hidden" name="action" value="add" />
    <input type="submit" value="Add Representative" />
</form>

<%
    String action = request.getParameter("action");
    String ssn = request.getParameter("ssn");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaydb", "root", "");

    if ("add".equals(action)) {
        String first = request.getParameter("firstName");
        String last = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        PreparedStatement ps = conn.prepareStatement("INSERT INTO Employee (employee_ssn, first_name, last_name, username, password, role) VALUES (?, ?, ?, ?, ?, 'rep')");
        ps.setString(1, ssn);
        ps.setString(2, first);
        ps.setString(3, last);
        ps.setString(4, username);
        ps.setString(5, password);
        ps.executeUpdate();
        ps.close();
    } else if ("delete".equals(action)) {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM Employee WHERE employee_ssn = ?");
        ps.setString(1, ssn);
        ps.executeUpdate();
        ps.close();
    } else if ("edit".equals(action)) {
        String first = request.getParameter("firstName");
        String last = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        PreparedStatement ps = conn.prepareStatement("UPDATE Employee SET first_name=?, last_name=?, username=?, password=? WHERE employee_ssn=?");
        ps.setString(1, first);
        ps.setString(2, last);
        ps.setString(3, username);
        ps.setString(4, password);
        ps.setString(5, ssn);
        ps.executeUpdate();
        ps.close();
    }

    PreparedStatement ps = conn.prepareStatement("SELECT * FROM Employee WHERE role = 'rep'");
    ResultSet rs = ps.executeQuery();
%>
<table>
    <tr>
        <th>SSN</th>
        <th>Name</th>
        <th>Username</th>
        <th>Password</th>
        <th>Actions</th>
    </tr>
<%
    while (rs.next()) {
%>
    <tr>
    <td><%= rs.getString("employee_ssn") %></td>
    <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
    <td><%= rs.getString("username") %></td>
    <td><%= rs.getString("password") %></td>
    <td class="actions" style="display: flex; gap: 10px; justify-content: center; align-items: center;">
        <div>
            <form method="post" action="manageReps.jsp">
                <input type="hidden" name="ssn" value="<%= rs.getString("employee_ssn") %>" />
                <input type="hidden" name="action" value="edit" />
                <input type="text" name="firstName" value="<%= rs.getString("first_name") %>" style="width: 80px;" />
                <input type="text" name="lastName" value="<%= rs.getString("last_name") %>" style="width: 80px;" />
                <input type="text" name="username" value="<%= rs.getString("username") %>" style="width: 80px;" />
                <input type="text" name="password" value="<%= rs.getString("password") %>" style="width: 80px;" />
                <input type="submit" value="Save" />
            </form>
        </div>
        <div>
            <form method="post" action="manageReps.jsp" onsubmit="return confirm('Delete this representative?');">
                <input type="hidden" name="ssn" value="<%= rs.getString("employee_ssn") %>" />
                <input type="hidden" name="action" value="delete" />
                <input type="submit" value="Delete" />
            </form>
        </div>
    </td>
</tr>

<%
    }
    rs.close();
    ps.close();
    conn.close();
%>
</table>

<!-- Back Button -->
<div style="text-align:center; margin-top: 30px;">
    <a href="adminDashboard.jsp" style="
        display: inline-block;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: bold;
        transition: background-color 0.3s;
    " onmouseover="this.style.backgroundColor='#0056b3'" onmouseout="this.style.backgroundColor='#007bff'">
        Back to Admin Dashboard
    </a>
</div>

</body>
</html>








