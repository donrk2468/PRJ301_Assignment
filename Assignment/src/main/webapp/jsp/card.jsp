<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Học Flashcard</title>
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/manage-deck.css">   
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/cardStyle.css">
        
        <style>
            /* Định nghĩa biến màu chủ đạo */
            :root {
                --primary-color: ${not empty themeColor ? themeColor : '#0d6efd'};
                --text-color: #212529;
            }

            /* CSS cho Header: Căn chỉnh nút Quay lại */
            .main-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .header-controls {
                display: flex;
                align-items: center;
                gap: 15px; 
            }
            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* CSS bổ sung trực tiếp để căn chỉnh cỡ chữ hợp lý */
            .japanese-word {
                font-size: 3rem; 
                font-weight: bold;
                text-align: center;
                word-wrap: break-word;
            }
            .meaning {
                font-size: 2rem;
                font-weight: 500;
                text-align: center;
                word-wrap: break-word;
            }
            .example-container {
                margin: 2rem auto; 
                text-align: center;
                font-size: 1.25rem;
                color: #495057;
                font-style: italic;
                line-height: 1.5;
                max-width: 80%;
            }
            .form-label-custom {
                font-weight: 600;
                margin-bottom: 0.5rem;
                display: block;
                color: var(--text-color);
            }
            .form-input-custom {
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ced4da;
                font-size: 1rem;
                width: 100%;
                box-sizing: border-box; 
                transition: border-color 0.2s;
            }
            .form-input-custom:focus {
                outline: none;
                border-color: var(--primary-color);
            }
            .no-card-message {
                font-size: 1.5rem;
                padding: 2rem;
                color: #fffff;
            }
            
        </style>
    </head>
    <body>
        <header class="main-header">
            <div class="main-content">
                <a href="${pageContext.request.contextPath}/homePage" class="logo">Flashcard</a>
                
                <div class="header-controls">
                    <!-- SỬA: Lấy categoryId từ Session Scope -->
                    <a href="${pageContext.request.contextPath}/category" class="back-link" style="margin: 0;">&larr; Quay lại</a>
                    
                    <div class="user-info">
                        <span>Chào, ${sessionScope.username}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Đăng xuất</a>
                    </div>
                </div>

            </div>
        </header>

        <div class="app-container">
            <div class="flashcard-container">
                <div class="flashcard-scene">
                    <c:choose>
                        <c:when test="${not empty card}">
                            <div class="flashcard" id="flashcard">
                                <div class="card-face card-front">
                                    <div class="japanese-word">${card.frontContent}</div>
                                </div>
                                <div class="card-face card-back">
                                    <div class="meaning">${card.backContent}</div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="flashcard" style="cursor: default;">
                                <div class="card-face card-front" style="backface-visibility: visible; flex-direction: column; justify-content: center;">
                                    <div class="no-card-message">${message}</div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <c:if test="${not empty card and not empty card.example}">
                <div class="example-container">
                    Ví dụ: "${card.example}"
                </div>
            </c:if>

            <c:if test="${not empty card}">
                <div class="app-footer">
                    <a href="deck?action=prev" class="action-btn">Trước</a>
                    <span class="card-counter" style="align-self: center; font-weight: bold; font-size: 1.1rem;">
                        ${currentCardNumber} / ${totalCards}
                    </span>
                    <a href="deck?action=next" class="action-btn">Tiếp theo</a>
                </div>
            </c:if>
        </div>

        <c:if test="${not empty card}">
            <div class="app-container" style="margin-top: 2.5rem; padding: 2rem;">
                <h3 style="margin-top: 0; color: var(--primary-color); text-align: center; margin-bottom: 1.5rem;">
                    Chỉnh sửa thẻ này
                </h3>
                <form action="updateCard" method="post" style="display: flex; flex-direction: column; gap: 1.2rem;">
                    <input type="hidden" name="cardId" value="${card.cardId}">
                    <!-- SỬA: Lấy deckId từ Session Scope -->
                    <input type="hidden" name="deckId" value="${sessionScope.currentDeckId}"> 

                    <div style="text-align: left;">
                        <label for="front" class="form-label-custom">Mặt trước (Thuật ngữ)</label>
                        <input type="text" id="front" name="front" value="${card.frontContent}" class="form-input-custom" required>
                    </div>

                    <div style="text-align: left;">
                        <label for="back" class="form-label-custom">Mặt sau (Định nghĩa)</label>
                        <input type="text" id="back" name="back" value="${card.backContent}" class="form-input-custom" required>
                    </div>

                    <div style="text-align: left;">
                        <label for="example" class="form-label-custom">Ví dụ minh họa</label>
                        <input type="text" id="example" name="example" value="${card.example}" class="form-input-custom" placeholder="Nhập câu ví dụ (tùy chọn)">
                    </div>

                    <button type="submit" class="action-btn" style="margin-top: 1rem; width: 100%; padding: 12px; font-size: 1.1rem; background-color: var(--primary-color);">
                        Lưu thay đổi
                    </button>
                </form>
            </div>
        </c:if>

        <div style="margin: 3rem 0; text-align: center;">
            <!-- SỬA: Lấy deckId và categoryId từ Session Scope -->
            <a href="manageDeck?id=${sessionScope.currentDeckId}" class="action-btn" style="background-color: #198754; padding: 12px 30px; font-size: 1.1rem;">
                Quản lý toàn bộ bộ thẻ
            </a>
        </div>

        <script>
            const flashcard = document.getElementById('flashcard');
            if (flashcard) {
                flashcard.addEventListener('click', () => flashcard.classList.toggle('is-flipped'));
            }
        </script>
    </body>
</html>