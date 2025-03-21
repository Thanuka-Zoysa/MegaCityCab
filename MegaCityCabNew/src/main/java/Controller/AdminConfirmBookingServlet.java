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

@WebServlet("/AdminConfirmBookingServlet")
public class AdminConfirmBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
        String carId = request.getParameter("carId");
        String carModel = request.getParameter("carModel");
        String customerId = request.getParameter("customerId");
        String pickupTime = request.getParameter("pickup-time");
        String totalBill = request.getParameter("totalBill");

       
        if (carId != null && carModel != null && customerId != null && pickupTime != null && totalBill != null) {
            try (Connection conn = DBConnection.getConnection()) {
             
                Booking booking = new Booking(
                    Integer.parseInt(carId),
                    carModel,
                    Integer.parseInt(customerId),
                    pickupTime,
                    Double.parseDouble(totalBill)
                );

              
                BookingDAO bookingDAO = new BookingDAO(conn);
                bookingDAO.saveBooking(booking);

             
                response.sendRedirect("admin_manageBookings.jsp?message=Booking successfully");

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("admin_BookingConfirmation.jsp?error=Database Error");
            }
        } else {
            response.sendRedirect("admin_BookingConfirmation.jsp?error=Missing Parameters");
        }
    }
}
