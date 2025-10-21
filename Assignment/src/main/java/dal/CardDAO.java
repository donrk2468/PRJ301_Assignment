package dal;

import model.Card;
import model.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CardDAO {
    
    private final DBContext db;

    public CardDAO() {
        // Khởi tạo DBContext để gọi getConnection
        db = new DBContext();
    }

    public List<Card> getCardsByDeck(int deckId) {
        List<Card> list = new ArrayList<>();
        String sql = "SELECT card_id, deck_id, front_content, back_content, created_at FROM Cards WHERE deck_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deckId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int cardId = rs.getInt("card_id");
                    String front = rs.getString("front_content");
                    String back = rs.getString("back_content");
                    Timestamp ts = rs.getTimestamp("created_at");
                    Date created = ts != null ? new Date(ts.getTime()) : null;
                    list.add(new Card(cardId, deckId, front, back, created));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Card getCardById(int cardId) {
        String sql = "SELECT card_id, deck_id, front_content, back_content, created_at FROM Cards WHERE card_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cardId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int deckId = rs.getInt("deck_id");
                    String front = rs.getString("front_content");
                    String back = rs.getString("back_content");
                    Timestamp ts = rs.getTimestamp("created_at");
                    Date created = ts != null ? new Date(ts.getTime()) : null;
                    return new Card(cardId, deckId, front, back, created);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int insertCard(Card card) {
        String sql = "INSERT INTO Cards (deck_id, front_content, back_content, created_at) VALUES (?, ?, ?, GETDATE())";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, card.getDeckId());
            ps.setString(2, card.getFrontContent());
            ps.setString(3, card.getBackContent());
            int affected = ps.executeUpdate();
            if (affected == 0) return -1;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean updateCard(Card card) {
        String sql = "UPDATE Cards SET front_content = ?, back_content = ? WHERE card_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, card.getFrontContent());
            ps.setString(2, card.getBackContent());
            ps.setInt(3, card.getCardId());
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCard(int cardId) {
        String sql = "DELETE FROM Cards WHERE card_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cardId);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Card getRandomCardInDeck(int deckId) {
        String sql = "SELECT TOP 1 card_id, deck_id, front_content, back_content, created_at FROM Cards WHERE deck_id = ? ORDER BY NEWID()";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deckId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int cardId = rs.getInt("card_id");
                    String front = rs.getString("front_content");
                    String back = rs.getString("back_content");
                    Timestamp ts = rs.getTimestamp("created_at");
                    Date created = ts != null ? new Date(ts.getTime()) : null;
                    return new Card(cardId, deckId, front, back, created);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
