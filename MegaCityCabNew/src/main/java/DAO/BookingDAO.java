package DAO;

import Model.Booking;
import Utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

  
    public void saveBooking(Booking booking) throws SQLException {
        String query = "INSERT INTO bookings (car_id, car_model, customer_id, pickup_time, total_bill) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, booking.getCarId());
            stmt.setString(2, booking.getCarModel()); 
            stmt.setInt(3, booking.getCustomerId());
            stmt.setString(4, booking.getPickupTime());
            stmt.setDouble(5, booking.getTotalBill());

            stmt.executeUpdate();
        }
    }

    
    public List<Booking> getBookingsByCustomerId(int customerId) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE customer_id = ? ORDER BY booking_date DESC";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getInt("car_id"),
                    rs.getString("car_model"),
                    rs.getInt("customer_id"),
                    rs.getString("pickup_time"),
                    rs.getDouble("total_bill")
                );
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                bookings.add(booking);
            }
        }
        return bookings;
    }
    

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings ORDER BY booking_date DESC";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getInt("car_id"),
                    rs.getString("car_model"),
                    rs.getInt("customer_id"),
                    rs.getString("pickup_time"),
                    rs.getDouble("total_bill")
                );
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                bookings.add(booking);
            }
        }
        return bookings;
    }
    public boolean updateBooking(int bookingId, String carModel, int customerId, String pickupTime, double totalBill) throws SQLException {
        String query = "UPDATE bookings SET car_model = ?, customer_id = ?, pickup_time = ?, total_bill = ? WHERE booking_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, carModel);
            stmt.setInt(2, customerId);
            stmt.setString(3, pickupTime);
            stmt.setDouble(4, totalBill);
            stmt.setInt(5, bookingId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }
    public boolean deleteBooking(int bookingId) throws SQLException {
        String query = "DELETE FROM bookings WHERE booking_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }

 
    public boolean updateBooking(int bookingId, String pickupTime) throws SQLException {
        String query = "UPDATE bookings SET pickup_time = ? WHERE booking_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, pickupTime);
            stmt.setInt(2, bookingId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }

}
