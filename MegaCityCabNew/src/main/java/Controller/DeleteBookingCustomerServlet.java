package Controller;

import DAO.BookingDAO;
import Utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/DeleteBookingCustomerServlet")
public class DeleteBookingCustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            boolean deleted = bookingDAO.deleteBooking(bookingId);

            if (deleted) {
                response.sendRedirect("view_booking.jsp?message=Booking cancelled successfully");
            } else {
                response.sendRedirect("view_booking.jsp?error=Failed to cancel booking");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("view_booking.jsp?error=Database error");
        }
    }
}
