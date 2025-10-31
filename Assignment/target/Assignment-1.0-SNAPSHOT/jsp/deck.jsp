<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Các bộ thẻ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/src/style.css">
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
            <a href="${pageContext.request.contextPath}/CategoryDirect" class="back-link">&larr; Quay lại các chủ đề</a>
            <h2>Chọn một bộ thẻ để học</h2>

            <%-- Sử dụng c:choose để xử lý cả hai trường hợp --%>
            <c:choose>
<%-- 1. Trường hợp CÓ deck để hiển thị --%>
                <c:when test="${not empty deck}">
                    <div class="item-grid">
                        <c:forEach var="d" items="${deck}">
                            <div class="item-card">
                                 <a href="${pageContext.request.contextPath}/deck?id=${d.deckId}&categoryId=${d.categoryId}" style="text-decoration:none; color:inherit;">
                                     <h3>${d.deckName}</h3>
                                 </a>
                                 <div class="actions">
                                    <form action="updateDeck" method="post">
                                        <input type="hidden" name="deckId" value="${d.deckId}">
                                        <input type="hidden" name="categoryId" value="${d.categoryId}">
                                        <input type="text" name="deckName" value="${d.deckName}" class="form-control" style="padding: 5px; flex-grow: 1;">
                                        <button type="submit" class="btn btn-primary" style="padding: 5px 10px;">Lưu</button>
                                    </form>
                                    <a href="deleteDeck?id=${d.deckId}&categoryId=${d.categoryId}" 
                                       onclick="return confirm('Bạn có chắc muốn xóa bộ thẻ này?');" 
                                       class="btn btn-danger" style="padding: 5px 10px;">
                                        Xóa
                                    </a>
                                 </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <%-- 2. Trường hợp KHÔNG có deck nào (rỗng) --%>
                <c:otherwise>
                    <p style="padding: 2rem; background-color: #e9ecef; border-radius: 8px; text-align: center;">
                        Chủ đề này chưa có bộ thẻ nào. Hãy tạo một bộ thẻ mới bên dưới!
                    </p>
                </c:otherwise>
            </c:choose>

            <%-- Form thêm mới LUÔN LUÔN hiển thị --%>
            <div class="form-container">
                <h3>Thêm bộ thẻ mới</h3>
                <form action="addDeck" method="post" class="form-inline">
                    <%-- Lấy categoryId từ request attribute mà Servlet đã gửi qua --%>
                    <input type="hidden" name="categoryId" value="${categoryId}">
                    <div class="form-group">
                        <input type="text" name="deckName" class="form-control" placeholder="Tên bộ thẻ mới" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Thêm</button>
                </form>
            </div>
        </div>
    </body>
</html>