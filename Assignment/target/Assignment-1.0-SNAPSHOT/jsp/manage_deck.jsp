<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý bộ thẻ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/style.css">
</head>
<body>
    <header class="main-header">
        <a href="${pageContext.request.contextPath}/homePage" class="logo">Flashcard</a>
    </header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/deck?id=${deckId}" class="back-link">&larr; Quay lại học</a>
        <h2>Quản lý các thẻ</h2>

        <table class="management-table">
            <thead>
                <tr>
                    <th>Mặt trước</th>
                    <th>Mặt sau</th>
                    <th>Ví dụ (có thể trống)</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${cardList}">
                    <tr>
                        <form action="updateCard" method="post">
                            <td><input type="text" name="front" value="${c.frontContent}" class="form-control" style="width:100%;"></td>
                            <td><input type="text" name="back" value="${c.backContent}" class="form-control" style="width:100%;"></td>
                            <td><input type="text" name="example" value="${c.example}" class="form-control" style="width:100%;"></td>
                            <td class="actions">
                                <input type="hidden" name="cardId" value="${c.cardId}">
                                <input type="hidden" name="deckId" value="${c.deckId}">
                                <input type="hidden" name="source" value="manage">
                                <button type="submit" class="btn btn-primary">Lưu</button>
                                <a href="deleteCard?id=${c.cardId}&deckId=${c.deckId}" onclick="return confirm('Bạn có chắc muốn xóa thẻ này?');" class="btn btn-danger">Xóa</a>
                            </td>
                        </form>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="form-container">
            <h3>Thêm thẻ mới</h3>
            <form action="addCard" method="post" class="form-inline">
                <input type="hidden" name="deckId" value="${deckId}">
                <div class="form-group">
                    <input type="text" name="front" class="form-control" placeholder="Nội dung mặt trước" required>
                </div>
                <div class="form-group">
                    <input type="text" name="back" class="form-control" placeholder="Nội dung mặt sau" required>
                </div>
                <div class="form-group">
                    <input type="text" name="example" class="form-control" placeholder="Nội dung ví dụ" required>
                </div>
                <button type="submit" class="btn btn-primary">Thêm thẻ</button>
            </form>
        </div>
    </div>
</body>
</html>