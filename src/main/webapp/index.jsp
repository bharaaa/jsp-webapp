<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#loginForm").submit(function(event) {
                // Clear previous error messages
                $("#errorMessage").text("");

                // Perform validation
                var isValid = true;
                if ($("#userId").val().trim() === "") {
                    isValid = false;
                    $("#errorMessage").text("User ID is required.");
                }
                if ($("#password").val().trim() === "") {
                    isValid = false;
                    $("#errorMessage").text("Password is required.");
                }

                // If validation fails, prevent form submission
                if (!isValid) {
                    event.preventDefault();
                }
            });
        });
    </script>
    <style>
        body {
          font-family: Arial, sans-serif;
          margin: 20px;
        }
    </style>
</head>
<body>
    <h2>Login Page</h2>
    <form id="loginForm" action="http://localhost:8080/jsp-webapp-1.0/login" method="post">
        <div>
            <label for="userId">User ID:</label>
            <input type="text" id="userId" name="userId">
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password">
        </div>
        <div id="errorMessage" style="color: red;"></div>
        <div>
            <button type="submit">Login</button>
        </div>
    </form>
</body>
</html>
