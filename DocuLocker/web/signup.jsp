<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DocuLocker - Sign Up</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Reset and base styles */
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
        }
        /* Container styles */
        .container {
            text-align: center;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 90%;
            max-width: 400px;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        input {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .login-link {
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            transition: color 0.3s ease;
        }
        .login-link:hover {
            color: #0056b3;
        }
        /* Popup styles */
        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            display: none;
        }
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 900;
            display: none;
        }
        .show-popup {
            display: block !important;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Sign Up for DocuLocker</h1>
        <form action="SignUpServlet" method="POST">
            <input type="text" name="fullname" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirm_password" placeholder="Confirm Password" required>
            <button type="submit" class="btn">Sign Up</button>
        </form>
        <a href="login.jsp" class="login-link">Already have an account? Login here</a>
    </div>

    <%-- Popup message for successful registration --%>
    <div class="overlay" id="overlay"></div>
    <div class="popup" id="popup">
        <h2>Registration Complete!</h2>
        <p>You can now login.</p>
        <button onclick="hidePopup()">Close</button>
    </div>

    <script>
        // Function to show popup
        function showPopup() {
            document.getElementById('overlay').classList.add('show-popup');
            document.getElementById('popup').classList.add('show-popup');
        }

        // Function to hide popup
        function hidePopup() {
            document.getElementById('overlay').classList.remove('show-popup');
            document.getElementById('popup').classList.remove('show-popup');
        }

        // Check if registration success attribute is set and show popup
        <% if (request.getAttribute("registrationSuccess") != null && (boolean) request.getAttribute("registrationSuccess")) { %>
            showPopup();
        <% } %>
    </script>
</body>
</html>
