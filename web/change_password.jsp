<%@ page import="java.sql.*" %>
<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
    }

    String message = "";

    if (request.getParameter("current") != null && request.getParameter("newpass") != null) {
        String current = request.getParameter("current");
        String newpass = request.getParameter("newpass");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");

            PreparedStatement ps = con.prepareStatement("SELECT password FROM users WHERE username=?");
            ps.setString(1, admin);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password");
                if (dbPass.equals(current)) {
                    PreparedStatement updatePs = con.prepareStatement("UPDATE users SET password=? WHERE username=?");
                    updatePs.setString(1, newpass);
                    updatePs.setString(2, admin);
                    int rows = updatePs.executeUpdate();
                    if (rows > 0) {
                        message = "Password updated successfully!";
                    } else {
                        message = "Update failed!";
                    }
                    updatePs.close();
                } else {
                    message = "Current password is incorrect!";
                }
            }
            ps.close();
            con.close();
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <style>
        body {
            background-color: #1e272e;
            color: white;
            font-family: Arial, sans-serif;
            padding: 50px;
            text-align: center;
        }
        form {
            display: inline-block;
            background: #2f3640;
            padding: 30px;
            border-radius: 10px;
        }
        input[type="password"] {
            padding: 10px;
            margin: 10px 0;
            width: 100%;
            border-radius: 5px;
            border: none;
            background: #404b58;
            color: white;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background: #1abc9c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .msg {
            margin-top: 20px;
            color: #f39c12;
        }
    </style>
</head>
<body>
    <h2>Change Password</h2>
    <form method="post" action="change_password.jsp">
        <input type="password" name="current" placeholder="Current Password" required><br>
        <input type="password" name="newpass" placeholder="New Password" required><br>
        <input type="submit" value="Update Password">
    </form>
    <div class="msg"><%= message %></div>
    <br><br>
    <a href="dashboard.jsp" style="color: #1abc9c;">? Back to Dashboard</a>
</body>
</html>
