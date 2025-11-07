package model;

public class Flashcard {
    private String word;
    private String romaji;
    private String viet;

    public Flashcard(String japaneseWord, String romaji, String vietnameseMeaning) {
        this.word = japaneseWord;
        this.romaji = romaji;
        this.viet = vietnameseMeaning;
    }

    // Getters and Setters
    public String getJapaneseWord() {
        return word;
    }

    public void setJapaneseWord(String japaneseWord) {
        this.word = japaneseWord;
    }

    public String getRomaji() {
        return romaji;
    }

    public void setRomaji(String romaji) {
        this.romaji = romaji;
    }

    public String getVietnameseMeaning() {
        return viet;
    }

    public void setVietnameseMeaning(String vietnameseMeaning) {
        this.viet = vietnameseMeaning;
    }
}