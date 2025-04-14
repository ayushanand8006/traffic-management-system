<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String route_name = "", source = "", destination = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM routes WHERE route_id = ?");
        pst.setInt(1, id);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            route_name = rs.getString("route_name");
            source = rs.getString("source");
            destination = rs.getString("destination");
        }
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Route</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #74ebd5, #9face6);
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 60px auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #444;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            margin-top: 25px;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .view-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .view-link:hover {
            color: #21618c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Route</h2>
        <form method="post" action="RouteServlet">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="route_id" value="<%= id %>">
            <label>Route Name:</label>
            <input type="text" name="route_name" value="<%= route_name %>" required>
            <label>Source:</label>
            <input type="text" name="source" value="<%= source %>" required>
            <label>Destination:</label>
            <input type="text" name="destination" value="<%= destination %>" required>
            <input type="submit" value="Update Route">
        </form>
    </div>
</body>
</html>
