<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <link rel="stylesheet" href="CSS/register.css">
</head>
<body>
    <div class="register-container">
        <h2>Customer Registration</h2>
        
        <form action="RegisterServlet" method="post">
            <div class="input-group">
                <input type="text" name="name" placeholder="Full Name" required>
                <input type="email" name="email" placeholder="Email Address" required>
            </div>
            <div class="input-group">
                <input type="text" name="address" placeholder="Address" required>
                <input type="text" name="phone" placeholder="Phone Number" required>
            </div>
            <div class="input-group">
                <input type="text" name="nic" placeholder="NIC Number" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <p class="error-message"><%= request.getParameter("error") %></p>
            <% } %>

            <button type="submit">Register</button>
        </form>
        <p class="login-link">Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
