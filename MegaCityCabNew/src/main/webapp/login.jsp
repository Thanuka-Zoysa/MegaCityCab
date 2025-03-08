<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mega City Cab</title>
    <link rel="stylesheet" href="CSS/login.css">
</head>
<body>
    <div class="login-container">
        <h2>Customer Login</h2>
        <form action="LoginServlet" method="post">
            <div class="input-group">
                <input type="email" name="email" placeholder="Email Address" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <p class="error-message"><%= request.getParameter("error") %></p>
            <% } %>
            <button type="submit">Login</button>
        </form>
        <p class="register-link">Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>
