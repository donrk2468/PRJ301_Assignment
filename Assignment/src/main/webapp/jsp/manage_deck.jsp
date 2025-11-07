<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý bộ thẻ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/manage-deck.css">
</head>
<body>
    <header class="main-header">
        <a href="${pageContext.request.contextPath}/homePage" class="logo">Flashcard</a>
        <div class="user-info">
            <span>Chào, ${sessionScope.username}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Đăng xuất</a>
        </div>
    </header>

    <div class="container">
        <a href="${pageContext.request.contextPath}/deck?id=${deckId}&categoryId=${categoryId}" class="back-link">← Quay lại học</a>
        <h2>Quản lý các thẻ</h2>

        <div class="card-list">
            <c:forEach var="c" items="${cardList}" varStatus="status">
                <div class="card-item">
                    <form action="updateCard" method="post">
                        <div class="card-header-row">
                            <span>THẺ #${status.count}</span>
                        </div>
                        <div class="card-inputs-row">
                            <div class="input-group">
                                <label class="input-label">Mặt trước</label>
                                <input type="text" name="front" value="${c.frontContent}" class="form-control-lg" required>
                            </div>
                            <div class="input-group">
                                <label class="input-label">Mặt sau</label>
                                <input type="text" name="back" value="${c.backContent}" class="form-control-lg" required>
                            </div>
                            <div class="input-group">
                                <label class="input-label">Ví dụ (tùy chọn)</label>
                                <input type="text" name="example" value="${c.example}" class="form-control-lg">
                            </div>
                        </div>
                        <div class="card-actions-row">
                            <input type="hidden" name="cardId" value="${c.cardId}">
                            <input type="hidden" name="deckId" value="${c.deckId}">
                            <input type="hidden" name="source" value="manage">
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="deleteCard?id=${c.cardId}&deckId=${c.deckId}" onclick="return confirm('Xóa thẻ này?');" class="btn btn-danger">Xóa thẻ</a>
                        </div>
                    </form>
                </div>
            </c:forEach>
        </div>

        <div class="add-card-section">
            <h3>+ Thêm thẻ mới</h3>
            <form action="addCard" method="post">
                <input type="hidden" name="deckId" value="${deckId}">
                <div class="card-inputs-row">
                    <div class="input-group">
                        <label class="input-label">Mặt trước</label>
                        <input type="text" name="front" class="form-control-lg" placeholder="Nhập thuật ngữ" required>
                    </div>
                    <div class="input-group">
                        <label class="input-label">Mặt sau</label>
                        <input type="text" name="back" class="form-control-lg" placeholder="Nhập định nghĩa" required>
                    </div>
                    <div class="input-group">
                        <label class="input-label">Ví dụ</label>
                        <input type="text" name="example" class="form-control-lg" placeholder="Nhập ví dụ (nếu có)">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Thêm thẻ này vào bộ</button>
            </form>
        </div>
    </div>
</body>
</html>