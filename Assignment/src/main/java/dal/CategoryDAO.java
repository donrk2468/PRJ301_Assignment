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

}
