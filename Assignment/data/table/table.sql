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

-- Bảng History
CREATE TABLE History (
    history_id INT IDENTITY PRIMARY KEY,
    card_id INT NOT NULL,
    study_date DATETIME DEFAULT GETDATE(),
    is_correct BIT,
    FOREIGN KEY (card_id) REFERENCES Cards(card_id) ON DELETE CASCADE
);
GO

-- Dữ liệu mẫu
INSERT INTO Users (email, password, name)
VALUES (N'test@example.com', N'12345', N'Test User');

INSERT INTO Categories (user_id, category_name)
VALUES (1, N'Tiếng Nhật N5'),
       (1, N'Tiếng Anh Cơ Bản');

INSERT INTO Decks (category_id, deck_name, description)
VALUES (1, N'Kanji N5', N'Cơ bản về chữ Hán'),
       (2, N'English Basics', N'Từ vựng phổ thông');

INSERT INTO Cards (deck_id, front, back, example)
VALUES (1, N'日', N'Ngày / Mặt trời', N'日本 (Nhật Bản)'),
       (1, N'月', N'Tháng / Mặt trăng', N'月曜日 (Thứ Hai)'),
       (2, N'Hello', N'Xin chào', N'Hello world!');

INSERT INTO History (card_id, is_correct)
VALUES (1, 1), (2, 0);
GO
