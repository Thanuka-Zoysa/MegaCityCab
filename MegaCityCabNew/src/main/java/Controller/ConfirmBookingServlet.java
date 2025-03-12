package Controller;

import DAO.BookingDAO;
import Model.Booking;
import Utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ConfirmBookingServlet")
public class ConfirmBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String carId = request.getParameter("carId");
        String carModel = request.getParameter("carModel");
        String customerId = request.getParameter("customerId");
        String pickupTime = request.getParameter("pickup-time");
        String totalBill = request.getParameter("totalBill");

        // Validate if all necessary fields are filled out
        if (carId != null && carModel != null && customerId != null && pickupTime != null && totalBill != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Create a new booking object with carModel included
                Booking booking = new Booking(
                    Integer.parseInt(carId),
                    carModel,
                    Integer.parseInt(customerId),
                    pickupTime,
                    Double.parseDouble(totalBill)
                );

                // Save the booking to the database
                BookingDAO bookingDAO = new BookingDAO(conn);
                bookingDAO.saveBooking(booking);

                // Redirect to customer dashboard after successful booking
                response.sendRedirect("booking.jsp");

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("BookingConfirmation.jsp?error=Database Error");
            }
        } else {
            response.sendRedirect("BookingConfirmation.jsp?error=Missing Parameters");
        }
    }
}
