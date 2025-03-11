package Controller;

import DAO.BookingDAO;
import Utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            boolean success = bookingDAO.deleteBooking(bookingId);

            if (success) {
                response.sendRedirect("admin_manageBookings.jsp?message=Booking deleted successfully");
            } else {
                response.sendRedirect("admin_manageBookings.jsp?error=Failed to delete booking");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageBookings.jsp?error=Database error");
        }
    }
}
