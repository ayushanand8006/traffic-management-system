<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Traffic Violations</title>
    <style>
        /* General Styles */
        body {
            background-image: url('https://plus.unsplash.com/premium_photo-1675323088046-62bb4577849a?q=80&w=1170&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            margin: 0;
            font-family: 'Arial', sans-serif;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        h2, h3 {
            color: #fff;
            text-align: center;
            margin-bottom: 30px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
        }

        /* Form Styling */
        form {
            max-width: 600px;
            margin: 20px auto;
            padding: 30px;
            background: rgba(0, 0, 0, 0.6);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(10px);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #fff;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #444;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            font-size: 1.1em;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background: #1abc9c;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        input[type="submit"]:hover {
            background: #16a085;
            transform: scale(1.05);
        }

        /* Violations List */
        .violations-list {
            width: 90%;
            max-width: 800px;
            margin-top: 50px;
        }

        .violation-item {
            background: rgba(0, 0, 0, 0.6);
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.4);
            display: flex;
            justify-content: space-between;
            align-items: center;
            backdrop-filter: blur(10px);
        }

        .violation-item:nth-child(even) {
            background: rgba(0, 0, 0, 0.7);
        }

        .violation-details {
            color: #ecf0f1;
            font-size: 1em;
        }

        .penalty-amount {
            color: #e74c3c;
            font-weight: bold;
        }

        .action-links a {
            margin-right: 15px;
            color: #f1c40f;
            text-decoration: none;
            font-weight: bold;
        }

        .action-links a.delete {
            color: #e74c3c;
        }

        .action-links a:hover {
            text-decoration: underline;
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

        /* Error Message */
        .error-message {
            color: #e74c3c;
            text-align: center;
            padding: 10px;
            font-size: 1.2em;
            border: 1px solid #e74c3c;
            border-radius: 8px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Report Traffic Violation</h2>
    <form action="AddViolationServlet" method="post">
        <div class="form-group">
            <label for="vehicle_number">Vehicle Number:</label>
            <input type="text" id="vehicle_number" name="vehicle_number" required>
        </div>

        <div class="form-group">
            <label for="violation_type">Violation Type:</label>
            <input type="text" id="violation_type" name="violation_type" required>
        </div>

        <div class="form-group">
            <label for="penalty">Penalty (Rs):</label>
            <input type="number" id="penalty" name="penalty" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="police_id">Police ID:</label>
            <input type="number" id="police_id" name="police_id" required>
        </div>

        <input type="submit" value="Report Violation">
    </form>

    <h3>All Reported Violations:</h3>
    <div class="violations-list">
        <%
            String errorMessage = request.getParameter("error_message");
            if (errorMessage != null) {
                out.println("<div class='error-message'>" + errorMessage + "</div>");
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/traffic_monitoring", "root", "root");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM violations");

                while(rs.next()) {
                    int violationId = rs.getInt("violation_id");
                    out.println("<div class='violation-item'>" +
                                    "<div>" +
                                        "<div><strong>" + rs.getString("vehicle_number") + "</strong></div>" +
                                        "<div class='violation-details'>" + rs.getString("violation_type") + "</div>" +
                                    "</div>" +
                                    "<div>" +
                                        "<div class='penalty-amount'>Rs." + rs.getDouble("penalty") + "</div>" +
                                        "<div>Police ID: " + rs.getInt("police_id") + "</div>" +
                                        "<div class='action-links' style='margin-top: 10px;'>" +
                                            "<a href='/TMS/DeleteViolationServlet?id=" + violationId + "' class='delete' onclick=\"return confirm('Are you sure you want to delete this record?');\">Paid</a>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>");
                }

                rs.close();
                st.close();
                con.close();
            } catch(Exception e) {
                out.println("<p class='error-message'>Error retrieving violations: " + e.getMessage() + "</p>");
            }
        %>
    </div>

    <!-- Dashboard Button -->
    <a href="dashboard.jsp" class="dashboard-btn">Go to Dashboard</a>
</body>
</html>
