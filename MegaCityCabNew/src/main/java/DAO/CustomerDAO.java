package DAO;

import Model.Customer;
import Utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private Connection conn;

   
    public CustomerDAO(Connection conn) {
        this.conn = conn;
    }

  
    public boolean registerCustomer(Customer customer) throws SQLException {
        String checkQuery = "SELECT * FROM customers WHERE email = ? OR nic = ?";
        String insertQuery = "INSERT INTO customers (name, email, address, phone, nic, password, is_admin) VALUES (?, ?, ?, ?, ?, ?, ?)";

       
        PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
        checkStmt.setString(1, customer.getEmail());
        checkStmt.setString(2, customer.getNic());
        ResultSet rs = checkStmt.executeQuery();
        if (rs.next()) {
            return false; 
        }

       
        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setString(1, customer.getName());
        insertStmt.setString(2, customer.getEmail());
        insertStmt.setString(3, customer.getAddress());
        insertStmt.setString(4, customer.getPhone());
        insertStmt.setString(5, customer.getNic());
        insertStmt.setString(6, customer.getPassword());
        insertStmt.setBoolean(7, customer.isAdmin()); 
        insertStmt.executeUpdate();
        return true;
    }

    
    public Customer authenticateCustomer(String email, String password) throws SQLException {
        String query = "SELECT * FROM customers WHERE email = ? AND password = ?";

        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Customer customer = new Customer();
            customer.setCustomerId(rs.getInt("customer_id"));
            customer.setName(rs.getString("name"));
            customer.setEmail(rs.getString("email"));
            customer.setAddress(rs.getString("address"));
            customer.setPhone(rs.getString("phone"));
            customer.setNic(rs.getString("nic"));
            customer.setAdmin(rs.getBoolean("is_admin")); 
            return customer;
        }
        return null;
    }
    
  
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customers ORDER BY name ASC";
        System.out.println("Executing query: " + query); 

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                System.out.println("Fetched customer: " + rs.getString("name"));
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setAddress(rs.getString("address"));
                customer.setPhone(rs.getString("phone"));
                customer.setNic(rs.getString("nic"));
                customer.setAdmin(rs.getBoolean("is_admin"));
                customers.add(customer);
            }
        }
        System.out.println("Customers retrieved: " + customers.size());
        return customers;
    }
    public boolean updateCustomerProfile(int customerId, String name, String email, String phone, String address, String password) throws SQLException {
        String query = password.isEmpty() ? 
            "UPDATE customers SET name=?, email=?, phone=?, address=? WHERE customer_id=?" :
            "UPDATE customers SET name=?, email=?, phone=?, address=?, password=? WHERE customer_id=?";
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);

            if (!password.isEmpty()) {
                stmt.setString(5, password);
                stmt.setInt(6, customerId);
            } else {
                stmt.setInt(5, customerId);
            }

            return stmt.executeUpdate() > 0;
        }
    }

    public Customer getCustomerById(int customerId) throws SQLException {
        String query = "SELECT * FROM customers WHERE customer_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? authenticateCustomer(rs.getString("email"), rs.getString("password")) : null;
        }
    }

    public boolean updateCustomerDetails(int customerId, String name, String email, String phone, String address, String nic) throws SQLException {
        String query = "UPDATE customers SET name = ?, email = ?, phone = ?, address = ?, nic = ? WHERE customer_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.setString(5, nic);
            stmt.setInt(6, customerId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }
    public boolean deleteCustomer(int customerId) throws SQLException {
        String query = "DELETE FROM customers WHERE customer_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }

}



