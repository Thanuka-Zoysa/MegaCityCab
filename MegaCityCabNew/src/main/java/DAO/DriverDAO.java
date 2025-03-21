package DAO;

import Model.Driver;
import Utils.DBConnection;

import java.sql.*;

public class DriverDAO {

    private Connection conn;

    public DriverDAO(Connection conn) {
        this.conn = conn;
    }

  
    public boolean addDriver(Driver driver) throws SQLException {
        String query = "INSERT INTO drivers (car_id, full_name, nic, phone, address, photo) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, driver.getCarId());
            stmt.setString(2, driver.getFullName());
            stmt.setString(3, driver.getNic());
            stmt.setString(4, driver.getPhone());
            stmt.setString(5, driver.getAddress());
            stmt.setString(6, driver.getPhoto());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

   
    public ResultSet getAllDrivers() throws SQLException {
        String query = "SELECT * FROM drivers";
        Statement stmt = conn.createStatement();
        return stmt.executeQuery(query);
    }
    public boolean updateDriver(Driver driver) throws SQLException {
        String query = "UPDATE drivers SET car_id = ?, full_name = ?, nic = ?, phone = ?, address = ?, photo = ? WHERE driver_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, driver.getCarId());
            stmt.setString(2, driver.getFullName());
            stmt.setString(3, driver.getNic());
            stmt.setString(4, driver.getPhone());
            stmt.setString(5, driver.getAddress());
            stmt.setString(6, driver.getPhoto());
            stmt.setInt(7, driver.getDriverId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }
    public boolean deleteDriver(int driverId) throws SQLException {
        String query = "DELETE FROM drivers WHERE driver_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }

}
