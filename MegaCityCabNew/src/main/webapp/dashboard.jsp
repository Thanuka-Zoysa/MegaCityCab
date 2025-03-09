<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Mega City Cab - Customer Dashboard</title>
    <link rel="stylesheet" href="CSS/dashboard.css">
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
                       <a href="dashboard.jsp" class="active">
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
			 <p>Welcome to your <strong>Mega City Cab</strong> dashboard! Here you can manage your profile, make new bookings, view past trips, and rent cars with ease. Enjoy the seamless service tailored just for you!</p>
			</div>
            
            </div>
                
        </main>
        
    </div>
</body>
</html>