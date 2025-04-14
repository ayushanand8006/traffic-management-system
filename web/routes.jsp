<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Route List</title>
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1742415105826-0d588fa879b9?q=80&w=701&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            margin: 0;
            font-family: 'Arial', sans-serif;
            color: black;
        }

        h2, h3 {
            text-align: center;
            color: #4CAF50;
        }

        form {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        input[type="text"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .dashboard-btn {
            background: #3498db;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .dashboard-btn:hover {
            background: #2980b9;
            transform: scale(1.05);
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }

        .route-list {
            width: 60%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .route-item {
            padding: 10px;
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .route-item:last-child {
            border-bottom: none;
        }

        .delete-link {
            background-color: #e74c3c;
            color: white;
            padding: 6px 10px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .delete-link:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <h2>Route Management</h2>
    <form action="AddRouteServlet" method="post">
        <label for="route_name">Route Name:</label><br/>
        <input type="text" id="route_name" name="route_name" required /><br/>

        <label for="source">Source:</label><br/>
        <input type="text" id="source" name="source" required /><br/>

        <label for="destination">Destination:</label><br/>
        <input type="text" id="destination" name="destination" required /><br/>

        <input type="submit" value="Add Route" />
    </form>

    <h3>Existing Routes:</h3>
    <div class="route-list">
    <%
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/traffic_monitoring";
            String username = "root";
            String password = "root";
            Class.forName("com.mysql.jdbc.Driver"); // or com.mysql.cj.jdbc.Driver
            con = DriverManager.getConnection(url, username, password);
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM routes");

            while (rs.next()) {
                int id = rs.getInt("route_id");
                String name = rs.getString("route_name");
                String src = rs.getString("source");
                String dst = rs.getString("destination");

    %>
        <div class='route-item'>
            <div><strong><%= name %></strong> ? <%= src %> to <%= dst %></div>
            <a href="DeleteRouteServlet?route_id=<%= id %>" class="delete-link" onclick="return confirm('Delete this route?');">Delete</a>
        </div>
    <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error fetching routes.</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    </div>

    <!-- Dashboard Button -->
    <div style="text-align:center;">
        <a href="dashboard.jsp" class="dashboard-btn">Go to Dashboard</a>
    </div>
</body>
</html>
