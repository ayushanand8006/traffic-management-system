<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New User</title>
    <style>
        body {
            background: #1e272e;
            font-family: Arial, sans-serif;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }

        h2 {
            margin-bottom: 20px;
            color: #1abc9c;
        }

        form {
            background: rgba(0, 0, 0, 0.7);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.8);
            width: 100%;
            max-width: 500px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            border: none;
            background: #2f3640;
            color: #fff;
        }

        input[type="submit"] {
            background: #1abc9c;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        input[type="submit"]:hover {
            background: #16a085;
        }

        .message {
            margin-top: 20px;
            font-size: 1em;
        }

        .back-link {
            margin-top: 20px;
            color: #00cec9;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <h2>Add New User</h2>

    <form method="post" action="add_user.jsp">
        <div class="form-group">
            <label for="name">Full Name:</label>
            <input type="text" name="name" required>
        </div>

        <div class="form-group">
            <label for="email">Email Address:</label>
            <input type="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" name="username" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" name="password" required>
        </div>

        <div class="form-group">
            <label for="role">User Role:</label>
            <select name="role" required>
                <option value="Admin">Admin</option>
                <option value="Traffic Police">Traffic Police</option>
            </select>
        </div>

        <input type="submit" value="Add User">
    </form>

    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (name != null && email != null && username != null && password != null && role != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");

                String sql = "INSERT INTO users (name, email, username, password, role) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, email);
                pst.setString(3, username);  // ? Fixed line
                pst.setString(4, password);
                pst.setString(5, role);

                int rows = pst.executeUpdate();

                if (rows > 0) {
                    out.println("<div class='message' style='color: #2ecc71;'>? User added successfully!</div>");
                } else {
                    out.println("<div class='message' style='color: #e74c3c;'>? Failed to add user.</div>");
                }

                pst.close();
                con.close();
            } catch(Exception e) {
                out.println("<div class='message' style='color: #e74c3c;'>?? Error: " + e.getMessage() + "</div>");
            }
        }
    %>

    <a class="back-link" href="dashboard.jsp">? Back to Dashboard</a>

</body>
</html>
