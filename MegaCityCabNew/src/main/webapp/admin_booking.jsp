<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, DAO.CarDAO, Utils.DBConnection,Model.Customer" %>

<%
    // Retrieve customerId from request parameters
    String customerId = request.getParameter("customerId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/admin_booking.css">
</head>
<body>
    <div class="main-content">

        <main>
            
            <div class="page-header">
                <h1>Make a Booking</h1>
            </div>
            
            <div class="page-content">
            <section class="car-list">
            <h3>Available Cars</h3>
            <table>
                <tr>
                    <th>Car Model - N/P</th>
                    <th>Driver Name</th>
                    <th>Driver Phone</th>
                    <th>Fee per km</th> <!-- New Column -->
                    <th>Car Photo</th>
                    <th>Action</th>
                </tr>
                <%
                    try {
                        Connection conn = DBConnection.getConnection();
                        CarDAO carDAO = new CarDAO(conn);
                        ResultSet rs = carDAO.getAllCars();
                        while (rs.next()) {
                            if (rs.getBoolean("is_available")) {
                %>
                    <tr>
                        <td><%= rs.getString("car_model") %></td>
                        <td><%= rs.getString("driver_name") %></td>
                        <td><%= rs.getString("driver_phone") %></td>
                        <td><%= rs.getDouble("fee_per_km") %></td> <!-- Display Fee per km -->
                        <td><img src="<%= rs.getString("car_photo") %>" alt="Car Image" class="car-photo"></td>
                        <!-- When Book Now is clicked, pass carId and fee per km -->
                        <td><a href="admin_DistanceCalculate.jsp?carId=<%= rs.getInt("car_id") %>&carModel=<%= rs.getString("car_model") %>&fee=<%= rs.getDouble("fee_per_km") %>&customerId=<%= customerId %>">
                            <button class="book-btn">Book Now</button>
                        </a></td>
                    </tr>
                <%
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </section>
            </div>
                
        </main>
        
    </div>
</body>
</html>