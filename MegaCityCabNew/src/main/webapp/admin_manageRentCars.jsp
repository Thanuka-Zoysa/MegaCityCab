<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, DAO.CarDAO, Utils.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/admin_manageRentCars.css">
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
                       <a href="admin_manageRentCars.jsp"  class="active">
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
                <h1>Manage Rent Cars</h1>
            </div>

            <div class="page-content">
                <section class="add-car-form">
                    <form action="AdminCarController" method="POST">
                        <label for="carModel">Car Model - N/P: </label>
                        <input type="text" id="carModel" name="carModel" required><br>

                        <label for="driverName">Driver Name: </label>
                        <input type="text" id="driverName" name="driverName" required><br>

                        <label for="driverPhone">Driver Phone: </label>
                        <input type="text" id="driverPhone" name="driverPhone" required><br>
                        
                        <label for="feePerKm">Fee per km: </label>
                        <input type="text" id="feePerKm" name="feePerKm" required><br>

                        <label for="carPhoto">Car Photo URL: </label>
                        <input type="text" id="carPhoto" name="carPhoto" required><br>

                        <label for="isAvailable">Available: </label>
                        <input type="checkbox" id="isAvailable" name="isAvailable"><br>

                        <input type="submit" value="Add Car" class="submit-btn">
                    </form>
                </section>

                <section class="car-list">
                    <h3>Rental Cars</h3>
                    <table>
                        <tr>
                            <th>Car Id</th>
                            <th>Car Model - N/P</th>
                            <th>Driver Name</th>
                            <th>Driver Phone</th>
                            <th>Fee per km</th>
                            <th>Car Photo</th>
                            <th>Actions</th>
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
                                <td><%= rs.getString("car_id") %></td>
                                <td><%= rs.getString("car_model") %></td>
                                <td><%= rs.getString("driver_name") %></td>
                                <td><%= rs.getString("driver_phone") %></td>
                                <td><%= rs.getDouble("fee_per_km") %></td>
                                <td><img src="<%= rs.getString("car_photo") %>" alt="Car Image" class="car-photo"></td>
                                <td>
                                    <button class="update-btn" onclick="showUpdateForm(
                                        <%= rs.getInt("car_id") %>,
                                        '<%= rs.getString("car_model") %>',
                                        '<%= rs.getString("driver_name") %>',
                                        '<%= rs.getString("driver_phone") %>',
                                        <%= rs.getDouble("fee_per_km") %>,
                                        '<%= rs.getString("car_photo") %>',
                                        <%= rs.getBoolean("is_available") %>
                                    )">Edit</button>
									<a href = "DeleteCarServlet?carId=<%= rs.getInt("car_id") %>"
									onclick="return confirm('Are you sure you want to delete this car?');">
		                            <button class="delete-btn">
									   Delete
									</button>
									</a>

                                </td>
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

                <div id="update-car-form" class="update-car-form" style="display: none;">
                    <h2>Edit Car Details</h2>
                    <form action="UpdateCarServlet" method="POST">
                        <input type="hidden" id="updateCarId" name="carId">
                        
                        <label for="updateCarModel">Car Model - N/P:</label>
                        <input type="text" id="updateCarModel" name="carModel" required><br>
                        
                        <label for="updateDriverName">Driver Name:</label>
                        <input type="text" id="updateDriverName" name="driverName" required><br>
                        
                        <label for="updateDriverPhone">Driver Phone:</label>
                        <input type="text" id="updateDriverPhone" name="driverPhone" required><br>
                        
                        <label for="updateFeePerKm">Fee per km:</label>
                        <input type="text" id="updateFeePerKm" name="feePerKm" required><br>
                        
                        <label for="updateCarPhoto">Car Photo URL:</label>
                        <input type="text" id="updateCarPhoto" name="carPhoto" required><br>
                        
                        <label for="updateIsAvailable">Available:</label>
                        <input type="checkbox" id="updateIsAvailable" name="isAvailable"><br>
                    
                        <button type="submit">Update Car</button>
                    </form>
                </div>
            </div>
            
        </main>
    </div>

    <script>
        function showUpdateForm(carId, carModel, driverName, driverPhone, feePerKm, carPhoto, isAvailable) {
            document.getElementById("updateCarId").value = carId;
            document.getElementById("updateCarModel").value = carModel;
            document.getElementById("updateDriverName").value = driverName;
            document.getElementById("updateDriverPhone").value = driverPhone;
            document.getElementById("updateFeePerKm").value = feePerKm;
            document.getElementById("updateCarPhoto").value = carPhoto;
            document.getElementById("updateIsAvailable").checked = isAvailable;

            document.getElementById("update-car-form").style.display = "block";
            window.scrollTo(0, document.getElementById("update-car-form").offsetTop); // Scroll to the form
        }
    </script>

</body>
</html>
