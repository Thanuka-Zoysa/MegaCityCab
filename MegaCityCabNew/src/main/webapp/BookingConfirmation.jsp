<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, DAO.BookingDAO, Utils.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <link rel="stylesheet" href="CSS/Confirmation.css">
</head>
<body>
    <div class="confirmation-container">
        <h2>Booking Confirmation</h2>

        <%
          
            String carId = request.getParameter("carId");
        	String carModel = request.getParameter("carModel");
            String customerId = request.getParameter("customerId");
            String distance = request.getParameter("distance");
            String fee = request.getParameter("fee");

           
            double totalBill = 0.0;

            
            if (carId != null && carModel != null && customerId != null && distance != null && fee != null) {
                try {
                   
                    distance = distance.replace(" km", "").trim();
                    double feeValue = Double.parseDouble(fee);
                    double distanceValue = Double.parseDouble(distance);
                    totalBill = feeValue * distanceValue; 
                } catch (NumberFormatException e) {
              
                    totalBill = 0.0;
                    out.println("<p>Error: Invalid fee or distance values. Please check your inputs.</p>");
                }
        %>

        <form action="ConfirmBookingServlet" method="POST">
            
            <p><strong>Car ID:</strong> <%= carId %></p>
            <p><strong>Car Model:</strong> <%= carModel %></p>
            <p><strong>Customer ID:</strong> <%= customerId %></p>
            <p><strong>Distance:</strong> <%= distance %></p>
            <p><strong>Fee per km:</strong> <%= fee %></p>
            <p><strong>Total Bill:</strong> <%= totalBill %></p>

            <!-- Pickup Time Input -->
            <label for="pickup-time">Enter Pickup Time:</label>
            <input type="datetime-local" id="pickup-time" name="pickup-time" required>

            <input type="hidden" name="carId" value="<%= carId %>">
            <input type="hidden" name="carModel" value="<%= carModel %>">
            <input type="hidden" name="customerId" value="<%= customerId %>">
            <input type="hidden" name="distance" value="<%= distance %>">
            <input type="hidden" name="fee" value="<%= fee %>">
            <input type="hidden" name="totalBill" value="<%= totalBill %>">

            <button type="submit">Confirm Booking</button>
        </form>

        <%
            } else {
                out.println("<p>Error: Missing booking details!</p>");
            }
        %>
    </div>
</body>
</html>
