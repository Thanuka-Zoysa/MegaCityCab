<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/admin_manageBookings.css">
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
                <h4>Admin Panel</h4>
            </div>

            <div class="side-menu">
                <ul>
                    <li>
                       <a href="admin_dashboard.jsp">
                            <span class="las la-home"></span>
                            <small>Dashboard</small>
                        </a>
                    </li>
                    <li>
                       <a href="admin_profile.jsp">
                            <span class="las la-user-alt"></span>
                            <small>Profile</small>
                        </a>
                    </li>
                    <li>
                       <a href="admin_manageRentCars.jsp">
                            <span class="las la-taxi"></span>
                            <small>Manage Rent Cars</small>
                        </a>
                    </li>
                    <li>
                       <a href="AdminBookingsServlet"  class="active">
                            <span class="las la-clipboard-list"></span>
                            <small>Manage Bookings</small>
                        </a>
                    </li>
                    
                    <li>
                       <a href="AdminCustomersServlet">
                            <span class="las la-user-cog"></span>
                            <small>Manage Customers</small>
                        </a>
                    </li>
                    
                    <li>
                       <a href="admin_manageDrivers.jsp">
                            <span class="las la-user-tie"></span>
                            <small>Manage Drivers</small>
                        </a>
                    </li>
                    <li>
                       <a href="admin_viewMessage.jsp">
                            <span class="las la-envelope"></span>
                            <small>View Messages</small>
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
                        <a href="Home.jsp"><span>Logout</span></a>
                    </div>
                </div>
            </div>
        </header>
        
        
        <main>
            
            <div class="page-header">
                <h1>Manage Bookings</h1>
            </div>
            
            <div class="page-content">
            <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Car Model - N/P</th>
                <th>Customer ID</th>
                <th>Pickup Time</th>
                <th>Total Bill</th>
                <th>Booking Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Loop through the bookings list and display them -->
            <c:forEach var="booking" items="${bookings}">
                <tr>
                    <td>${booking.bookingId}</td>
                    <td>${booking.carModel}</td>
                    <td>${booking.customerId}</td>
                    <td>${booking.pickupTime}</td>
                    <td>RS.${booking.totalBill}</td>
                    <td>${booking.bookingDate}</td>
					<td class="action-buttons">
					    <!-- Update Button -->
					    <button class="update-btn" onclick="showUpdateForm(${booking.bookingId}, '${booking.carModel}', ${booking.customerId}, '${booking.pickupTime}', ${booking.totalBill})">
					        Edit
					    </button>
					    <!-- Delete Button -->
					    <a href="DeleteBookingServlet?bookingId=${booking.bookingId}" onclick="return confirm('Are you sure you want to delete this booking?');">
					        <button class="delete-btn">Delete</button>
					    </a>
					</td>


		    

                </tr>
            </c:forEach>
        </tbody>
    </table>
		    <div id="update-booking-form" class="update-booking-form" style="display: none;">
			    <h2>Update Booking</h2>
			    <form action="UpdateBookingServlet" method="POST">
			        <input type="hidden" id="updateBookingId" name="bookingId">
			
			        <label for="updateCarModel">Car Model:</label>
			        <input type="text" id="updateCarModel" name="carModel" required>
			
			        <label for="updateCustomerId">Customer ID:</label>
			        <input type="text" id="updateCustomerId" name="customerId" required>
			
			        <label for="updatePickupTime">Pickup Time:</label>
			        <input type="datetime-local" id="updatePickupTime" name="pickupTime" required>
			
			        <label for="updateTotalBill">Total Bill:</label>
			        <input type="text" id="updateTotalBill" name="totalBill" required>
			
			        <button type="submit">Update Booking</button>
			    </form>
			</div>

		    
            </div>
                
        </main>
        
    </div>
		    <script>
			    function showUpdateForm(bookingId, carModel, customerId, pickupTime, totalBill) {
			        document.getElementById("updateBookingId").value = bookingId;
			        document.getElementById("updateCarModel").value = carModel;
			        document.getElementById("updateCustomerId").value = customerId;
			        document.getElementById("updatePickupTime").value = pickupTime;
			        document.getElementById("updateTotalBill").value = totalBill;
			
			        document.getElementById("update-booking-form").style.display = "block";
			        window.scrollTo(0, document.getElementById("update-booking-form").offsetTop); // Scroll to the form
			    }
			</script>

    
</body>
</html>