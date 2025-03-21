<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Model.Customer" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/profile.css">
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
                       <a href="profile.jsp" class="active">
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
                <h1>Profile</h1>
            </div>
            
            <div class="page-content">
           <%
                Customer customer = (Customer) session.getAttribute("customer");
                if (customer != null) {
            %>
                <div class="customer-details">
                    <h2>Hello, <%= customer.getName() %>!</h2>
                    <p><strong>Email:</strong> <%= customer.getEmail() %></p>
                    <p><strong>Phone:</strong> <%= customer.getPhone() %></p>
                    <p><strong>Address:</strong> <%= customer.getAddress() %></p>
                    <p><strong>NIC:</strong> <%= customer.getNic() %></p>
                    <button onclick="toggleEditForm()">Edit Profile</button>
                </div>

              
                <div id="edit-profile-form" style="display: none;">
                    <form action="EditProfileServlet" method="POST">
                        <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                        
                        <label>Name:</label>
                        <input type="text" name="name" value="<%= customer.getName() %>" required>

                        <label>Email:</label>
                        <input type="email" name="email" value="<%= customer.getEmail() %>" required>

                        <label>Phone:</label>
                        <input type="text" name="phone" value="<%= customer.getPhone() %>" required>

                        <label>Address:</label>
                        <input type="text" name="address" value="<%= customer.getAddress() %>" required>

                        <label>Password (Leave blank to keep current password):</label>
                        <input type="password" name="password" placeholder="New Password">

                        <button type="submit">Update Profile</button>
                    </form>
            </div>
            <script>
                    function toggleEditForm() {
                        let form = document.getElementById("edit-profile-form");
                        form.style.display = (form.style.display === "none") ? "block" : "none";
                    }
                </script>

            <%
                } else {
                    response.sendRedirect("login.jsp");
                }
            %>
                
        </main>
        
    </div>
</body>
</html>