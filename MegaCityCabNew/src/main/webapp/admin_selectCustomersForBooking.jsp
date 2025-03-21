<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Model.Customer, Utils.DBConnection, DAO.CustomerDAO,java.util.List, java.sql.*, Model.Customer" %>

<%
    Connection conn = DBConnection.getConnection();
    CustomerDAO customerDAO = new CustomerDAO(conn);
    List<Customer> customers = customerDAO.getAllCustomers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/admin_selectCustomersForBooking.css">
</head>
<body>
    <div class="main-content">

        <main>
            
            <div class="page-header">
                <h1>Select Customer</h1>
            </div>
            
            <div class="page-content">
            <section class="car-list">
            <h3>Registered Customers</h3>
            <table>
                <tr>
                	<th>Customer Id</th>
			        <th>Name</th>
			        <th>Email</th>
			        <th>Phone</th>
			        <th>Actions</th>
			    </tr>
                
                    <% for (Customer customer : customers)
                    	if (!customer.isAdmin()){ %>
		        <tr>
		        	<td><%= customer.getCustomerId() %></td>
		            <td><%= customer.getName() %></td>
		            <td><%= customer.getEmail() %></td>
		            <td><%= customer.getPhone() %></td>
		            <td>
		              
		                <a href="admin_booking.jsp?customerId=<%= customer.getCustomerId() %>"><button class="book-btn">Select</button></a>
		            </td>
		        </tr>
		    <% } %>
            </table>
        </section>
            </div>
                
        </main>
        
    </div>
</body>
</html>
