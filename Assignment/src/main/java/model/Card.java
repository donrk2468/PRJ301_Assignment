package model;
//
//import java.util.Date;

public class Card {
    private int cardId;
    private int deckId;
    private String frontContent;
    private String backContent;
    private String example;

    public Card() {}

    public Card(int cardId, int deckId, String frontContent, String backContent, String createdAt) {
        this.cardId = cardId;
        this.deckId = deckId;
        this.frontContent = frontContent;
        this.backContent = backContent;
        this.example = createdAt;
    }

    public Card(int deckId, String frontContent, String backContent, String example) {
        this.deckId = deckId;
        this.frontContent = frontContent;
        this.backContent = backContent;
        this.example = example;
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

    public String getExample() { return example; }
    public void setExample(String example) { this.example = example; }
}