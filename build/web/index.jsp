<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Traffic Management System</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        /* Body Styling with Dark Overlay on Background */
        body {
            background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                              url('https://images.unsplash.com/photo-1652793806995-7bf3265e40b0?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
        }

        /* Center Content */
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
            text-align: center;
        }

        /* Header Styling */
        h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 40px;
            color: #f8f9fa;
            text-shadow: 3px 3px 10px rgba(0, 0, 0, 0.8);
        }

        /* Stylish Button */
        .btn-primary {
            padding: 12px 30px;
            font-size: 20px;
            font-weight: bold;
            border: none;
            background-color: #ff6600;
            color: #fff;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(255, 102, 0, 0.4);
        }

        .btn-primary:hover {
            background-color: #e65c00;
            transform: translateY(-3px);
            box-shadow: 0 12px 24px rgba(255, 102, 0, 0.5);
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 32px;
            }

            .btn-primary {
                padding: 10px 20px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the Traffic Management System</h1>
        <a href="login.jsp" class="btn btn-primary">Login</a>
    </div>
</body>
</html>
