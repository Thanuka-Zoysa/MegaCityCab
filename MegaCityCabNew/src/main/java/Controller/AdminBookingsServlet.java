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
        // Check if the user is an admin
        Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
        
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect("login.jsp?error=Access Denied");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Create the BookingDAO object to interact with the database
            BookingDAO bookingDAO = new BookingDAO(conn);

            // Get all bookings from the database
            List<Booking> bookings = bookingDAO.getAllBookings();

            // Set the bookings list in the request scope to be accessed in the JSP
            request.setAttribute("bookings", bookings);

            // Forward the request to the JSP page for displaying the bookings
            request.getRequestDispatcher("admin_manageBookings.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=Database Error");
        }
    }
}
