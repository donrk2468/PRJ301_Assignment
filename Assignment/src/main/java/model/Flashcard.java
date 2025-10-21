package model;

public class Flashcard {
    private String word;
    private String _1stDef;
    private String _2ndDef;

    public Flashcard(String japaneseWord, String romaji, String vietnameseMeaning) {
        this.word = japaneseWord;
        this._1stDef = romaji;
        this._2ndDef = vietnameseMeaning;
    }

    // Getters and Setters
    public String getJapaneseWord() {
        return word;
    }

    public void setJapaneseWord(String japaneseWord) {
        this.word = japaneseWord;
    }

    public String getRomaji() {
        return _1stDef;
    }

    public void setRomaji(String romaji) {
        this._1stDef = romaji;
    }

    public String getVietnameseMeaning() {
        return _2ndDef;
    }

    public void setVietnameseMeaning(String vietnameseMeaning) {
        this._2ndDef = vietnameseMeaning;
    }
}