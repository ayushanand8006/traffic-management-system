<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Police Information</title>
    <style>
        /* Base Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-image: url('https://images.unsplash.com/photo-1608095476825-d4e0f916372f?q=80&w=1170&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        h2, h3 {
            margin: 20px 0;
            text-shadow: 1px 1px 4px #000;
        }

        /* Glassmorphism Form */
        form {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
        }
/* Dashboard Button */
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

        form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #ffffff;
        }

        form input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 10px;
            border: none;
            font-size: 1em;
            background: rgba(255, 255, 255, 0.85);
            color: #000;
        }

        form input[type="submit"] {
            background-color: #16a085;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        form input[type="submit"]:hover {
            background-color: #138f77;
            transform: scale(1.05);
        }

        /* Police List Styling */
        .police-list {
            width: 90%;
            max-width: 800px;
        }

        .police-item {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(6px);
            padding: 18px 25px;
            border-radius: 12px;
            margin-bottom: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
            transition: transform 0.3s ease;
        }

        .police-item:hover {
            transform: translateY(-5px);
        }

        .police-details {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 10px;
        }

        .officer-name {
            font-weight: bold;
            color: #fff;
            flex: 1 1 30%;
        }

        .officer-info {
            color: #ddd;
            flex: 1 1 30%;
        }

        @media screen and (max-width: 600px) {
            .police-details {
                flex-direction: column;
                gap: 6px;
            }
        }
    </style>
</head>
<body>
    <h2>Police Details</h2>

    <!-- Form to add a new police officer -->
    <form action="AddPoliceServlet" method="post">
        <label for="police_name">Officer Name:</label>
        <input type="text" id="police_name" name="police_name" required>

        <label for="ranks">Rank:</label>
        <input type="text" id="ranks" name="ranks" required>

        <label for="station">Station:</label>
        <input type="text" id="station" name="station" required>

        <input type="submit" value="Add Officer">
    </form>

    <h3>Existing Police Officers:</h3>
    <div class="police-list">
    <%
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/traffic_monitoring";
            String username = "root";
            String password = "root";

            con = DriverManager.getConnection(url, username, password);
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM police");

            while (rs.next()) {
                out.println("<div class='police-item'>" +
                                "<div class='police-details'>" +
                                    "<span class='officer-name'>" + rs.getString("police_name") + "</span>" +
                                    "<span class='officer-info'>Rank: " + rs.getString("ranks") + "</span>" +
                                    "<span class='officer-info'>Station: " + rs.getString("station") + "</span>" +
                                "</div>" +
                            "</div>");
            }

        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error fetching police details.</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (st != null) st.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
    %>
        <!-- Dashboard Button -->
    <a href="dashboard.jsp" class="dashboard-btn">Go to Dashboard</a>
    </div>
</body>
</html>
