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

@WebServlet("/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String carModel = request.getParameter("carModel");
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String pickupTime = request.getParameter("pickupTime");
        double totalBill = Double.parseDouble(request.getParameter("totalBill"));

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);

            boolean success = bookingDAO.updateBooking(bookingId, carModel, customerId, pickupTime, totalBill);

            if (success) {
                response.sendRedirect("admin_manageBookings.jsp?message=Booking updated successfully");
            } else {
                response.sendRedirect("admin_manageBookings.jsp?error=Failed to update booking");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_manageBookings.jsp?error=Database error");
        }
    }
}
