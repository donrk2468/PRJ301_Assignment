package dal;

import model.User;
import java.sql.*;
import java.util.*;

public class UserDAO extends DBContext {

    public int userLogin(String email, String password) throws SQLException {
        int userId = 0; // null default
        try {
            if (getConnection() == null) {
                System.err.println("[UserDAO] ❌ Database connection is NULL — check DBContext or SQL Server connection!");
                return userId;
            }

            String sql = "SELECT * FROM Users WHERE email = ? and password = ?";
            try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("user_id");
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] ❌ SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        if (userId == 0) {
            System.out.println("[UserDAO] ❌ Login false");
        }
        return userId;
    }

    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT user_id, email, password, name FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setName(rs.getString("name"));
                    return user;
                }
            }
        }
        return null; // nếu không tìm thấy user
    }
    
    public boolean isEmailExisted(String email) throws SQLException {
        String sql = "SELECT email FROM Users WHERE email = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return false;
                }
            }
        }
        return true; // nếu không tìm thấy user
    }
    
    public User register(String email, String password, String name) throws SQLException {
        if (isEmailExisted(email)) {
            String sql = "INSERT INTO Users(email, password, name) VALUES(?, ?, ?)";
            try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                ps.setString(3, name);
                ps.executeUpdate();
            }
        }
        
        return null;
    }
}
