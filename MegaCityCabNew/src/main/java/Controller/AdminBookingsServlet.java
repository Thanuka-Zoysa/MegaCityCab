package Controller;

import DAO.BookingDAO;
import Model.Booking;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/AdminBookingsServlet")
public class AdminBookingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
        
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect("login.jsp?error=Access Denied");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
           
            BookingDAO bookingDAO = new BookingDAO(conn);

          
            List<Booking> bookings = bookingDAO.getAllBookings();

         
            request.setAttribute("bookings", bookings);

       
            request.getRequestDispatcher("admin_manageBookings.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=Database Error");
        }
    }
}
