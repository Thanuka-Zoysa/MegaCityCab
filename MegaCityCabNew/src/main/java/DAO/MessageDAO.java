package DAO;

import Model.Message;
import Utils.DBConnection;

import java.sql.*;

public class MessageDAO {

    private Connection conn;

    public MessageDAO(Connection conn) {
        this.conn = conn;
    }

    // Method to save a message to the database
    public boolean saveMessage(Message message) throws SQLException {
        String query = "INSERT INTO messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, message.getName());
            stmt.setString(2, message.getEmail());
            stmt.setString(3, message.getSubject());
            stmt.setString(4, message.getMessage());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to retrieve all messages
    public ResultSet getAllMessages() throws SQLException {
        String query = "SELECT * FROM messages ORDER BY created_at DESC";
        Statement stmt = conn.createStatement();
        return stmt.executeQuery(query);
    }
    public boolean deleteMessage(int messageId) throws SQLException {
        String query = "DELETE FROM messages WHERE message_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, messageId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

}
