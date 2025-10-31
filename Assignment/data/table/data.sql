USE flashcard_db;
GO

-- ******************************************************
-- 1. CHÈN DỮ LIỆU USERS (10 NGƯỜI DÙNG)
-- ******************************************************
-- Xóa bảng mẹ trước khi chèn, vì DB vừa được tạo lại nên TRUNCATE không cần thiết
-- Nhưng nếu bạn chạy lại kịch bản này nhiều lần sau khi tạo DB, nên dùng TRUNCATE.
-- TRUNCATE TABLE Cards; TRUNCATE TABLE Decks; TRUNCATE TABLE Categories; TRUNCATE TABLE Users; 

INSERT INTO Users (email, password, name)
VALUES
    (N'user1@study.com', N'pw_hash_U1', N'Nguyễn Hải An'),         -- 2 Categories
    (N'user2@study.com', N'pw_hash_U2', N'Trần Minh Khang'),        -- 2 Categories
    (N'user3@study.com', N'pw_hash_U3', N'Lê Thị Hương'),          -- 2 Categories
    (N'user4@study.com', N'pw_hash_U4', N'Phạm Quang Huy'),         -- 2 Categories
    (N'user5@study.com', N'pw_hash_U5', N'Đỗ Thanh Mai'),          -- 2 Categories
    (N'user6@study.com', N'pw_hash_U6', N'Vũ Hoàng Nam'),          -- 2 Categories
    (N'user7@study.com', N'pw_hash_U7', N'Hồ Ngọc Thảo'),          -- 2 Categories
    (N'user8@study.com', N'pw_hash_U8', N'Bùi Chí Dũng'),          -- 3 Categories
    (N'user9@study.com', N'pw_hash_U9', N'Tô Kim Tuyến'),          -- 1 Category
    (N'user10@study.com', N'pw_hash_U10', N'Châu Minh Đức');       -- 0 Categories
GO

-- ******************************************************
-- 2. CHÈN DỮ LIỆU CATEGORIES (Tổng cộng 7*2 + 1*3 + 1*1 = 18 Categories)
-- ******************************************************
INSERT INTO Categories (user_id, category_name)
VALUES
    -- User 1 (2 Categories)
    (1, N'Lập Trình JavaScript'), (1, N'Khoa Học Dữ Liệu'),
    
    -- User 2 (2 Categories)
    (2, N'Lịch Sử Thế Giới'), (2, N'Tiếng Tây Ban Nha'),

    -- User 3 (2 Categories)
    (3, N'Kế Toán Cơ Bản'), (3, N'Luật Doanh Nghiệp'),

    -- User 4 (2 Categories)
    (4, N'Thiết Kế Đồ Họa'), (4, N'Nhiếp Ảnh Kỹ Thuật Số'),

    -- User 5 (2 Categories)
    (5, N'Hóa Học Hữu Cơ'), (5, N'Sinh Học Tế Bào'),
    
    -- User 6 (2 Categories)
    (6, N'Mạng Máy Tính Cisco'), (6, N'Hệ Điều Hành Linux'),

    -- User 7 (2 Categories)
    (7, N'Ngữ Pháp Tiếng Anh Nâng Cao'), (7, N'Văn Học Cổ Điển'),

    -- User 8 (3 Categories)
    (8, N'Kanji N2'), (8, N'Ngữ Pháp N2'), (8, N'Từ Vựng N2'), 

    -- User 9 (1 Category)
    (9, N'Thao Tác Excel Cơ Bản');
GO

-- ******************************************************
-- 3. CHÈN DỮ LIỆU DECKS (18 Categories * 3 Decks = 54 Decks)
-- ******************************************************
-- Cần dùng CTE để tìm category_id và lặp 3 lần cho mỗi category
WITH CategoryIDs AS (
    SELECT category_id, category_name
    FROM Categories
)
INSERT INTO Decks (category_id, deck_name, description)
SELECT category_id, category_name + N' - Deck 1', N'Bộ thẻ chủ đề 1' FROM CategoryIDs
UNION ALL
SELECT category_id, category_name + N' - Deck 2', N'Bộ thẻ chủ đề 2' FROM CategoryIDs
UNION ALL
SELECT category_id, category_name + N' - Deck 3', N'Bộ thẻ chủ đề 3' FROM CategoryIDs;
GO

-- ******************************************************
-- 4. CHÈN DỮ LIỆU CARDS (54 Decks * 5 Cards = 270 Cards)
-- ******************************************************
-- Tạo 5 Cards cho mỗi Deck (Tối thiểu 5 Cards/Deck)
-- Giả định deck_id từ 1 đến 54

-- Hàm lặp card
INSERT INTO Cards (deck_id, front, back, example)
SELECT
    d.deck_id,
    d.deck_name + N' - Thuật ngữ ' + CAST(v.n AS NVARCHAR(5)),
    N'Định nghĩa chi tiết cho thuật ngữ ' + CAST(v.n AS NVARCHAR(5)),
    N'Ví dụ minh họa cho thuật ngữ ' + CAST(v.n AS NVARCHAR(5))
FROM Decks d
CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (7), (8)) AS v(n) -- Tạo tối đa 8 cards (thay vì 5-10) để giữ số lượng lớn và đa dạng
WHERE v.n <= (d.deck_id % 6) + 5; -- Tạo từ 5 đến 10 Cards cho mỗi Deck ((1%6)+5=6, (54%6)+5=5, (53%6)+5=8, v.v.)
GO