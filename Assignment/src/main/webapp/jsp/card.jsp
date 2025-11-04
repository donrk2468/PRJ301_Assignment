<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Học Flashcard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/cardStyle.css">
</head>
<body style="--primary-color: ${not empty themeColor ? themeColor : '#0d6efd'}">
    <header class="main-header">
        <a href="${pageContext.request.contextPath}/homePage" class="logo">Flashcard</a>
        <div class="user-info">
            <a href="${pageContext.request.contextPath}/category?id=${categoryId}" class="back-link" style="margin-bottom:0;">&larr; Quay lại</a>
        </div>
    </header>
    <div class="study-container">
        <div class="flashcard-scene">
            <c:choose>
                <c:when test="${not empty card}">
                    <div class="flashcard" id="flashcard">
                        <div class="card-face card-face-front">${card.frontContent}</div>
                        <div class="card-face card-face-back">
                            ${card.backContent}
                        </div>
                    </div>
                    <div type="text" style="font-size: 20px;" name="example" class="form-control">${card.example}<div/>
                    
                </c:when>
                <c:otherwise>
                    <div class="flashcard">
                        <div class="card-face card-face-front">${message}</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="study-controls">
            <a href="deck?action=prev" class="btn btn-secondary">Trước</a>
            <span class="card-counter">${currentCardNumber} / ${totalCards}</span>
            <a href="deck?action=next" class="btn btn-primary">Tiếp theo</a>
        </div>

        <c:if test="${not empty card}">
            <div class="form-container" style="width:100%; margin-top: 2rem;">
                <h3>Chỉnh sửa thẻ này</h3>
                <form action="updateCard" method="post">
                    <input type="hidden" name="cardId" value="${card.cardId}">
                    <input type="hidden" name="deckId" value="${card.deckId}">
                    <div class="form-group">
                        <label>Mặt trước</label>
                        <input type="text" name="front" value="${card.frontContent}" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Mặt sau</label>
                        <input type="text" name="back" value="${card.backContent}" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Ví dụ</label>
                        <input type="text" name="example" value="${card.example}" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button> 
                </form>
            </div>
        </c:if>
        
        <a href="manageDeck?id=${deckId}" class="btn btn-primary" style="margin-top: 2rem; background-color: #198754;">Quản lý toàn bộ bộ thẻ</a>
    </div>

    <script>
        const flashcard = document.getElementById('flashcard');
        if(flashcard) {
            flashcard.addEventListener('click', () => flashcard.classList.toggle('is-flipped'));
        }
    </script>
</body>
</html>