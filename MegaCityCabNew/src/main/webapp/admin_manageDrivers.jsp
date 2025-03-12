<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, DAO.DriverDAO, Utils.DBConnection" %>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/admin_manageDrivers.css">
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
                       <a href="AdminBookingsServlet">
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
                       <a href="admin_manageDrivers.jsp" class="active">
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
                <h1>Manage Drivers</h1>
            </div>
            
            <div class="page-content">
            <section class="add-driver-form">
                    <form action="AdminDriverController" method="POST">
                        <label for="carId">Car ID: </label>
                        <input type="text" id="carId" name="carId" required><br>

                        <label for="fullName">Driver Full Name: </label>
                        <input type="text" id="fullName" name="fullName" required><br>

                        <label for="nic">NIC Number: </label>
                        <input type="text" id="nic" name="nic" required><br>

                        <label for="phone">Phone Number: </label>
                        <input type="text" id="phone" name="phone" required><br>

                        <label for="address">Address: </label>
                        <input type="text" id="address" name="address" required><br>

                        <label for="photo">Driver Photo URL: </label>
                        <input type="text" id="photo" name="photo" required><br>

                        <input type="submit" value="Add Driver" class="submit-btn">
                    </form>
                </section>

                <section class="driver-list">
                    <h3>Registered Drivers</h3>
                    <table>
                        <tr>
                        	<th>Driver Id</th>
                        	<th>Car Id</th>
                            <th>Driver Full Name</th>
                            <th>NIC</th>
                            <th>Phone Number</th>
                            <th>Address</th>
                            <th>Photo</th>
                            <th>Actions</th>
                        </tr>
                        <%
                            try {
                                Connection conn = DBConnection.getConnection();
                                DriverDAO driverDAO = new DriverDAO(conn);
                                ResultSet rs = driverDAO.getAllDrivers();
                                while (rs.next()) {
                        %>
                            <tr>
	                            <td><%= rs.getString("driver_id") %></td>
	                            <td><%= rs.getString("car_id") %></td>
                                <td><%= rs.getString("full_name") %></td>
                                <td><%= rs.getString("nic") %></td>
                                <td><%= rs.getString("phone") %></td>
                                <td><%= rs.getString("address") %></td>
                                <td><img src="<%= rs.getString("photo") %>" alt="Driver Image" class="driver-photo"></td>
                                <td class="action-buttons">
						            <!-- Update Button -->
						            <button class="update-btn" onclick="showUpdateForm(
						                <%= rs.getInt("driver_id") %>, 
						                <%= rs.getInt("car_id") %>, 
						                '<%= rs.getString("full_name") %>', 
						                '<%= rs.getString("nic") %>',
						                '<%= rs.getString("phone") %>',
						                '<%= rs.getString("address") %>',
						                '<%= rs.getString("photo") %>'
						            )">Edit</button>
						
						            <!-- Delete Button -->
						            <a href="DeleteDriverServlet?driverId=<%= rs.getInt("driver_id") %>" 
						               onclick="return confirm('Are you sure you want to delete this driver?');">
						                <button class="delete-btn">Delete</button>
						            </a>
						        </td>
                            </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </table>
                </section>
                
                <div id="update-driver-form" class="update-driver-form" style="display: none;">
				    <h2>Update Driver</h2>
				    <form action="UpdateDriverServlet" method="POST">
				        <input type="hidden" id="updateDriverId" name="driverId">
				        <input type="hidden" id="updateCarId" name="carId">
				        
				        <label for="updateFullName">Driver Full Name:</label>
				        <input type="text" id="updateFullName" name="fullName" required>
				
				        <label for="updateNic">NIC Number:</label>
				        <input type="text" id="updateNic" name="nic" required>
				
				        <label for="updatePhone">Phone Number:</label>
				        <input type="text" id="updatePhone" name="phone" required>
				
				        <label for="updateAddress">Address:</label>
				        <input type="text" id="updateAddress" name="address" required>
				
				        <label for="updatePhoto">Driver Photo URL:</label>
				        <input type="text" id="updatePhoto" name="photo" required>
				
				        <button type="submit">Update Driver</button>
				    </form>
				</div>
                
             </div>
            
           
                
        </main>
        
    </div>
			    <script>
				    function showUpdateForm(driverId, carId, fullName, nic, phone, address, photo) {
				        document.getElementById("updateDriverId").value = driverId;
				        document.getElementById("updateCarId").value = carId;
				        document.getElementById("updateFullName").value = fullName;
				        document.getElementById("updateNic").value = nic;
				        document.getElementById("updatePhone").value = phone;
				        document.getElementById("updateAddress").value = address;
				        document.getElementById("updatePhoto").value = photo;
				
				        document.getElementById("update-driver-form").style.display = "block";
				        window.scrollTo(0, document.getElementById("update-driver-form").offsetTop); // Scroll to the form
				    }
				</script>
    
</body>
</html>