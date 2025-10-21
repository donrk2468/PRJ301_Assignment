USE flashcard_db;
GO

-- Xóa dữ liệu cũ từ các bảng theo thứ tự phụ thuộc
DELETE FROM History;
DELETE FROM Cards;
DELETE FROM Decks;
DELETE FROM Categories;
DELETE FROM Users;
GO

-- Thêm 5 users mới
INSERT INTO Users (email, password, name) VALUES
(N'user1@example.com', N'pass1', N'User One'),
(N'user2@example.com', N'pass2', N'User Two'),
(N'user3@example.com', N'pass3', N'User Three'),
(N'user4@example.com', N'pass4', N'User Four'),
(N'user5@example.com', N'pass5', N'User Five');
GO

-- Lấy user_id của 5 users vừa thêm
DECLARE @UserIds TABLE (user_id INT);
INSERT INTO @UserIds (user_id)
SELECT user_id FROM Users WHERE email LIKE 'user%@example.com';

-- Thêm 20 categories chia đều (4 categories mỗi user)
INSERT INTO Categories (user_id, category_name)
VALUES 
((SELECT user_id FROM Users WHERE email = N'user1@example.com'), N'[translate:Từ vựng tiếng Nhật] 1'),
((SELECT user_id FROM Users WHERE email = N'user1@example.com'), N'[translate:Từ vựng tiếng Nhật] 2'),
((SELECT user_id FROM Users WHERE email = N'user1@example.com'), N'[translate:Từ vựng tiếng Nhật] 3'),
((SELECT user_id FROM Users WHERE email = N'user1@example.com'), N'[translate:Từ vựng tiếng Nhật] 4'),

((SELECT user_id FROM Users WHERE email = N'user2@example.com'), N'[translate:Basic English] 1'),
((SELECT user_id FROM Users WHERE email = N'user2@example.com'), N'[translate:Basic English] 2'),
((SELECT user_id FROM Users WHERE email = N'user2@example.com'), N'[translate:Basic English] 3'),
((SELECT user_id FROM Users WHERE email = N'user2@example.com'), N'[translate:Basic English] 4'),

((SELECT user_id FROM Users WHERE email = N'user3@example.com'), N'[translate:Kanji N5] 1'),
((SELECT user_id FROM Users WHERE email = N'user3@example.com'), N'[translate:Kanji N5] 2'),
((SELECT user_id FROM Users WHERE email = N'user3@example.com'), N'[translate:Kanji N5] 3'),
((SELECT user_id FROM Users WHERE email = N'user3@example.com'), N'[translate:Kanji N5] 4'),

((SELECT user_id FROM Users WHERE email = N'user4@example.com'), N'[translate:English Grammar] 1'),
((SELECT user_id FROM Users WHERE email = N'user4@example.com'), N'[translate:English Grammar] 2'),
((SELECT user_id FROM Users WHERE email = N'user4@example.com'), N'[translate:English Grammar] 3'),
((SELECT user_id FROM Users WHERE email = N'user4@example.com'), N'[translate:English Grammar] 4'),

((SELECT user_id FROM Users WHERE email = N'user5@example.com'), N'[translate:Vietnamese Vocabulary] 1'),
((SELECT user_id FROM Users WHERE email = N'user5@example.com'), N'[translate:Vietnamese Vocabulary] 2'),
((SELECT user_id FROM Users WHERE email = N'user5@example.com'), N'[translate:Vietnamese Vocabulary] 3'),
((SELECT user_id FROM Users WHERE email = N'user5@example.com'), N'[translate:Vietnamese Vocabulary] 4');
GO

-- Thêm 4 decks cho mỗi category (tổng 80 decks)
INSERT INTO Decks (category_id, deck_name, description)
SELECT category_id, 'Deck 1', 'Deck example description 1' FROM Categories
UNION ALL
SELECT category_id, 'Deck 2', 'Deck example description 2' FROM Categories
UNION ALL
SELECT category_id, 'Deck 3', 'Deck example description 3' FROM Categories
UNION ALL
SELECT category_id, 'Deck 4', 'Deck example description 4' FROM Categories;
GO

-- Thêm 5 cards cho mỗi deck (400 cards)
DECLARE @Decks TABLE (deck_id INT);
INSERT INTO @Decks (deck_id)
SELECT deck_id FROM Decks;

-- Thêm cards lặp cho từng deck
INSERT INTO Cards (deck_id, front, back, example)
SELECT deck_id, 
    'Front sample ' + CAST(n AS NVARCHAR), 
    'Back sample ' + CAST(n AS NVARCHAR), 
    'Example sentence ' + CAST(n AS NVARCHAR)
FROM @Decks
CROSS JOIN (VALUES (1),(2),(3),(4),(5)) AS Numbers(n);
GO
