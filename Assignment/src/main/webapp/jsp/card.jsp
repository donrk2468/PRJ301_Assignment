<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Card"%> <%-- Đảm bảo import model.Card --%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Flashcard Học Tập</title>
        <link rel="stylesheet" href="css/src/homeStyle.css"/> 
    </head>
    
    <% 
        // Lấy themeColor từ request (nếu được set từ Servlet) hoặc cookie
        String themeColor = (String) request.getAttribute("themeColor");
    %>
    <body style="--primary-color: <%= themeColor != null ? themeColor : "#007bff" %>">
        
        <%
            // Cast về model.Card (NHẤT QUÁN VỚI DECKDAO VÀ DECKSERVLET)
            Card currentCard = (Card) request.getAttribute("card"); 
            Integer deckId = (Integer) request.getAttribute("deckId");
            Integer currentNumber = (Integer) request.getAttribute("currentCardNumber");
            Integer totalCards = (Integer) request.getAttribute("totalCards");
            String message = (String) request.getAttribute("message");
        %>
        
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

        <script>
            // JS để lật thẻ, sử dụng class .is-flipped
            document.getElementById('flip-btn').addEventListener('click', function() {
                document.getElementById('flashcard').classList.toggle('is-flipped');
            });
            document.getElementById('flashcard').addEventListener('click', function() {
                this.classList.toggle('is-flipped');
            });
        </script>
    </body>
</html>