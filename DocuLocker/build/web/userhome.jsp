<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DocuLocker - Your Secure Document Storage</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #007bff;
            color: #fff;
            padding: 10px 0;
            text-align: center;
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
        }
        header h1 {
            font-size: 24px;
            margin: 0;
        }
        .container {
            margin-top: 60px;
            text-align: center;
            padding: 20px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .feature {
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .feature:hover {
            background-color: #e6f0ff;
        }
        .feature h3 {
            color: #007bff;
            font-size: 20px;
        }
        .feature p {
            color: #555;
        }
        .message {
            color: #28a745;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .welcome-message {
            margin-bottom: 20px;
        }
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        footer p {
            margin: 0;
        }
    </style>
</head>
<body>
    <header>
        <h1>DocuLocker</h1>
    </header>
    
    <div class="container">
        <h1>User Home</h1>
        <c:if test="${not empty message}">
            <div class="message">
                <p>${message}</p>
            </div>
        </c:if>
        <div class="welcome-message">
            <p>Welcome, <span class="username">${sessionScope.email}</span>!</p>
            <p>You are now logged in.</p>
        </div>
        
        <h2>Your Secure Document Storage Solution</h2>
        <div class="feature" onclick="location.href='uploadServlet.jsp'">
            <h3>Store Documents Safely</h3>
            <p>Upload and store your important documents securely in the cloud.</p>
        </div>
        <div class="feature" onclick="location.href='AccessServlet'">
            <h3>Access Anytime, Anywhere</h3>
            <p>Access your documents from any device, wherever you are.</p>
        </div>
        <div class="feature" onclick="location.href='ShareServlet'">
            <h3>Share Easily</h3>
            <p>Share documents securely with others through encrypted links.</p>
        </div>
        
        <form action="logoutServlet" method="post">
            <button type="submit">Logout</button>
        </form>
    </div>
    
    <footer>
        <p>&copy; 2024 DocuLocker. All rights reserved.</p>
    </footer>
</body>
</html>
