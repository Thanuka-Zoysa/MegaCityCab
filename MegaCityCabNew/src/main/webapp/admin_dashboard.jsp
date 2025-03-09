<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/admin_dashboard.css">
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
                       <a href="admin_dashboard.jsp" class="active">
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
                <h1>Dashboard</h1>
            </div>
            
            <div class="page-content">
            <div class="dashboard-welcome">
			 <p>Welcome to the <strong>Mega City Cab Admin Dashboard</strong>! From here, you can manage customer bookings, cars, drivers, and much more. Stay organized and manage your fleet effortlessly.</p>
			</div>
            
            </div>
                
        </main>
        
    </div>
    
</body>
</html>