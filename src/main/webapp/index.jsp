<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: white;
        }
        .login-container {
            width: 300px;
            padding: 20px;
            background: #fff;
            border: 2px solid #000;
            border-radius: 5px;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .login-container label {
            font-weight: normal;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: calc(100% - 22px); /* Adjust for padding */
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .login-container #errorMessage {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: center;
        }
        .login-container button[type="submit"] {
            background-color: #a5a5a5;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }
        .login-container button[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        $(document).ready(function() {
            $("#loginForm").submit(function(event) {
                $("#errorMessage").text("");

                var userId = $("#userId").val().trim();
                var password = $("#password").val().trim();
                var isValid = true;

                if (userId === "") {
                    isValid = false;
                    $("#errorMessage").text("User ID is required.");
                }
                if (password === "") {
                    isValid = false;
                    $("#errorMessage").text("Password is required.");
                }

                if (!isValid) {
                    event.preventDefault();
                }
            });
        });
    </script>
</head>
<body>
    <div class="login-container">
        <form id="loginForm" action="http://localhost:8080/jsp-webapp-1.0/login" method="post">
            <div>
                <label for="userId">User ID:</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div id="errorMessage"></div>
            <div>
                <button type="submit">Login</button>
            </div>
        </form>
    </div>
</body>
</html>
