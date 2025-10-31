USE master;
GO

-- Xóa DB cũ nếu có
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'flashcard_db')
BEGIN
    ALTER DATABASE flashcard_db SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE flashcard_db;
END
GO

-- Tạo lại DB mới
CREATE DATABASE flashcard_db;
GO

USE flashcard_db;
GO

-- Bảng Users
CREATE TABLE Users (
    user_id INT IDENTITY PRIMARY KEY,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password NVARCHAR(100) NOT NULL,
    name NVARCHAR(100) NOT NULL
);
GO

-- Bảng Categories
CREATE TABLE Categories (
    category_id INT IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    category_name NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_User_Category UNIQUE (user_id, category_name),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
GO

-- Bảng Decks
CREATE TABLE Decks (
    deck_id INT IDENTITY PRIMARY KEY,
    category_id INT NOT NULL,
    deck_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    CONSTRAINT FK_Decks_Categories FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
        ON DELETE NO ACTION -- tránh multiple cascade path
);
GO

-- Bảng Cards
CREATE TABLE Cards (
    card_id INT IDENTITY PRIMARY KEY,
    deck_id INT NOT NULL,
    front NVARCHAR(255) NOT NULL,
    back NVARCHAR(255) NOT NULL,
    example NVARCHAR(255),
    FOREIGN KEY (deck_id) REFERENCES Decks(deck_id) ON DELETE CASCADE
);
GO

