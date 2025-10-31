package dal;

import java.sql.*;
import java.util.*;
import model.*;

public class CategoryDAO extends DBContext {

    public List<Category> getCategoriesbyUserId(int userId) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT category_id, category_name, user_id FROM Categories where user_id = ?";
        try {
            PreparedStatement stm = getConnection().prepareStatement(sql);
            stm.setInt(1, userId);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                list.add(new Category(rs.getInt("category_id"), rs.getString("category_name")));
            }
            System.out.println("CategoryDAO: loaded " + list.size() + " categories");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm các phương thức này vào file dal/CategoryDAO.java
    public void addCategory(int userId, String categoryName) throws SQLException {
        String sql = "INSERT INTO Categories (user_id, category_name) VALUES (?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, categoryName);
            ps.executeUpdate();
        }
    }

    public void updateCategory(int categoryId, String categoryName) throws SQLException {
        String sql = "UPDATE Categories SET category_name = ? WHERE category_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            ps.setInt(2, categoryId);
            ps.executeUpdate();
        }
    }

    public void deleteCategory(int categoryId) throws SQLException {
        // Câu lệnh SQL để xóa theo thứ tự: Cards -> Decks -> Categories
        String deleteCardsSQL = "DELETE FROM Cards WHERE deck_id IN (SELECT deck_id FROM Decks WHERE category_id = ?)";
        String deleteDecksSQL = "DELETE FROM Decks WHERE category_id = ?";
        String deleteCategorySQL = "DELETE FROM Categories WHERE category_id = ?";

        Connection conn = null;
        try {
            conn = getConnection();
            // Bắt đầu một Transaction: Đảm bảo tất cả các lệnh đều thành công, hoặc không lệnh nào thành công cả.
            conn.setAutoCommit(false);

            // Bước 1: Xóa tất cả các Cards trong các Decks thuộc Category này
            try (PreparedStatement psCards = conn.prepareStatement(deleteCardsSQL)) {
                psCards.setInt(1, categoryId);
                psCards.executeUpdate();
            }

            // Bước 2: Xóa tất cả các Decks thuộc Category này
            try (PreparedStatement psDecks = conn.prepareStatement(deleteDecksSQL)) {
                psDecks.setInt(1, categoryId);
                psDecks.executeUpdate();
            }

            // Bước 3: Cuối cùng, xóa chính Category đó
            try (PreparedStatement psCategory = conn.prepareStatement(deleteCategorySQL)) {
                psCategory.setInt(1, categoryId);
                psCategory.executeUpdate();
            }

            // Nếu tất cả thành công, xác nhận transaction
            conn.commit();

        } catch (SQLException e) {
            // Nếu có bất kỳ lỗi nào, hủy bỏ tất cả các thay đổi
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Log lỗi rollback
                }
            }
            e.printStackTrace(); // In ra lỗi gốc
            throw e; // Ném lại exception để servlet biết có lỗi
        } finally {
            // Luôn luôn trả lại trạng thái auto-commit và đóng kết nối
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

}
