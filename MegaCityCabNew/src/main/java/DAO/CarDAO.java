package DAO;

import Model.Car;
import Utils.DBConnection;

import java.sql.*;

public class CarDAO {

    private Connection conn;

    public CarDAO(Connection conn) {
        this.conn = conn;
    }

    // Method to add a new car
    public boolean addCar(Car car) {
        String query = "INSERT INTO cars (car_model, driver_name, driver_phone, car_photo, is_available, fee_per_km) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, car.getCarModel());
            stmt.setString(2, car.getDriverName());
            stmt.setString(3, car.getDriverPhone());
            stmt.setString(4, car.getCarPhoto());
            stmt.setBoolean(5, car.isAvailable());
            stmt.setDouble(6, car.getFeePerKm());  // Set the fee per km
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to retrieve all cars
    public ResultSet getAllCars() throws SQLException {
        String query = "SELECT * FROM cars";
        Statement stmt = conn.createStatement();
        return stmt.executeQuery(query);
    }
 // CarDAO.java
    public ResultSet getCarById(int carId) throws SQLException {
        String query = "SELECT * FROM cars WHERE car_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, carId);
        return stmt.executeQuery();
    }
    
 // Method to update car details
    public boolean updateCar(int carId, Car car) throws SQLException {
        String query = "UPDATE cars SET car_model=?, driver_name=?, driver_phone=?, car_photo=?, is_available=?, fee_per_km=? WHERE car_id=?";
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, car.getCarModel());
            stmt.setString(2, car.getDriverName());
            stmt.setString(3, car.getDriverPhone());
            stmt.setString(4, car.getCarPhoto());
            stmt.setBoolean(5, car.isAvailable());
            stmt.setDouble(6, car.getFeePerKm());
            stmt.setInt(7, carId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }
 // Method to delete a car
    public boolean deleteCar(int carId) throws SQLException {
        String query = "DELETE FROM cars WHERE car_id=?";
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, carId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }


}
