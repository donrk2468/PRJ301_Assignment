package dal;

import model.Card;
import model.Deck;
import java.sql.*;
import java.util.*;

public class DeckDAO extends DBContext {

    public List<Deck> getDecksByCategory(int categoryId) {
        List<Deck> list = new ArrayList<>();
        String sql = "SELECT deck_id, deck_name, category_id FROM Decks WHERE category_id = ?";

        System.out.println("[DeckDAO] ▶ Querying decks for CategoryID = " + categoryId);

        try {
            if (getConnection() == null) {
                System.err.println("[DeckDAO] ❌ Database connection is NULL — check DBContext or SQL Server connection!");
                return list;
            }

            PreparedStatement stm = getConnection().prepareStatement(sql);
            stm.setInt(1, categoryId);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                int deckId = rs.getInt("deck_id");
                String deckName = rs.getString("deck_name");
                int catId = rs.getInt("category_id");

                System.out.println("[DeckDAO] ✅ Found deck: " + deckName + " (ID=" + deckId + ", Cat=" + catId + ")");
                list.add(new Deck(deckId, deckName, catId));
            }

            System.out.println("[DeckDAO] ✅ Total decks found: " + list.size());

        } catch (SQLException e) {
            System.err.println("[DeckDAO] ❌ SQL Error: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    public List<Card> getCardsByDeckId(int deckId) throws SQLException {
        List<Card> list = new ArrayList<>();
        String sql = "SELECT * FROM Cards WHERE deck_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deckId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Card c = new Card();
                c.setCardId(rs.getInt("card_id"));
                c.setFrontContent(rs.getString("front"));
                c.setBackContent(rs.getString("back"));
                c.setExample(rs.getString("example"));
                c.setDeckId(deckId);
                list.add(c);
            }
        }
        return list;
    }

    public void addDeck(int categoryId, String deckName) throws SQLException {
        String sql = "INSERT INTO Decks (category_id, deck_name, description) VALUES (?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setString(2, deckName);
            ps.setString(3, "Mô tả mặc định");
            ps.executeUpdate();
        }
    }

    public void updateDeck(int deckId, String deckName) throws SQLException {
        String sql = "UPDATE Decks SET deck_name = ? WHERE deck_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, deckName);
            ps.setInt(2, deckId);
            ps.executeUpdate();
        }
    }

    public void deleteDeck(int deckId) throws SQLException {
        String sql = "DELETE Decks WHERE deck_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deckId);
            ps.executeUpdate();
        }
    }

}
