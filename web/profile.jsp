<%@ page import="java.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%
    String admin = (String)session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("login.jsp");
    }

    String name = "";
    String email = "";
    String role = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username = ?");
        ps.setString(1, admin);
        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            role = rs.getString("role");
        }
        con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<html>
<head>
    <title>Admin Profile</title>
    <style>
        body {
            background-color: #1e272e;
            color: white;
            font-family: Arial;
            padding: 40px;
        }
        .profile-box {
            background: #2f3640;
            padding: 30px;
            border-radius: 10px;
            max-width: 500px;
            margin: auto;
        }
        .profile-box h2 {
            color: #1abc9c;
        }
        .profile-box p {
            margin: 10px 0;
        }
        a.button {
            display: inline-block;
            margin-top: 20px;
            background-color: #1abc9c;
            padding: 10px 20px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="profile-box">
        <h2>Admin Profile</h2>
        <p><strong>Username:</strong> <%= admin %></p>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Role:</strong> <%= role %></p>
        <a class="button" href="change_password.jsp">Change Password</a>
        <br/><br/>
        <a class="button" href="dashboard.jsp">? Back to Dashboard</a>
    </div>
</body>
</html>
