<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, DAO.CarDAO, Utils.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/booking.css">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
</head>
<body>
   <input type="checkbox" id="menu-toggle">
    <div class="sidebar">
        <div class="side-header">
            <h3>Mega City Cab</h3>
        </div>
        
        <div class="side-content">
            <div class="profile">
                <div class="profile-img bg-img" style="background-image: url(Images/3.jpeg)"></div>
                <h4>Customer</h4>
            </div>

            <div class="side-menu">
                <ul>
                    <li>
                       <a href="dashboard.jsp" >
                            <span class="las la-home"></span>
                            <small>Dashboard</small>
                        </a>
                    </li>
                    <li>
                       <a href="profile.jsp">
                            <span class="las la-user-alt"></span>
                            <small>Profile</small>
                        </a>
                    </li>
             
                    <li>
                       <a href="booking.jsp"  class="active">
                            <span class="las la-clipboard-list"></span>
                            <small>Make a Booking</small>
                        </a>
                    </li>
                    <li>
                       <a href="ViewBookingsServlet">
                            <span class="las la-eye"></span>
                            <small>View Bookings</small>
                        </a>
                    </li>

                </ul>
            </div>
        </div>
    </div>
    
    <div class="main-content">
        
        <header>
            <div class="header-content">
                <label for="menu-toggle">
                    <span class="las la-bars"></span>
                </label>
                
                <div class="header-menu">
                    
                    
                    <div class="user">
                        <div class="bg-img"></div>
                        
                        <span class="las la-power-off"></span>
                        <a href="Home.jsp?message=Logout successful!"><span>Logout</span></a>
                    </div>
                </div>
            </div>
        </header>
        
        
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
                    <th>Fee per km</th> 
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
                        <td><%= rs.getDouble("fee_per_km") %></td> 
                        <td><img src="<%= rs.getString("car_photo") %>" alt="Car Image" class="car-photo"></td>
                       
                        <td><a href="DistanceCalculate.jsp?carId=<%= rs.getInt("car_id") %>&carModel=<%= rs.getString("car_model") %>&fee=<%= rs.getDouble("fee_per_km") %>">
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