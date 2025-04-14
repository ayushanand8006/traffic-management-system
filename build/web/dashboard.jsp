<%@ page language="java" %>
<%
String admin = (String)session.getAttribute("admin");
if(admin == null) {
    response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1738130399737-f39ef0637ddc?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            font-family: 'Arial', sans-serif;
            color: white;
        }

        h1 {
            text-align: center;
            color: #28a745;
            margin-top: 20px;
            font-size: 2.5rem;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
        }

        .card-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 40px;
        }

        .card {
            width: 18rem;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.3);
        }

        .card-body {
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            border-radius: 10px;
            padding: 20px;
        }

        .card-title {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: #28a745;
            font-weight: bold;
        }

        .btn-card {
            background-color: #28a745;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1rem;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-card:hover {
            background-color: #218838;
            transform: scale(1.05);
        }

        .btn-logout {
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1rem;
            margin-top: 20px;
            display: block;
            text-decoration: none;
            text-align: center;
            width: 200px;
            margin: 30px auto;
        }

        .btn-logout:hover {
            background-color: #c82333;
        }

        footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            text-align: center;
            padding: 10px 0;
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
        }

        footer a {
            color: #28a745;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <h1>Welcome Admin: <%= admin %></h1>

    <!-- Card Container -->
    <div class="card-container">
        <!-- Manage Routes -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Manage Routes</h5>
                <a href="view_routes.jsp" class="btn-card">Go to Routes</a>
            </div>
        </div>

        <!-- Traffic Police -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Traffic Police</h5>
                <a href="police.jsp" class="btn-card">Manage Police</a>
            </div>
        </div>

        <!-- Violations -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Violations</h5>
                <a href="violations.jsp" class="btn-card">View Violations</a>
            </div>
        </div>

        <!-- Add User -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Add User</h5>
                <a href="add_user.jsp" class="btn-card">Add New User</a>
            </div>
        </div>
     <div style="text-align: center; margin-top: 10px;">
    <a href="profile.jsp" class="btn-card" style="margin-right: 10px;">Profile</a>
    <a href="logout.jsp" class="btn-card" style="background-color: #e74c3c;">Logout</a>
</div>

</div>

        
   

    
    <!-- Footer -->
    <footer>&copy; 2025 Traffic Management System | 
        <a href="#">Privacy Policy</a> | 
        <a href="#">Contact Us</a>
    </footer>
</body>
</html>
