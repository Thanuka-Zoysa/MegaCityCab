<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List, Model.Booking" %>
<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/view_booking.css">
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
                       <a href="dashboard.jsp">
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
                       <a href="booking.jsp">
                            <span class="las la-clipboard-list"></span>
                            <small>Make a Booking</small>
                        </a>
                    </li>
                    <li>
                       <a href="ViewBookingsServlet" class="active">
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
                <h1>View Bookings</h1>
            </div>
            
            <div class="page-content">
            <h2>My Bookings</h2>

        <% if (bookings != null && !bookings.isEmpty()) { %>
            <table>
                <tr>
                    <th>Booking ID</th>
                    <th>Car Model - N/P</th>
                    <th>Pickup Time</th>
                    <th>Total Bill</th>
                    <th>Booking Date</th>
                    <th>Actions</th>
                </tr>
                <% for (Booking booking : bookings) { %>
                    <tr>
                        <td><%= booking.getBookingId() %></td>
                        <td><%= booking.getCarModel() %></td>
                        <td><%= booking.getPickupTime() %></td>
                        <td>RS.<%= booking.getTotalBill() %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td class="action-buttons">
                            <!-- Update Button -->
                            <button class="update-btn" onclick="showUpdateForm(
                                <%= booking.getBookingId() %>, 
                                '<%= booking.getCarModel() %>', 
                                '<%= booking.getPickupTime() %>'
                            )">Edit</button>

                            <!-- Delete Button -->
                            <a href="DeleteBookingCustomerServlet?bookingId=<%= booking.getBookingId() %>" 
                               onclick="return confirm('Are you sure you want to delete this booking?');">
                               <button class="delete-btn">Cancel</button>
                            </a>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <p>You have no bookings yet.</p>
        <% } %>
        <!-- Update Form -->
        <div id="update-booking-form" class="update-booking-form" style="display: none;">
            <h2>Update Booking</h2>
            <form action="UpdateBookingCustomerServlet" method="POST">
                <input type="hidden" id="updateBookingId" name="bookingId">
                
                <label for="updatePickupTime">Pickup Time:</label>
                <input type="datetime-local" id="updatePickupTime" name="pickupTime" required>
                
                <button type="submit">Update Booking</button>
            </form>
        </div>
            </div>
                
        </main>
        
    </div>
    <script>
        function showUpdateForm(bookingId, carModel, pickupTime) {
            document.getElementById("updateBookingId").value = bookingId;
            document.getElementById("updatePickupTime").value = pickupTime;
            
            document.getElementById("update-booking-form").style.display = "block";
            window.scrollTo(0, document.getElementById("update-booking-form").offsetTop); // Scroll to the form
        }
    </script>
</body>
</html>