package model;

import java.util.Date;

public class Card {
    private int cardId;
    private int deckId;
    private String frontContent;
    private String backContent;
    private Date createdAt;

    public Card() {}

    public Card(int cardId, int deckId, String frontContent, String backContent, Date createdAt) {
        this.cardId = cardId;
        this.deckId = deckId;
        this.frontContent = frontContent;
        this.backContent = backContent;
        this.createdAt = createdAt;
    }

    public Card(int deckId, String frontContent, String backContent) {
        this.deckId = deckId;
        this.frontContent = frontContent;
        this.backContent = backContent;
    }

    // Getters & setters
    public int getCardId() { return cardId; }
    public void setCardId(int cardId) { this.cardId = cardId; }

    public int getDeckId() { return deckId; }
    public void setDeckId(int deckId) { this.deckId = deckId; }

    public String getFrontContent() { return frontContent; }
    public void setFrontContent(String frontContent) { this.frontContent = frontContent; }

    public String getBackContent() { return backContent; }
    public void setBackContent(String backContent) { this.backContent = backContent; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}