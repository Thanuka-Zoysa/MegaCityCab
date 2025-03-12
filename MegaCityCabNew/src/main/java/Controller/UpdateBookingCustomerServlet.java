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

@WebServlet("/UpdateBookingCustomerServlet")
public class UpdateBookingCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String pickupTime = request.getParameter("pickupTime");

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            boolean updated = bookingDAO.updateBooking(bookingId, pickupTime);

            if (updated) {
                response.sendRedirect("view_booking.jsp?message=Booking updated successfully");
            } else {
                response.sendRedirect("view_booking.jsp?error=Failed to update booking");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("view_booking.jsp?error=Database error");
        }
    }
}
