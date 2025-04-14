<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Routes</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #74ebd5, #9face6);
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-top: 50px;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 15px;
            text-align: center;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }

        a:hover {
            color: #21618c;
        }

        .action-links {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .action-links a {
            background-color: #3498db;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            font-size: 14px;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .action-links a:hover {
            background-color: #2980b9;
        }

        .add-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #4CAF50;
            font-size: 16px;
            font-weight: bold;
        }

        .add-link:hover {
            color: #388e3c;
        }
    </style>
</head>
<body>
    <h2>All Routes</h2>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Source</th><th>Destination</th><th>Actions</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM routes");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("route_id") %></td>
            <td><%= rs.getString("route_name") %></td>
            <td><%= rs.getString("source") %></td>
            <td><%= rs.getString("destination") %></td>
            <td class="action-links">
                <a href="edit_route.jsp?id=<%= rs.getInt("route_id") %>">Edit</a> | 
<a href="DeleteRouteServlet?route_id=<%= rs.getInt("route_id") %>">Delete</a>
            </td>
        </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
    <a href="add_route.jsp" class="add-link">Add New Route</a>
</body>
</html>
