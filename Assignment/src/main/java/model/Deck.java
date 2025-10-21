package model;

public class Deck {
    private int deckId;
    private String deckName;
    private int categoryId;

    public Deck() {
    }

    public Deck(int deckId, String deckName, int categoryId) {
        this.deckId = deckId;
        this.deckName = deckName;
        this.categoryId = categoryId;
    }

    public int getDeckId() {
        return deckId;
    }

    public void setDeckId(int deckId) {
        this.deckId = deckId;
    }

    public String getDeckName() {
        return deckName;
    }

    public void setDeckName(String deckName) {
        this.deckName = deckName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
}
