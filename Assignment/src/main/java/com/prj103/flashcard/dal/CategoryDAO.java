package com.prj103.flashcard.model;

import java.sql.*;
import java.util.*;

public class CategoryDAO extends DBContext {

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT category_id, category_name FROM Categories";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
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
