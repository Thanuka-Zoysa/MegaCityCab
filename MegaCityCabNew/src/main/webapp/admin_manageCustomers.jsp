<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Model.Customer" %>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/admin_manageCustomers.css">
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
                       <a href="AdminCustomersServlet" class="active">
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
                        <a href="Home.jsp?message=Logout successful!"><span>Logout</span></a>
                    </div>
                </div>
            </div>
        </header>
        
        
        <main>
            
            <div class="page-header">
                <h1>Manage Customers</h1>
            </div>
            
            <div class="page-content">
            <h2>Registered Customers</h2>

            <% 
                List<Customer> customers = (List<Customer>) request.getAttribute("customers");

                if (customers != null && !customers.isEmpty()) { 
            %>
            <table>
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>NIC</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Customer customer : customers) 
                    	
                    	if (!customer.isAdmin()) { 
                    	%>
                    <tr>
                        <td><%= customer.getCustomerId() %></td>
                        <td><%= customer.getName() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getPhone() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td><%= customer.getNic() %></td>
                        <td><%= customer.isAdmin() ? "Admin" : "Customer" %></td>
                        <td class="action-buttons">
						 
						    <button class="update-btn" onclick="showUpdateForm(
						        <%= customer.getCustomerId() %>,
						        '<%= customer.getName() %>',
						        '<%= customer.getEmail() %>',
						        '<%= customer.getPhone() %>',
						        '<%= customer.getAddress() %>',
						        '<%= customer.getNic() %>'
						    )">Edit</button>
						
						  
						    <a href="DeleteCustomerServlet?customerId=<%= customer.getCustomerId() %>" 
						       onclick="return confirm('Are you sure you want to delete this customer?');">
						        <button class="delete-btn">Delete</button>
						    </a>
						</td>
                    </tr>
                    
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
                <p>No registered customers found.</p>
            <% } %>
            
            <div id="update-customer-form" class="update-customer-form" style="display: none;">
			    <h2>Update Customer</h2>
			    <form action="UpdateCustomerServlet" method="POST">
			        <input type="hidden" id="updateCustomerId" name="customerId">
			
			        <label for="updateName">Name:</label>
			        <input type="text" id="updateName" name="name" required>
			
			        <label for="updateEmail">Email:</label>
			        <input type="email" id="updateEmail" name="email" required>
			
			        <label for="updatePhone">Phone:</label>
			        <input type="text" id="updatePhone" name="phone" required>
			
			        <label for="updateAddress">Address:</label>
			        <input type="text" id="updateAddress" name="address" required>
			
			        <label for="updateNic">NIC:</label>
			        <input type="text" id="updateNic" name="nic" required>
			
			        <button type="submit">Update Customer</button>
			    </form>
			</div>


            
            </div>
                
        </main>
        
    </div>
		   <script>
			    function showUpdateForm(customerId, name, email, phone, address, nic) {
			        document.getElementById("updateCustomerId").value = customerId;
			        document.getElementById("updateName").value = name;
			        document.getElementById("updateEmail").value = email;
			        document.getElementById("updatePhone").value = phone;
			        document.getElementById("updateAddress").value = address;
			        document.getElementById("updateNic").value = nic;
			
			        document.getElementById("update-customer-form").style.display = "block";
			        window.scrollTo(0, document.getElementById("update-customer-form").offsetTop); 
			    }
			</script>


</body>
</html>