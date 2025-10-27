<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Card"%> <%-- Đảm bảo import model.Card --%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Flashcard Học Tập</title>
        <link rel="stylesheet" href="css/src/cardStyle.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/footer.css">        

    </head>

    <%
        String themeColor = (String) request.getAttribute("themeColor");
    %>
    <body style="--primary-color: ${not empty themeColor ? themeColor : '#0d6efd'}">

        <%
            Card currentCard = (Card) request.getAttribute("card"); 
            Integer deckId = (Integer) request.getAttribute("deckId");
            Integer currentNumber = (Integer) request.getAttribute("currentCardNumber");
            Integer totalCards = (Integer) request.getAttribute("totalCards");
            String message = (String) request.getAttribute("message");
        %>
        <header class="main-header">
            <main class="main-content">
                <a href="${pageContext.request.contextPath}/homePage" class="logo">Flashcard</a>
                <div class="user-info">
                    <a href="${pageContext.request.contextPath}/CategoryDirect" class="back-link" style="margin-bottom:0;">&larr; Quay lại</a>
                </div>
            </main>
        </header>

        <div class="app-container"> 

            <header class="app-header">
                <h1>Bộ Thẻ: <%= deckId != null ? deckId : "Không xác định" %></h1>
                <div class="controls" style="width: auto;">
                    <div class="card-progress">Thẻ <%= currentNumber %> / <%= totalCards %></div>
                </div>
            </header>

            <main class="flashcard-container">
                <% if (message != null) { %>
                <p style="color: red;"><%= message %></p>
                <% } else if (currentCard != null) { %>

                <div class="flashcard" id="flashcard">
                    <div class="card-face card-front">
                        <p class="japanese-word"><%= currentCard.getFrontContent() %></p>
                    </div>
                    <div class="card-face card-back">
                        <p class="romaji">Mặt sau:</p>
                        <p class="meaning"><%= currentCard.getBackContent() %></p>
                    </div>
                </div>
                <% } else { %>
                <p style="text-align: center;">Không có thẻ.</p>
                <% } %>
            </main>

            <footer class="app-footer">
                <a href="deck?action=prev" class="action-btn">Thẻ trước</a>
                <button id="flip-btn" class="action-btn">Lật thẻ</button>
                <a href="deck?action=next" class="action-btn">Thẻ tiếp</a>
            </footer>
        </div>

        <footer class="footer">
            <div class="footer-container">
                <div class="footer-column about">
                    <h3>Flashcard Tiếng Nhật</h3>
                    <p>Nền tảng giúp bạn học từ vựng tiếng Nhật hiệu quả thông qua các bộ thẻ ghi nhớ thông minh.</p>
                    <p><i class="fa fa-map-marker-alt"></i> Địa chỉ: Hà Nội, Việt Nam</p>
                    <!--<p><i class="fa fa-phone"></i> Điện thoại: </p>-->
                    <p><i class="fa fa-envelope"></i> Email: steamactive123@gmail.com</p>
                </div>

                <div class="footer-column links">
                    <h3>Liên kết nhanh</h3>
                    <ul>
                        <li><a href="#">Về chúng tôi</a></li>
                        <li><a href="#">Câu hỏi thường gặp (FAQ)</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Điều khoản dịch vụ</a></li>
                    </ul>
                </div>

                <div class="footer-column social">
                    <h3>Kết nối với chúng tôi</h3>
                    <div class="social-icons">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                    </div>
                    <h4 class="newsletter-title">Đăng ký nhận tin</h4>
                    <form class="newsletter-form">
                        <input type="email" placeholder="Nhập email của bạn...">
                        <button type="submit">Đăng ký</button>
                    </form>
                </div>
            </div>
            <div class="footer-bottom">
                <p>© 2025 Flashcard Tiếng Nhật. Mọi quyền được bảo lưu.</p>
            </div>
        </footer>
    </div>

    <script>
        // JS để lật thẻ, sử dụng class .is-flipped
        document.getElementById('flip-btn').addEventListener('click', function () {
            document.getElementById('flashcard').classList.toggle('is-flipped');
        });
        document.getElementById('flashcard').addEventListener('click', function () {
            this.classList.toggle('is-flipped');
        });
    </script>
</body>
</html>