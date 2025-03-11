package Controller;

import DAO.BookingDAO;
import Model.Booking;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ViewBookingsServlet")
public class ViewBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            System.out.println("ERROR: customerId is NULL in session");
            response.sendRedirect("login.jsp?error=Please log in first");
            return;
        }

        System.out.println("Fetching bookings for customer ID: " + customerId);

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            List<Booking> bookings = bookingDAO.getBookingsByCustomerId(customerId);

            System.out.println("Bookings retrieved: " + bookings.size());

            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("view_booking.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

